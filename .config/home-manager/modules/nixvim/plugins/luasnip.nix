{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins.luasnip.enable = true;

    extraConfigLua = ''
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node

      local function filename_as_is(_, snip)
        return vim.fn.expand("%:t:r")
      end

      -- javascriptreact (.jsx)
      ls.add_snippets("javascriptreact", {
        s("comp", {
          t("const "), f(filename_as_is, {}), t(" = () => {"),
          t({ "", "  return (" }),
          t({ "", "    <div>", "      " }), i(0), t({ "", "    </div>" }),
          t({ "", "  )", "}", "", "export default " }), f(filename_as_is, {}),
        }),

        s("compt", {
          t("const "), f(filename_as_is, {}), t(" = () => {"),
          t({ "", "  return (" }),
          t({ "", "    <div className=\"" }), i(1), t({ "\">", "      " }), i(0), t({ "", "    </div>" }),
          t({ "", "  )", "}", "", "export default " }), f(filename_as_is, {}),
        }),
      })

      -- typescriptreact (.tsx)
      ls.add_snippets("typescriptreact", {
        s("comp", {
          t("const "), f(filename_as_is, {}), t(" = () => {"),
          t({ "", "  return (" }),
          t({ "", "    <div>", "      " }), i(0), t({ "", "    </div>" }),
          t({ "", "  )", "}", "", "export default " }), f(filename_as_is, {}),
        }),

        s("compt", {
          t("const "), f(filename_as_is, {}), t(" = () => {"),
          t({ "", "  return (" }),
          t({ "", "    <div className=\"" }), i(1), t({ "\">", "      " }), i(0), t({ "", "    </div>" }),
          t({ "", "  )", "}", "", "export default " }), f(filename_as_is, {}),
        }),
      })
    '';
  };
}
