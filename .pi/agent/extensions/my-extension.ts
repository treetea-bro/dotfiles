import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";

export default function (pi: ExtensionAPI) {
  // React to events
  pi.on("session_start", async (_event, ctx) => {
    ctx.ui.notify("Extension loaded!", "info");
  });

  pi.on("tool_call", async (event, ctx) => {
    if (event.toolName === "bash" && event.input.command?.includes("rm -rf")) {
      const ok = await ctx.ui.confirm("Dangerous!", "Allow rm -rf?");
      if (!ok) return { block: true, reason: "Blocked by user" };
    }
  });

  // Register a custom tool
  pi.registerTool({
    name: "greet",
    label: "Greet",
    description: "Greet someone by name",
    parameters: Type.Object({
      name: Type.String({ description: "Name to greet" }),
    }),
    async execute(toolCallId, params, signal, onUpdate, ctx) {
      return {
        content: [{ type: "text", text: `Hello, ${params.name}!` }],
        details: {},
      };
    },
  });

  // Register commands
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

  pi.registerCommand("deploy", {
    getArgumentCompletions: (prefix) => {
      const envs = ["dev", "staging", "prod"];
      return envs
        .filter((e) => e.startsWith(prefix))
        .map((e) => ({ value: e, label: e }));
    },
    handler: async (args, ctx) => {
      if (!args) {
        ctx.ui.notify("Please specify an environment", "warning");
        return;
      }
      ctx.ui.notify(`Deploying to ${args}...`, "info");
    },
  });
}
