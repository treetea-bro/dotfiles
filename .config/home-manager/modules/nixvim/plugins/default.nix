{ config, pkgs, ... }:

{
  imports = [
    ./bufdelete.nix
    ./bufferline.nix
    ./cmp.nix
    ./conform.nix
    ./inc-rename.nix
    ./indent-blankline.nix
    ./lazygit.nix
    ./lsp.nix
    ./lualine.nix
    ./mini-pairs.nix
    ./mini-surround.nix
    ./neo-tree.nix
    ./noice.nix
    ./notify.nix
    ./nvim-osc52.nix
    ./persistence.nix
    ./rainbow-delimiters.nix
    ./telescope.nix
    ./treesitter.nix
    ./trouble.nix
    ./web-devicons.nix
    ./which-key.nix
    ./yanky.nix
  ];
}
