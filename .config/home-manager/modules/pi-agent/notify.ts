import { basename } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// OSC payloads must not contain terminal controls or protocol delimiters.
function safeText(value: string): string {
	return value.replace(/[\x00-\x1f\x7f-\x9f;]/g, " ").slice(0, 120);
}

export function notificationSequence(title: string, body: string): string {
	const heading = safeText(title);
	const message = safeText(body);
	if (process.env.KITTY_WINDOW_ID) {
		return `\x1b]99;i=pi-done:d=0;${heading}\x1b\\\x1b]99;i=pi-done:p=body;${message}\x1b\\`;
	}
	// WezTerm (the current terminal), Ghostty, and iTerm2.
	return `\x1b]777;notify;${heading};${message}\x07`;
}

// Home Manager substitutes an absolute executable path when installing this file.
const notifierPath = "@pi-notifier@";

type Backend = "macos" | "linux" | "terminal";

export function notificationBackend(
	platform = process.platform,
	env: NodeJS.ProcessEnv = process.env,
): Backend {
	// A native notification on the SSH host would not reach the user's desktop.
	if (env.SSH_CONNECTION || env.SSH_CLIENT || env.SSH_TTY) return "terminal";
	if (platform === "darwin") return "macos";
	if (platform === "linux") return "linux";
	return "terminal";
}

export async function sendNotification(
	pi: Pick<ExtensionAPI, "exec">,
	title: string,
	body: string,
): Promise<{ backend: Backend; warning?: string }> {
	const backend = notificationBackend();
	if (backend !== "terminal") {
		const command = notifierPath.startsWith("@")
			? backend === "macos" ? "/usr/bin/osascript" : "notify-send"
			: notifierPath;
		// Pass text as argv, never interpolate it into AppleScript source.
		const args = backend === "macos"
			? ["-e", "on run argv", "-e", "display notification (item 2 of argv) with title (item 1 of argv)", "-e", "end run", title, body]
			: ["--app-name=Pi", "--", title, body];
		try {
			const result = await pi.exec(command, args, { timeout: 5000 });
			if (result.code === 0 && !result.killed) return { backend };
			const detail = safeText(result.stderr.trim()) || `exit ${result.code}`;
			process.stdout.write(notificationSequence(title, body));
			return { backend: "terminal", warning: `${backend} 알림 실패 (${detail}). 터미널 알림으로 대체했습니다.` };
		} catch (error) {
			process.stdout.write(notificationSequence(title, body));
			return { backend: "terminal", warning: `${backend} 알림 실패 (${safeText(String(error))}). 터미널 알림으로 대체했습니다.` };
		}
	}
	process.stdout.write(notificationSequence(title, body));
	return { backend };
}

export default function (pi: ExtensionAPI) {
	let enabled = process.env.PI_NOTIFY !== "0";
	let failed = false;

	pi.on("agent_start", () => {
		failed = false;
	});
	pi.on("message_end", (event) => {
		if (event.message.role === "assistant") {
			failed = event.message.stopReason === "error";
		}
	});

	// Unlike agent_end, this excludes intermediate retries/compaction/follow-ups.
	pi.on("agent_settled", async (event, ctx) => {
		if (!enabled || event.aborted || ctx.mode !== "tui" || !process.stdout.isTTY) return;
		const result = await sendNotification(pi,
			`Pi · ${basename(ctx.cwd)}`,
			failed ? "오류로 응답이 종료되었습니다. 결과를 확인해 주세요." : "응답이 완료되었습니다. 결과를 확인해 주세요.",
		);
		if (result.warning && ctx.hasUI) ctx.ui.notify(result.warning, "warning");
	});

	pi.registerCommand("notify", {
		description: "작업 종료 알림: /notify on|off|test|status (현재 세션)",
		handler: async (args, ctx) => {
			const action = args.trim() || "status";
			if (action === "on" || action === "off") {
				enabled = action === "on";
			} else if (action === "test") {
				if (ctx.mode !== "tui" || !process.stdout.isTTY) {
					if (ctx.hasUI) ctx.ui.notify("터미널 대화형 Pi에서 테스트해 주세요.", "warning");
					return;
				}
				const result = await sendNotification(pi, "Pi 알림 테스트", "작업 종료 시 이 알림이 표시됩니다.");
				if (ctx.hasUI) {
					ctx.ui.notify(result.warning ?? `알림 요청 전송: ${result.backend} (실제 표시는 OS 알림 권한·집중 모드에 따라 달라집니다.)`, result.warning ? "warning" : "info");
				}
				return;
			} else if (action !== "status") {
				if (ctx.hasUI) ctx.ui.notify("사용법: /notify on|off|test|status", "warning");
				return;
			}
			if (ctx.hasUI) ctx.ui.notify(`작업 종료 알림: ${enabled ? "켜짐" : "꺼짐"} (자동: ${notificationBackend()}, 현재 세션, /reload 시 초기화)`, "info");
		},
	});
}
