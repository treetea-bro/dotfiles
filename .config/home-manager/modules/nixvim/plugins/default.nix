{ config, pkgs, ... }:

{
  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./telescope.nix
    ./which-key.nix
  ];
}
