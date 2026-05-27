{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
      };
      indent.enable = true;
    };
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      json
      lua
      markdown
      nix
      regex
      toml
      vim
      vimdoc
      xml
      yaml

      python
      # TypeScript/JavaScript
      typescript
      javascript
      tsx
      jsdoc

      # 웹 개발
      html
      css
      scss
      vue
      svelte

      dockerfile
      gitignore
      sql

      go
      gomod
      gosum
      gowork
    ];
    };
  };

  # nvim-treesitter-grammars 의 일부 쿼리(nix, javascript 등)가 레거시
  # `#is-not? local` predicate 를 사용하지만 neovim 0.12 / nvim-treesitter main
  # 에는 핸들러가 없어 버퍼 하이라이트 시 "No handler for is-not?" 에러가 발생한다.
  # 해당 predicate 를 직접 등록해 에러를 막는다.
  programs.nixvim.extraConfigLua = ''
    vim.treesitter.query.add_predicate("is-not?", function() return true end, { force = true })
    vim.treesitter.query.add_predicate("is?", function() return false end, { force = true })
  '';
}
