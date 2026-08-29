{ config, pkgs, ... }:

{
  programs.fzf = {
		enable = true;
		# atuin owns Ctrl-R; disable fzf's history widget to avoid the conflict
		historyWidget.command = "";
  };
}
