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
    ];
    };
  };
}

