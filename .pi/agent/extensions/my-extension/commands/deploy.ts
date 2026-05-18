import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export function registerDeployCommand(pi: ExtensionAPI) {
  pi.registerCommand("deploy", {
    getArgumentCompletions: (prefix) => {
      const envs = ["dev", "staging", "prod"];
      return envs
        .filter((env) => env.startsWith(prefix))
        .map((env) => ({ value: env, label: env }));
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
