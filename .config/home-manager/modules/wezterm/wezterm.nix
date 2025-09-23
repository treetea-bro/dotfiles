{ config, pkgs, lib, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = # lua
      ''
      local wezterm = require("wezterm")
      local config = wezterm.config_builder()

      config.unix_domains = {
        {
          name = "workspace",
        },
      }

      config.default_gui_startup_args = { "connect", "workspace" }

      config.leader = { key = 'l', mods = 'SUPER', timeout_milliseconds = 2000 }

      config.keys = {
        {
          key = "l",
          mods = "SUPER",
          action = wezterm.action.Nop,
        },
        {
          key = "d",
          mods = "LEADER",
          action = wezterm.action.DetachDomain("CurrentPaneDomain"),
        },
        {
          key = "a",
          mods = "LEADER",
          action = wezterm.action_callback(function(window, pane)
            local current_domain = pane:get_domain_name()
            if current_domain == "workspace" then
              window:toast_notification("Info", "Already connected to mux server", nil, 2000)
            else
              window:perform_action(wezterm.action.AttachDomain("workspace"), pane)
            end
          end),
        },
        {
          key = "w",
          mods = "LEADER",
          action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
        },
        {
          key = "n",
          mods = "LEADER",
          action = wezterm.action.PromptInputLine {
            description = "Enter workspace name:",
            action = wezterm.action_callback(function(window, pane, line)
              if line then
                window:perform_action(
                  wezterm.action.SwitchToWorkspace { name = line },
                  pane
                )
              end
            end),
          },
        },
        {
          key = "r",
          mods = "LEADER",
          action = wezterm.action.PromptInputLine {
            description = "Rename workspace to:",
            action = wezterm.action_callback(function(window, pane, line)
              if line then
                wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
              end
            end),
          },
        },

        {
          key = "-",
          mods = "LEADER",
          action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
        },
        {
          key = "|",
          mods = "LEADER",
          action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },

        {
          key = "h",
          mods = "LEADER",
          action = wezterm.action.ActivatePaneDirection("Left"),
        },
        {
          key = "j",
          mods = "LEADER",
          action = wezterm.action.ActivatePaneDirection("Down"),
        },
        {
          key = "k",
          mods = "LEADER",
          action = wezterm.action.ActivatePaneDirection("Up"),
        },
        {
          key = "l",
          mods = "LEADER",
          action = wezterm.action.ActivatePaneDirection("Right"),
        },
      }

      -- 상태바에 도메인과 워크스페이스 표시
      wezterm.on("update-right-status", function(window, pane)
        local workspace = window:active_workspace()
        local domain = pane:get_domain_name()
        local status = string.format(" [%s] %s ", domain, workspace)

        window:set_right_status(wezterm.format({
          { Foreground = { Color = domain == "workspace" and "#a3be8c" or "#ebcb8b" } },
          { Background = { Color = "#2e3440" } },
          { Text = status },
        }))
      end)

      -- 윈도우 종료 확인 설정 (mux 세션 보호)
      config.window_close_confirmation = "NeverPrompt"
      config.skip_close_confirmation_for_processes_named = {
        "bash", "sh", "zsh", "fish", "tmux", "nu", "cmd", "pwsh", "powershell"
      }

      config.default_prog = { "${pkgs.fish}/bin/fish", "--login" }

      config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
      config.cursor_thickness = "0.1cell"
      config.inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.7,
      }

      local colors = {
        bg = "#0E1419",
        black = "#000000",
        dark_lilac = "#6D5978",
        lilac = "#BAA0E8",
      }

      config.window_frame = {
        font = wezterm.font("FiraCode Nerd Font", { weight = "DemiBold" }),
        active_titlebar_bg = colors.black,
        inactive_titlebar_bg = colors.black,
      }

      config.hyperlink_rules = wezterm.default_hyperlink_rules()
      table.insert(config.hyperlink_rules, {
        regex = [[(^|(?<=[\[(\s'"]))([0-9A-Za-z][-0-9A-Za-z]{0,38})/([A-Za-z0-9_.-]{1,100})((?=[])\s'".!?])|$)]],
        format = "https://www.github.com/$2/$3/",
      })

      -- 폰트 설정
      local ligature_features = {
        "calt", "clig", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "ssty", "zero",
      }

      config.font = wezterm.font_with_fallback({
        {
          family = "FiraCode Nerd Font",
          weight = "Regular",
          stretch = "Normal",
          style = "Normal",
          harfbuzz_features = ligature_features,
        },
      })
      config.font_size = 16.00
      config.line_height = 1.16
      config.warn_about_missing_glyphs = true
      config.freetype_load_target = "HorizontalLcd"

      config.underline_position = -6
      config.underline_thickness = "250%"

      local brightness = 1
      local backgrounds_path = ""
      local os_type = os.getenv("OS") or os.getenv("OSTYPE")
      if os_type and os_type:lower():match("windows") then
        brightness = 0.5
        config.text_background_opacity = 0.7
        config.default_domain = "WSL:Ubuntu-24.04"
        backgrounds_path = os.getenv("USERPROFILE") .. "/.config/wezterm/backgrounds/stars.jpg"
        config.color_scheme_dirs = { os.getenv("USERPROFILE") .. "/.config/wezterm/colors/PecoArcade.toml" }
      else
        brightness = 0.35
        config.text_background_opacity = 0.6
        backgrounds_path = os.getenv("HOME") .. "/.config/wezterm/backgrounds/stars.jpg"
      end

      config.color_scheme = "PecoArcade"
      config.background = {
        {
          source = {
            File = {
              path = backgrounds_path,
            },
          },
          opacity = 1,
          width = "100%",
          hsb = { brightness = brightness },
        },
      }

      return config
    '';
  };

  xdg.configFile = {
    "wezterm/backgrounds/stars.jpg".source = ./backgrounds/stars.jpg;
    "wezterm/colors/PecoArcade.toml".source = ./colors/PecoArcade.toml;
  };

  home.activation.wezterm-setup = lib.mkIf pkgs.stdenv.isDarwin (
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -e "/Applications/WezTerm.app" ]; then
        $DRY_RUN_CMD ln -sf ~/.nix-profile/Applications/WezTerm.app /Applications/WezTerm.app
      fi
    ''
  );
}
