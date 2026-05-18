import type {
  ExtensionCommandContext,
  Theme,
} from "@earendil-works/pi-coding-agent";
import { DynamicBorder } from "@earendil-works/pi-coding-agent";
import {
  Container,
  matchesKey,
  Text,
  truncateToWidth,
  wrapTextWithAnsi,
} from "@earendil-works/pi-tui";

export async function showSystemPromptViewer(
  prompt: string,
  ctx: ExtensionCommandContext,
) {
  await ctx.ui.custom<void>((tui, theme, _keybindings, done) => {
    const viewer = new ScrollableTextViewer("System Prompt", prompt, theme, done);

    return {
      render: (width: number) => viewer.render(width),
      invalidate: () => viewer.invalidate(),
      handleInput: (data: string) => {
        viewer.handleInput(data);
        tui.requestRender();
      },
    };
  });
}

class ScrollableTextViewer {
  private scroll = 0;
  private cachedWidth?: number;
  private cachedLines?: string[];

  constructor(
    private readonly title: string,
    private readonly content: string,
    private readonly theme: Theme,
    private readonly done: () => void,
  ) {}

  handleInput(data: string): void {
    const viewportHeight = this.getViewportHeight();
    const maxScroll = this.getMaxScroll();

    if (
      matchesKey(data, "escape") ||
      matchesKey(data, "return") ||
      data === "q"
    ) {
      this.done();
      return;
    }

    if (matchesKey(data, "up") || data === "k") {
      this.scroll = Math.max(0, this.scroll - 1);
    } else if (matchesKey(data, "down") || data === "j") {
      this.scroll = Math.min(maxScroll, this.scroll + 1);
    } else if (matchesKey(data, "pageup") || matchesKey(data, "ctrl+u")) {
      this.scroll = Math.max(0, this.scroll - viewportHeight);
    } else if (
      matchesKey(data, "pagedown") ||
      matchesKey(data, "ctrl+d") ||
      data === " "
    ) {
      this.scroll = Math.min(maxScroll, this.scroll + viewportHeight);
    } else if (matchesKey(data, "home") || data === "g") {
      this.scroll = 0;
    } else if (matchesKey(data, "end") || data === "G") {
      this.scroll = maxScroll;
    }
  }

  render(width: number): string[] {
    const viewportHeight = this.getViewportHeight();
    const innerWidth = Math.max(20, width - 4);
    const wrapped = this.getWrappedLines(innerWidth);
    const maxScroll = Math.max(0, wrapped.length - viewportHeight);
    this.scroll = Math.min(this.scroll, maxScroll);

    const visible = wrapped.slice(this.scroll, this.scroll + viewportHeight);
    while (visible.length < viewportHeight) visible.push("");

    const container = new Container();
    const border = new DynamicBorder((s: string) => this.theme.fg("accent", s));
    const range =
      wrapped.length === 0
        ? "0/0"
        : `${Math.min(this.scroll + 1, wrapped.length)}-${Math.min(
            this.scroll + viewportHeight,
            wrapped.length,
          )}/${wrapped.length}`;

    container.addChild(border);
    container.addChild(
      new Text(
        this.theme.fg("accent", this.theme.bold(`${this.title} `)) +
          this.theme.fg("dim", range),
        1,
        0,
      ),
    );
    container.addChild(new Text(visible.join("\n"), 1, 0));
    container.addChild(
      new Text(
        this.theme.fg(
          "dim",
          "↑↓/j/k scroll • PgUp/PgDn page • Home/End top/bottom • q/Esc/Enter close",
        ),
        1,
        0,
      ),
    );
    container.addChild(border);

    return container.render(width).map((line) => truncateToWidth(line, width));
  }

  invalidate(): void {
    this.cachedWidth = undefined;
    this.cachedLines = undefined;
  }

  private getWrappedLines(width: number): string[] {
    if (this.cachedLines && this.cachedWidth === width) {
      return this.cachedLines;
    }

    const lines = this.content.split("\n").flatMap((line) => {
      const wrapped = wrapTextWithAnsi(line.length > 0 ? line : " ", width);
      return wrapped.length > 0 ? wrapped : [""];
    });

    this.cachedWidth = width;
    this.cachedLines = lines;
    return lines;
  }

  private getViewportHeight(): number {
    const terminalRows = process.stdout.rows ?? 40;
    return Math.max(8, Math.min(terminalRows - 10, 40));
  }

  private getMaxScroll(): number {
    const width = Math.max(20, (process.stdout.columns ?? 80) - 4);
    return Math.max(
      0,
      this.getWrappedLines(width).length - this.getViewportHeight(),
    );
  }
}
