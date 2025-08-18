{ config, pkgs, ... }:

{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<C-s>";
      action = "<cmd>w<cr>";
      options.desc = "Save file";
    }

    {
      mode = "n";
      key = "<C-h>";
      action = "<cmd>wincmd h<cr>";
      options.desc = "Move to left window";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<cmd>wincmd l<cr>";
      options.desc = "Move to right window";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<cmd>wincmd j<cr>";
      options.desc = "Move to bottom window";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<cmd>wincmd k<cr>";
      options.desc = "Move to top window";
    }
    
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<cr>";
      options.desc = "Delete current buffer";
    }
    {
      mode = "n";
      key = "<leader>bo";
      action = "<cmd>%bd|e#|bd#<cr>";
      options.desc = "Delete other buffers";
    }
    {
      mode = "n";
      key = "<leader>bl";
      action = "<cmd>1,.-1bd<cr>";
      options.desc = "Delete buffers to the left";
    }
    {
      mode = "n";
      key = "<leader>br";
      action = "<cmd>.+1,$bd<cr>";
      options.desc = "Delete buffers to the right";
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>bnext<cr>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>bprev<cr>";
      options.desc = "Previous buffer";
    }

    {
      mode = "v";
      key = ">";
      action = ">gv";
      options.desc = "Indent and reselect";
    }
    {
      mode = "v";
      key = "<";
      action = "<gv";
      options.desc = "Outdent and reselect";
    }
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move selection down";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move selection up";
    }
  ];
}
