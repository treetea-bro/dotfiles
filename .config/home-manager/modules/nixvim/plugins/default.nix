{ config, pkgs, ... }:

{
  imports = [
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
    ./persistence.nix
    ./rainbow-delimiters.nix
    ./telescope.nix
    ./treesitter.nix
    ./trouble.nix
    ./which-key.nix
    ./yanky.nix
  ];
}
