{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            installRustfmt = true;
          };
          vtsls = {
            enable = true;
            # rootMarkers = [ "tsconfig.json" "package.json" ".git"];
            extraOptions = {
              before_init.__raw = ''
                function(params, config)
                  local root = config.root_dir

                  local node_modules = root .. "/node_modules"
                  local effect_plugin = node_modules .. "/@effect/language-service"

                  config.settings = config.settings or {}
                  config.settings.vtsls = config.settings.vtsls or {}
                  config.settings.vtsls.tsserver = config.settings.vtsls.tsserver or {}

                  config.settings.vtsls.tsserver.globalPlugins = {
                    {
                      name = "@effect/language-service",
                      location = effect_plugin,
                      enableForWorkspaceTypeScriptVersions = true,
                    }
                  }
                end
              '';

              settings = {
                # vtsls = {
                #   # tsdk = "/Users/peco/ghq/bitbucket.org/maymust_ai_sw/effect-app/node_modules/typescript/lib";
                #   tsserver = {
                #     # pluginPaths = [ "/Users/peco/ghq/bitbucket.org/maymust_ai_sw/effect-app/node_modules" ];
                #     globalPlugins = [
                #       {
                #         name = "@effect/language-service";
                #         location = "/Users/peco/ghq/bitbucket.org/maymust_ai_sw/effect-app/node_modules/@effect/language-service";
                #         # enableForWorkspaceTypeScriptVersions = true;
                #       }
                #     ];
                #   };
                # };
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
          # ty.enable = true;
          basedpyright = {
            enable = true;
            settings = {
              basedpyright = {
                analysis = {
                  autoSearchPaths = true;
                  typeCheckingMode = "basic";
                  useLibraryCodeForTypes = false;
                  diagnosticMode = "openFilesOnly";
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
            extraOptions = {
              init_options = {
                settings = {
                  # 편의상, 에디터 설정이 프로젝트 설정보다 우선 (기본값이 editorFirst)
                  configurationPreference = "editorFirst";

                  lint = {
                    # E402만 끄기
                    ignore = [ "E402" ];

                    # 만약 E4 전체(Import 관련) 끄고 싶으면:
                    # ignore = [ "E4" ];
                  };
                };
              };
              capabilities = {
                textDocument = {
                  hover = {
                    dynamicRegistration = false;
                  };
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
