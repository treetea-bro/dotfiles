{ config, ... }:

{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;

    grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
      bash
      c
      cpp
      cuda
      diff
      fish
      json
      lua
      make
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
      proto
      rust
      sql

      go
      gomod
      gosum
      gowork
    ];
  };
}
