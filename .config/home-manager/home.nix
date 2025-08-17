{ config, pkgs, ... }:

{
  home.username = "peco";
  home.homeDirectory = "/Users/peco";

  home.stateVersion = "25.05";

  home.file.".ipython/profile_default/ipython_config.py".text = ''
    c.TerminalInteractiveShell.editing_mode = 'vi'
  '';

  home.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    v = "nvim";

    # git
    g = "git";
    lg = "lazygit";

    # eza
    l = "eza --long --icons --color --hyperlink --git-ignore";
    ll = "eza --long --icons --color --hyperlink";
    lla = "eza -la --icons --color --hyperlink";
    lt = "eza --long --tree --icons --color --hyperlink";
    lta = "eza -la --tree --icons --color --hyperlink";

    # nix
    nd = "nix develop -c $SHELL";
    ndo = "nix develop --offline --command $SHELL";
    ncg = "nix-collect-garbage";
  };

  home.packages = with pkgs; [];

  home.file = { };

  home.sessionVariables = {
    SHELL = "${pkgs.fish}/bin/fish";
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
