{ config, pkgs, lib, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      local config = wezterm.config_builder()

      config.default_prog = { "${pkgs.fish}/bin/fish", "--login" }

      local mux = wezterm.mux

      -- Maximize the window on startup
      wezterm.on("gui-startup", function()
        local tab, pane, window = mux.spawn_window({})
        window:gui_window():maximize()
      end)

      -- Remove extra space.
      config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

      -- Cursor.
      config.cursor_thickness = "0.1cell"

      config.inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.7,
      }

      -- Support for undercurl, etc.
      -- config.term = "wezterm"

      local colors = {
        bg = "#0E1419",
        black = "#000000",
        dark_lilac = "#6D5978",
        lilac = "#BAA0E8",
      }

      -- Tab bar.
      config.hide_tab_bar_if_only_one_tab = true
      config.window_frame = {
        font = wezterm.font("FiraCode Nerd Font", { weight = "DemiBold" }),
        active_titlebar_bg = colors.black,
        inactive_titlebar_bg = colors.black,
      }

      -- Use the defaults as a base.  https://wezfurlong.org/wezterm/config/lua/config/hyperlink_rules.html
      config.hyperlink_rules = wezterm.default_hyperlink_rules()

      table.insert(config.hyperlink_rules, {
        -- https://github.com/shinnn/github-username-regex  https://stackoverflow.com/a/64147124/5353461
        regex = [[(^|(?<=[\[(\s'"]))([0-9A-Za-z][-0-9A-Za-z]{0,38})/([A-Za-z0-9_.-]{1,100})((?=[])\s'".!?])|$)]],
        --  is/good  0valid0/-_.reponname  /bad/start  -bad/username  bad/end!  too/many/parts -bad/username
        --  [wraped/name] (aa/bb) 'aa/bb' "aa/bb"  end/punct!  end/punct.
        format = "https://www.github.com/$2/$3/",
        -- highlight = 0,  -- highlight this regex match group, use 0 for all
      })

      --
      -- Fonts
      --
      -- https://wezfurlong.org/wezterm/config/lua/wezterm/font.html
      -- https://wezfurlong.org/wezterm/config/lua/config/font_rules.html
      -- wezterm ls-fonts
      -- wezterm ls-fonts --list-system

      -- Monaspace:  https://monaspace.githubnext.com/
      -- @see  https://gist.github.com/ErebusBat/9744f25f3735c1e0491f6ef7f3a9ddc3

      -- @see https://github.com/githubnext/monaspace#coding-ligatures
      local ligature_features = {
        -- @see https://learn.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-calt
        "calt", -- context alternatives
        -- @see https://learn.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-clig
        "clig", -- contextual ligatures
        "liga", -- ligatures
        "dlig", -- discretionary ligatures
        "ss01", -- ss01: ligatures related to the equals glyph like != and ===.
        "ss02", -- ss02: ligatures related to the greater than or less than operators.
        "ss03", -- ss03: ligatures related to arrows like -> and =>.
        "ss04", -- ss04: ligatures related to markup, like </ and />.
        "ss05", -- ss05: ligatures related to the F# programming language, like |>.
        "ss06", -- ss06: ligatures related to repeated uses of # such as ## or ###.
        "ss07", -- ss07: ligatures related to the asterisk like ***.
        "ss08", -- ss08: ligatures related to combinations like .= or .-.
        "ssty", -- math script style alternatives
        "zero", -- slashed zero
      }

      local function isNil(param)
        return param == nil
      end

      local function orDefault(param, fallback)
        if isNil(param) then
          return fallback
        end

        return param
      end

      local defaultFontProperties = {
        weight = "Regular",
        stretch = "Normal",
        style = "Normal",
        harfbuzz_features = ligature_features,
      }

      local function font_config()
        local p = orDefault(defaultFontProperties)

        return {
          family = "FiraCode Nerd Font",
          weight = p.weight or "Regular",
          stretch = p.stretch or "Normal",
          style = p.style or "Normal",
          harfbuzz_features = ligature_features,
        }
      end

      config.font = wezterm.font_with_fallback({
        -- "Monaspace Radon",
        font_config(),
        -- "JetBrains Mono",
        -- "Noto Color Emoji",
        -- 'Operator Mono Lig',
        -- 'Monoid',
        -- 'Monoisome',
        -- 'Menlo',
        -- 'Hack',
        -- 'JetBrains Mono',
        -- 'monospace',
      })

      config.font_size = 16.00
      config.line_height = 1.16
      config.warn_about_missing_glyphs = true

      -- @see https://wezfurlong.org/wezterm/config/lua/config/freetype_load_target.html
      config.freetype_load_target = "HorizontalLcd"

      -- This is where you actually apply your config choices

      -- For example, changing the color scheme:
      -- config.color_scheme = "Material (base16)"
      -- config.color_scheme = "MaterialDarker"
      -- config.color_scheme = "Material Darker (base16)"
      -- config.color_scheme = "materialdesigncolors"
      -- config.color_scheme = "Mikado (terminal.sexy)"
      -- config.color_scheme = "Hardcore"
      -- config.color_scheme = "Codeschool (dark) (terminal.sexy)"

      local misc = {
        adjust_window_size_when_changing_font_size = false,
        check_for_updates = true,
        check_for_updates_interval_seconds = 86400,
        enable_scroll_bar = true,
        enable_kitty_keyboard = false, -- @see https://github.com/wez/wezterm/issues/3731
        enable_csi_u_key_encoding = false, -- @see https://github.com/wez/wezterm/issues/3731
        exit_behavior = "CloseOnCleanExit", -- Use 'Hold' to not close
        hide_tab_bar_if_only_one_tab = true,
        initial_cols = 140,
        initial_rows = 40,
        quote_dropped_files = "Posix",
        switch_to_last_active_tab_when_closing_tab = true,
        use_fancy_tab_bar = true,
        window_decorations = "RESIZE",
        -- macos_window_background_blur = 40,
        -- macos_window_background_blur = 50,
        -- window_background_opacity = 0.92,
        -- window_background_opacity = 0.78,
        -- window_background_opacity = 0.20,

        audible_bell = "Disabled",
        visual_bell = {
          fade_out_function = "EaseOut",
          fade_in_duration_ms = 75,
          fade_out_duration_ms = 150,
          target = "CursorColor",
        },
      }

      for k, v in pairs(misc) do
        config[k] = v
      end

      -- Make underlines thicker
      config.underline_position = -6
      config.underline_thickness = "250%"

      -- @see https://wezfurlong.org/wezterm/config/lua/wezterm/permute_any_mods.html?h=mouse_bindings
      -- config.mouse_bindings = {
      -- 	-- This will disable the default click to open URL behavior
      -- 	{
      -- 		event = { Up = { streak = 1, button = "Left" } },
      -- 		mods = "NONE",
      -- 		action = "Nop",
      -- 	},
      -- 	-- Ctrl-click will open the link under the mouse cursor
      -- 	{
      -- 		event = { Up = { streak = 1, button = "Left" } },
      -- 		mods = "SUPER",
      -- 		action = wezterm.action.OpenLinkAtMouseCursor,
      -- 	},
      -- }
      --
      -- wezterm.on("format-tab-title", function(tab)
      -- 	-- Get the process name.
      -- 	local process = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
      --
      -- 	-- Current working directory.
      -- 	local cwd = tab.active_pane.current_working_dir
      -- 	cwd = cwd and string.format("%s ", cwd.file_path:gsub(os.getenv("HOME"), "~")) or ""
      --
      -- 	-- Format and return the title.
      -- 	return string.format("(%d %s) %s", tab.tab_index + 1, process, cwd)
      -- end)

      config.keys = {
        -- Disable ctrl - / ctrl = so that we can use them in Vim
        { key = "-", mods = "CTRL", action = wezterm.action.Nop },
        { key = "=", mods = "CTRL", action = wezterm.action.Nop },
      }

      -- @see https://github.com/folke/zen-mode.nvim#wezterm
      wezterm.on("user-var-changed", function(window, pane, name, value)
        local overrides = window:get_config_overrides() or {}
        if name == "ZEN_MODE" then
          local incremental = value:find("+")
          local number_value = tonumber(value)
          if incremental ~= nil then
            while number_value > 0 do
              window:perform_action(wezterm.action.IncreaseFontSize, pane)
              number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
          elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
          else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
          end
        end
        window:set_config_overrides(overrides)
      end)

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
        -- config.default_prog = { "~/.nix-profile/bin/fish" }
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
              -- speed = 0.2, # gif
            },
          },
          opacity = 1, -- Warning : if under 1, macOS opacity transparent
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

  home.activation.wezterm-setup = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -e "/Applications/WezTerm.app" ]; then
      $DRY_RUN_CMD ln -sf ~/.nix-profile/Applications/WezTerm.app /Applications/WezTerm.app
    fi
  '';
}
