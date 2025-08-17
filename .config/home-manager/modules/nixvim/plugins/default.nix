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
    ./treesitter.nix
    ./which-key.nix
  ];
}
