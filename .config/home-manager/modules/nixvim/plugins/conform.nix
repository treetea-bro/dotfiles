{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    # conform 은 포맷터 바이너리를 직접 가져오지 않으므로 nvim PATH 에 직접 넣는다.
    # biome 는 lsp.nix 의 packageFallback 때문에 LSP 쪽에서도 PATH 조회로 해결된다.
    extraPackages = with pkgs; [
      biome
      nixfmt
      shellcheck
      shellharden
      shfmt
    ];

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
            nix = [ "nixfmt" ];
            python = [ "ruff_fix" "ruff_format" "ruff_organize_imports" ];
            rust = [ "rustfmt" ];
            go = [ "goimports" "gofumpt" ];
            # biome 가 포맷을 지원하는 파일타입만 등록한다.
            # (html / markdown / yaml 은 biome 2.x 가 아직 포맷하지 못한다)
            javascript = [ "biome" ];
            typescript = [ "biome" ];
            javascriptreact = [ "biome" ];
            typescriptreact = [ "biome" ];
            css = [ "biome" ];
            json = [ "biome" ];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          format_on_save = {
            lsp_format = "fallback";
            timeout_ms = 2000;
          };
        };
      };
    };
  };
}
