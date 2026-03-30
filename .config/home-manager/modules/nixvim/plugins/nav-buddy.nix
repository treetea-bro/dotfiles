{
  programs.nixvim = {
    plugins.navbuddy = {
      enable = true;
      settings.lsp.auto_attach = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>nv";
        action = "<cmd>Navbuddy<cr>";
        options.desc = "Open Navbuddy";
      }
    ];
  };
}
