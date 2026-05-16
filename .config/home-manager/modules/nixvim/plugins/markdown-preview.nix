{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins.markdown-preview.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<leader>md";
        action = "<cmd>MarkdownPreviewToggle<cr>";
        options.desc = "Toggle Markdown preview";
      }
    ];
  };
}
