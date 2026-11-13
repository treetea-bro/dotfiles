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
	pi.on("agent_settled", (event, ctx) => {
		if (!enabled || event.aborted || ctx.mode !== "tui" || !process.stdout.isTTY) return;
		process.stdout.write(notificationSequence(
			`Pi · ${basename(ctx.cwd)}`,
			failed ? "오류로 응답이 종료되었습니다. 결과를 확인해 주세요." : "응답이 완료되었습니다. 결과를 확인해 주세요.",
		));
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
				process.stdout.write(notificationSequence("Pi 알림 테스트", "작업 종료 시 이 알림이 표시됩니다."));
			} else if (action !== "status") {
				if (ctx.hasUI) ctx.ui.notify("사용법: /notify on|off|test|status", "warning");
				return;
			}
			if (ctx.hasUI) ctx.ui.notify(`작업 종료 알림: ${enabled ? "켜짐" : "꺼짐"} (현재 세션, /reload 시 초기화)`, "info");
		},
	});
}
