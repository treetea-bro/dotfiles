{ config, pkgs, lib, ... }: {

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
    ];

    interactiveShellInit = ''
      set fish_greeting ""

      fish_vi_key_bindings
      atuin init fish | source
      if not set -q tide_left_prompt_items
        tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Vertical --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Dotted --powerline_right_prompt_frame=Yes --prompt_connection_andor_frame_color=Dark --prompt_spacing=Sparse --icons='Many icons' --transient=No
      end
    '';

    functions = {
      ghq = ''
        switch "$argv[1]"
          case clone get
            command ghq $argv
            or return $status
            set -l url $argv[-1]
            set -l name (string replace -r '\.git$' "" -- $url | string replace -r '^.*[:/]([^:/]+/[^/]+)$' '$1')
            set -l path (command ghq list -p -e $name | head -n1)
            if test -n "$path"
              cd $path
            end
          case '*'
            command ghq $argv
        end
      '';
    };
  };
}
