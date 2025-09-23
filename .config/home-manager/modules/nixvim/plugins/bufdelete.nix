{
  programs.nixvim = {
    plugins = {
      bufdelete.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>bd";
        action = "<Cmd>Bdelete<CR>";
        options.desc = "Delete buffer but keep window";
      }
    ];
  };
}
