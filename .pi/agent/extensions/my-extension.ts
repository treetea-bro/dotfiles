import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { registerBasicCommands } from "./my-extension/commands/basic";
import { registerDeployCommand } from "./my-extension/commands/deploy";
import { registerSystemPromptCommand } from "./my-extension/commands/system-prompt";
import { registerSafetyEvents } from "./my-extension/events/safety";
import { registerGreetTool } from "./my-extension/tools/greet";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (_event, ctx) => {
    ctx.ui.notify("Extension loaded!", "info");
  });

  registerSafetyEvents(pi);
  registerGreetTool(pi);
  registerBasicCommands(pi);
  registerSystemPromptCommand(pi);
  registerDeployCommand(pi);
}
