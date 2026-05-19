import type {
  ExtensionAPI,
  ExtensionCommandContext,
} from "@earendil-works/pi-coding-agent";
import { showSystemPromptViewer } from "../ui/system-prompt-viewer";

type CapturedSnapshot = {
  at: string;
  note: string;
  data: unknown;
};

const latestSnapshots: {
  beforeAgentStart?: CapturedSnapshot;
  context?: CapturedSnapshot;
  providerPayload?: CapturedSnapshot;
} = {};

export function registerSystemPromptCommand(pi: ExtensionAPI) {
  registerPromptCaptureEvents(pi);

  pi.registerCommand("system-prompt", {
    description: "Show the current system prompt, active tool definitions, and latest non-conversation model payload",
    handler: async (_args, ctx) => {
      const prompt = ctx.getSystemPrompt();
      const content = [
        "# Pi System Prompt",
        "",
        prompt,
        "",
        formatActiveToolDefinitions(pi),
        "",
        formatCapturedSnapshots(),
      ].join("\n");
      await showSystemPrompt(content, ctx);
    },
  });
}

function registerPromptCaptureEvents(pi: ExtensionAPI): void {
  pi.on("before_agent_start", (event) => {
    latestSnapshots.beforeAgentStart = {
      at: new Date().toISOString(),
      note: "before_agent_start event. Raw user prompt/images are redacted; systemPrompt and structured systemPromptOptions are kept.",
      data: redactConversation({
        ...event,
        prompt: "<<user prompt redacted by /system-prompt>>",
        images: event.images ? `<<${event.images.length} user image(s) redacted by /system-prompt>>` : undefined,
      }),
    };
  });

  pi.on("context", async (event) => {
    latestSnapshots.context = {
      at: new Date().toISOString(),
      note: "Pi context messages immediately before provider serialization. user/assistant message content is redacted.",
      data: redactConversation(event.messages),
    };
  });

  pi.on("before_provider_request", (event) => {
    latestSnapshots.providerPayload = {
      at: new Date().toISOString(),
      note: "Final provider request payload immediately before send. user/assistant/model conversation content is redacted.",
      data: redactConversation(event.payload),
    };
  });
}

function formatCapturedSnapshots(): string {
  const lines = [
    "# Captured Non-Conversation Payloads",
    "",
    "These snapshots are captured from Pi hooks. They are the closest extension-visible view of what is sent to the model, excluding user/assistant conversation content.",
    "",
  ];

  lines.push(formatSnapshot("Before Agent Start Hook", latestSnapshots.beforeAgentStart));
  lines.push("");
  lines.push(formatSnapshot("Pi Context Hook", latestSnapshots.context));
  lines.push("");
  lines.push(formatSnapshot("Provider Request Hook", latestSnapshots.providerPayload));

  return lines.join("\n");
}

function formatSnapshot(title: string, snapshot?: CapturedSnapshot): string {
  if (!snapshot) {
    return `## ${title}\n\n(not captured yet; send one prompt after loading the extension, then run /system-prompt again)`;
  }

  return [
    `## ${title}`,
    "",
    `Captured: ${snapshot.at}`,
    `Note: ${snapshot.note}`,
    "",
    "```json",
    stringifyForViewer(snapshot.data),
    "```",
  ].join("\n");
}

function stringifyForViewer(value: unknown): string {
  try {
    return JSON.stringify(value, null, 2) ?? "null";
  } catch (error) {
    return `<<failed to stringify: ${error instanceof Error ? error.message : String(error)}>>`;
  }
}

function redactConversation(value: unknown): unknown {
  if (Array.isArray(value)) {
    return value.map((item) => redactConversation(item));
  }

  if (!value || typeof value !== "object") {
    return value;
  }

  const record = value as Record<string, unknown>;
  const role = typeof record.role === "string" ? record.role.toLowerCase() : undefined;

  if (role === "user" || role === "assistant" || role === "model") {
    return redactRoleMessage(record, role);
  }

  const redacted: Record<string, unknown> = {};
  for (const [key, child] of Object.entries(record)) {
    redacted[key] = redactConversation(child);
  }
  return redacted;
}

function redactRoleMessage(
  message: Record<string, unknown>,
  role: string,
): Record<string, unknown> {
  const redacted: Record<string, unknown> = {};

  for (const [key, value] of Object.entries(message)) {
    if (key === "content" || key === "contents" || key === "parts") {
      redacted[key] = `<<${role} conversation content redacted by /system-prompt>>`;
    } else {
      redacted[key] = redactConversation(value);
    }
  }

  return redacted;
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
