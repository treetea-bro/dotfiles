import type {
  ExtensionAPI,
  ExtensionCommandContext,
} from "@earendil-works/pi-coding-agent";
import { showSystemPromptViewer } from "../ui/system-prompt-viewer";

export function registerSystemPromptCommand(pi: ExtensionAPI) {
  pi.registerCommand("system-prompt", {
    description: "Show the current system prompt in a scrollable viewer",
    handler: async (_args, ctx) => {
      const prompt = ctx.getSystemPrompt();
      await showSystemPrompt(prompt, ctx);
    },
  });
}

async function showSystemPrompt(prompt: string, ctx: ExtensionCommandContext) {
  if (!ctx.hasUI) {
    console.log("=== SYSTEM PROMPT ===");
    console.log(prompt);
    console.log("=== END ===");
    return;
  }

  await showSystemPromptViewer(prompt, ctx);
}
