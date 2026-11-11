{
  pkgs,
  ...
}:

{
  home.stateVersion = "26.11";

  home.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    v = "nvim";
    k = "kubectl";

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
    mkflake = "nix flake init -t ~/.config/home-manager; and gh api /gitignore/templates/Nix --jq .source >> .gitignore; and git add flake.nix .envrc .gitignore; and direnv allow";
  };

  home.file = {
    ".ignore" = {
      text = ''
        !.env*
      '';
    };
    ".ipython/profile_default/ipython_config.py" = {
      text = ''
        c.TerminalInteractiveShell.editing_mode = 'vi'
      '';
    };
  };

  home.sessionVariables = {
    SHELL = "${pkgs.fish}/bin/fish";
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}
