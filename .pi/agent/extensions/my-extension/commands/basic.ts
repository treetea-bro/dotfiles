import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export function registerBasicCommands(pi: ExtensionAPI) {
  pi.registerCommand("bye", {
    description: "Say goodbye and exit pi",
    handler: async (_args, ctx) => {
      ctx.ui.notify("bye seungmin! I love you!", "info");
      ctx.shutdown();
    },
  });

  pi.registerCommand("hello", {
    description: "Say hello",
    handler: async (args, ctx) => {
      ctx.ui.notify(`Hello ${args || "world"}!`, "info");
    },
  });
}
