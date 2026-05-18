import type {
  ExtensionAPI,
  ExtensionCommandContext,
} from "@earendil-works/pi-coding-agent";
import { showSystemPromptViewer } from "../ui/system-prompt-viewer";

export function registerSystemPromptCommand(pi: ExtensionAPI) {
  pi.registerCommand("system-prompt", {
    description: "Show the current system prompt and active tool definitions in a scrollable viewer",
    handler: async (_args, ctx) => {
      const prompt = ctx.getSystemPrompt();
      const content = `${prompt}\n\n${formatActiveToolDefinitions(pi)}`;
      await showSystemPrompt(content, ctx);
    },
  });
}

function formatActiveToolDefinitions(pi: ExtensionAPI): string {
  const activeToolNames = new Set(pi.getActiveTools());
  const tools = pi
    .getAllTools()
    .filter((tool) => activeToolNames.has(tool.name))
    .sort((a, b) => a.name.localeCompare(b.name));

  const lines = [
    "# Active Tool Definitions",
    "",
    `The following ${tools.length} tool definitions are sent to the model separately from the system prompt.`,
  ];

  for (const tool of tools) {
    lines.push(
      "",
      `## ${tool.name}`,
      "",
      `Source: ${tool.sourceInfo.source}`,
      `Path: ${tool.sourceInfo.path}`,
      "",
      "Description:",
      tool.description || "(none)",
      "",
      "Parameters:",
      JSON.stringify(tool.parameters, null, 2),
    );
  }

  return lines.join("\n");
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
