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

      local function filename_as_is()
        return vim.fn.expand("%:t:r")
      end

      -- React 컴포넌트 뼈대. compt 는 className 자리까지 같이 만든다.
      local function component(with_class)
        local open = with_class
          and { t({ "", "    <div className=\"" }), i(1), t({ "\">" }) }
          or { t({ "", "    <div>" }) }

        local nodes = {
          t("const "), f(filename_as_is, {}), t(" = () => {"),
          t({ "", "  return (" }),
        }
        vim.list_extend(nodes, open)
        vim.list_extend(nodes, {
          i(0),
          t({ "", "    </div>" }),
          t({ "", "  )", "}", "", "export default " }), f(filename_as_is, {}),
        })
        return nodes
      end

      for _, ft in ipairs({ "javascriptreact", "typescriptreact" }) do
        ls.add_snippets(ft, {
          s("comp", component(false)),
          s("compt", component(true)),
        })
      end
    '';
  };
}
