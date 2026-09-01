{ config, pkgs, ... }:

{
  programs.nixvim.plugins.blink-cmp = {
    enable = true;

    settings = {
      sources.default = [ "lsp" "path" "snippets" "buffer" ];
      # 커맨드라인 보완은 noice cmdline 팝업과 겹쳐서 끈다.
      sources.cmdline = [ ];

      # luasnip.nix 의 커스텀 스니펫과 friendly-snippets 를 그대로 쓴다.
      snippets.preset = "luasnip";

      keymap = {
        # 'super-tab' 등의 preset 은 insert 모드 <Tab> 을 가져가는데,
        # <Tab> 은 copilot 인라인 제안 수락이 이미 쓰고 있으므로 preset 을 쓰지 않는다.
        preset = "none";
        "<Down>" = [ "select_next" "fallback" ];
        "<Up>" = [ "select_prev" "fallback" ];
        "<CR>" = [ "accept" "fallback" ];
        "<C-Space>" = [ "show" ];
      };

      completion = {
        # nvim-cmp 의 confirm({ select = true }) 처럼 첫 항목을 미리 선택해 둔다.
        list.selection.preselect = true;

        menu = {
          border = "rounded";
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
        };

        documentation = {
          auto_show = true;
          window.border = "rounded";
        };
      };
    };
  };
}
