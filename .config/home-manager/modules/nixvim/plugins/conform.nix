{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            bash = [
              "shellcheck"
              "shellharden"
              "shfmt"
            ];
            python = [ "ruff_fix" "ruff_format" "ruff_organize_imports" ];
            rust = [ "rustfmt" ];
            javascript = [ "biome" ];
            typescript = [ "biome" ];
            javascriptreact = [ "biome" ];
            typescriptreact = [ "biome" ];
            css = [ "biome" ];
            html = [ "biome" ];
            json = [ "biome" ];
            yaml = [ "biome" ];
            markdown = [ "biome" ];
            # javascript = [ "prettier" ];
            # typescript = [ "prettier" ];
            # javascriptreact = [ "prettier" ];
            # typescriptreact = [ "prettier" ];
            # css = [ "prettier" ];
            # html = [ "prettier" ];
            # json = [ "prettier" ];
            # yaml = [ "prettier" ];
            # markdown = [ "prettier" ];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          format_on_save = {
            timeout_ms = 2000;
          };
        };
      };
    };
  };
}
