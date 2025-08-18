{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        servers = {
          vtsls.enable = true;
          tailwindcss.enable = true;
          nil_ls.enable = true;
          pyright.enable = true;
          ruff.enable = true;
          dockerls.enable = true;
          docker_compose_language_service.enable = true;
        };

        keymaps = {
          lspBuf = {
            "K" = "hover";
            "<C-k>" = "signature_help";

            "<leader>ca" = "code_action";
          };
        };
      };
    };
  };
}
