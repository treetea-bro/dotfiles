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
                  updateImportsOnFileMove.enabled = "always";
                  # preferences = {
                  #   importModuleSpecifier = "relative";
                  #   quoteStyle = "single";
                  #   allowRenameOfImportPath = true;
                  # };
                  suggest = {
                    completeFunctionCalls = true;
                    # completeUnimported = true;
                    # autoImports = true;
                    # includePackageJsonAutoImports = "auto";
                    # classMemberSnippets = { enabled = true; };
                    # objectLiteralMethodSnippets = { enabled = true; };
                  };
                  inlayHints = {
                    parameterNames.enabled = "all";
                    parameterTypes.enabled = true;
                    functionLikeReturnTypes.enabled = false;
                    variableTypes.enabled = false;
                    propertyDeclarationTypes.enabled = true;
                    enumMemberValues.enabled = true;
                  };

                  # implementationsCodeLens = { enabled = true; };
                  # referencesCodeLens = { enabled = true; };
                };
              };
            };
          };
          biome = {
              enable = true;
              # nixpkgs biome 쓰되, 로컬 node_modules biome이 있으면 그거 우선
              packageFallback = true;
              filetypes = [
                "javascript" "javascriptreact"
                "typescript" "typescriptreact"
                "json" "css" "html" "markdown"
              ];

              rootMarkers = [ "biome.json" "package.json" ".git" ];
          };
          tailwindcss.enable = true;
          nil_ls.enable = true;
          basedpyright = {
            enable = true;
            settings = {
              basedpyright = {
                analysis = {
                  autoSearchPaths = true;
                  typeCheckingMode = "basic";
                  useLibraryCodeForTypes = true;
                  inlayHints = {
                    callArgumentNames = true;
                    functionReturnTypes = true;
                    variableTypes = false;
                    genericTypes = true;
                  };
                };
              };
            };
          };
          ruff = {
            enable = true;
            extraOptions.capabilities = {
              textDocument = {
                hover = {
                  dynamicRegistration = false;
                };
              };
            };
          };
          dockerls.enable = true;
          docker_compose_language_service.enable = true;
        };

        keymaps = {
          lspBuf = {
            "K" = "hover";
            "<A-k>" = "signature_help";

            "<leader>ca" = "code_action";
          };
        };
      };
    };
  };
}
