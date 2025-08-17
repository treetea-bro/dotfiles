{ config, pkgs, ... }:

{
  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./persistence.nix
    ./telescope.nix
    ./which-key.nix
  ];
}
