import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { registerSystemPromptCommand } from "./my-extension/commands/system-prompt";
// import { registerSafetyEvents } from "./my-extension/events/safety";
// import { registerBasicCommands } from "./my-extension/commands/basic";
// import { registerDeployCommand } from "./my-extension/commands/deploy";
// import { registerGreetTool } from "./my-extension/tools/greet";

export default function (pi: ExtensionAPI) {
  registerSystemPromptCommand(pi);
  // registerSafetyEvents(pi);
  // registerGreetTool(pi);
  // registerBasicCommands(pi);
  // registerDeployCommand(pi);
}
