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
    explain = "gh copilot explain";
    ghce = "gh copilot explain";
    ghcs = "gh copilot suggest";
    help-explain = "gh copilot explain";
    less = "${pkgs.nvimpager}/bin/nvimpager";

    help-suggest = "gh copilot suggest";
    g = "git";
    lg = "lazygit";
    l = "eza --long --icons --color --hyperlink --git-ignore";
    ll = "eza --long --icons --color --hyperlink";
    lla = "eza -la --icons --color --hyperlink";
    lt = "eza --long --tree --icons --color --hyperlink";
    lta = "eza -la --tree --icons --color --hyperlink";
    nd = "nix develop -c $SHELL";
    ndo = "nix develop --offline --command $SHELL";
    ncg = "nix-collect-garbage";
    o = "xdg-open";
    steammount = ''
      udisksctl unmount -b /dev/disk/by-uuid/98bf9471-2174-498f-b8d8-9b918a387ec4 &&
      udisksctl mount -b /dev/disk/by-uuid/98bf9471-2174-498f-b8d8-9b918a387ec4 --options " exec "
    '';
    suggest = "gh copilot suggest";
    v = "nvim";
  };

  home.packages = with pkgs; [];

  home.file = { };

  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
