{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      # 기존 것들...
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
      
      # TypeScript/JavaScript
      typescript
      javascript
      tsx
      jsdoc
      
      # 웹 개발 관련 (필요시 추가)
      html
      css
      scss
      vue
      svelte
      
      # 기타 유용한 것들
      dockerfile
      gitignore
      sql
    ];
    };
  };
}

