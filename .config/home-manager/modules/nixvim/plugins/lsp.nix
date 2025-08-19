{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;

        servers = {
          vtsls = {
            enable = true;
            extraOptions = {
              settings = {
                typescript = {
                  updateImportsOnFileMove = {
                    enabled = "always";
                  };
                  suggest = {
                    completeFunctionCalls = true;
                  };
                  inlayHints = {
                    parameterNames = {
                      enabled = "all";
                    };
                    parameterTypes = {
                      enabled = true;
                    };
                    functionLikeReturnTypes = {
                      enabled = false;
                    };
                    variableTypes = {
                      enabled = false;
                    };
                    propertyDeclarationTypes = {
                      enabled = true;
                    };
                    enumMemberValues = {
                      enabled = true;
                    };
                  };
                };
              };
            };
          };
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
