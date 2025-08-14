{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # extraLuaPackages = luaPkgs: with luaPkgs; [ luarocks magick jsregexp ];
    # extraPackages = with pkgs; [
    #   clang
    #   ghostscript
    #   hlint
    #   imagemagick
    #   lazygit
    #   lua-language-server
    #   lua51Packages.lua
    #   luajit
    #   manix
    #   mermaid-cli
    #   nginx-language-server
    #   nil
    #   nixd
    #   nixfmt-classic
    #   poppler_utils
    #   tectonic
    #   tree-sitter
    # ];
    # extraPython3Packages = pyPkgs:
    #   with pyPkgs; [
    #     cairosvg # for image rendering
    #     ipykernel
    #     ipython
    #     jupyter-client
    #     matplotlib
    #     numpy
    #     plotly # for image rendering
    #     pnglatex # for image rendering
    #     pylatexenc
    #     pynvim
    #     pyperclip
    #     sympy
    #   ];
    # plugins = with pkgs.vimPlugins; [ neotest-haskell image-nvim ];
    # vimAlias = true;
    # vimdiffAlias = true;
  };
}

