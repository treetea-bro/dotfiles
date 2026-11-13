// Run with: node --experimental-strip-types --test modules/pi-agent/notify.test.mjs
import assert from "node:assert/strict";
import test from "node:test";
import notifyExtension, { notificationBackend, notificationSequence, sendNotification } from "./notify.ts";

async function withRuntime(platform, env, run) {
	const originalPlatform = Object.getOwnPropertyDescriptor(process, "platform");
	const originalEnv = process.env;
	const originalWrite = process.stdout.write;
	const originalTTY = Object.getOwnPropertyDescriptor(process.stdout, "isTTY");
	const output = [];
	Object.defineProperty(process, "platform", { value: platform, configurable: true });
	process.env = env;
	process.stdout.write = (text) => { output.push(text); return true; };
	Object.defineProperty(process.stdout, "isTTY", { value: true, configurable: true });
	try {
		await run(output);
	} finally {
		Object.defineProperty(process, "platform", originalPlatform);
		process.env = originalEnv;
		process.stdout.write = originalWrite;
		if (originalTTY) Object.defineProperty(process.stdout, "isTTY", originalTTY);
		else delete process.stdout.isTTY;
	}
}

function fakePi(exec = async () => ({ code: 0, stderr: "", killed: false })) {
	const handlers = {};
	const commands = {};
	const pi = {
		exec,
		on: (name, handler) => { handlers[name] = handler; },
		registerCommand: (name, command) => { commands[name] = command; },
	};
	return { pi, handlers, commands };
}

const context = (messages, mode = "tui") => ({
	mode, cwd: "/tmp/project", hasUI: true,
	ui: { notify: (message, level) => messages.push({ message, level }) },
});

test("selects a backend automatically, including every SSH marker", () => {
	assert.equal(notificationBackend("darwin", {}), "macos");
	assert.equal(notificationBackend("linux", {}), "linux");
	assert.equal(notificationBackend("win32", {}), "terminal");
	for (const marker of ["SSH_CONNECTION", "SSH_CLIENT", "SSH_TTY"]) {
		assert.equal(notificationBackend("linux", { [marker]: "present" }), "terminal");
	}
	assert.equal(notificationBackend("darwin", { SSH_AUTH_SOCK: "/tmp/agent" }), "macos");
});

for (const [platform, command, expectedArgs] of [
	["darwin", "/usr/bin/osascript", ["-e", "on run argv", "-e", "display notification (item 2 of argv) with title (item 1 of argv)", "-e", "end run", "Title", "Body"]],
	["linux", "notify-send", ["--app-name=Pi", "--", "Title", "Body"]],
]) {
	test(`${platform}: native notification without duplicate OSC`, async () => {
		await withRuntime(platform, {}, async (output) => {
			const calls = [];
			const { pi } = fakePi(async (...args) => {
				calls.push(args);
				return { code: 0, stderr: "", killed: false };
			});
			const result = await sendNotification(pi, "Title", "Body");
			assert.equal(result.warning, undefined);
			assert.deepEqual(calls, [[command, expectedArgs, { timeout: 5000 }]]);
			assert.deepEqual(output, []);
		});
	});
}

test("nonzero exit, timeout, and missing executable fall back to OSC", async () => {
	for (const exec of [
		async () => ({ code: 1, stderr: "No notification daemon", killed: false }),
		async () => ({ code: 0, stderr: "", killed: true }),
		async () => { throw new Error("ENOENT"); },
	]) {
		await withRuntime("linux", {}, async (output) => {
			const result = await sendNotification(fakePi(exec).pi, "Title", "Body");
			assert.equal(result.backend, "terminal");
			assert.ok(result.warning);
			assert.deepEqual(output, [notificationSequence("Title", "Body")]);
		});
	}
});

test("SSH uses terminal notification without executing a native command", async () => {
	await withRuntime("linux", { SSH_TTY: "/dev/pts/0" }, async (output) => {
		const { pi } = fakePi(async () => { assert.fail("must not execute"); });
		assert.deepEqual(await sendNotification(pi, "Title", "Body"), { backend: "terminal" });
		assert.equal(output.length, 1);
	});
});

test("OSC payloads are sanitized and Kitty uses OSC 99", async () => {
	await withRuntime("linux", {}, async () => {
		assert.equal(notificationSequence("a;\x1bb", "c\x07d"), "\x1b]777;notify;a  b;c d\x07");
		process.env.KITTY_WINDOW_ID = "1";
		assert.equal(notificationSequence("Title", "Body"), "\x1b]99;i=pi-done:d=0;Title\x1b\\\x1b]99;i=pi-done:p=body;Body\x1b\\");
	});
});

test("only settled TUI runs notify; errors, toggles, and test command are preserved", async () => {
	await withRuntime("darwin", {}, async () => {
		const calls = [];
		const messages = [];
		const { pi, handlers, commands } = fakePi(async (...args) => {
			calls.push(args);
			return { code: 0, stderr: "", killed: false };
		});
		notifyExtension(pi);
		assert.equal(handlers.agent_end, undefined);
		const ctx = context(messages);
		await handlers.agent_settled({ aborted: true }, ctx);
		for (const mode of ["rpc", "print", "json"]) {
			await handlers.agent_settled({ aborted: false }, context(messages, mode));
		}
		assert.equal(calls.length, 0);
		handlers.agent_start();
		handlers.message_end({ message: { role: "assistant", stopReason: "error" } });
		await handlers.agent_settled({ aborted: false }, ctx);
		assert.match(calls[0][1].at(-1), /오류/);
		handlers.agent_start();
		await handlers.agent_settled({ aborted: false }, ctx);
		assert.match(calls[1][1].at(-1), /완료/);
		await commands.notify.handler("off", ctx);
		await handlers.agent_settled({ aborted: false }, ctx);
		assert.equal(calls.length, 2);
		await commands.notify.handler("test", ctx);
		assert.equal(calls.length, 3);
		await commands.notify.handler("on", ctx);
		await handlers.agent_settled({ aborted: false }, ctx);
		assert.equal(calls.length, 4);
	});
});

test("PI_NOTIFY=0 disables automatic notifications", async () => {
	await withRuntime("darwin", { PI_NOTIFY: "0" }, async () => {
		const { pi, handlers } = fakePi(async () => { assert.fail("disabled"); });
		notifyExtension(pi);
		await handlers.agent_settled({ aborted: false }, context([]));
	});
});
