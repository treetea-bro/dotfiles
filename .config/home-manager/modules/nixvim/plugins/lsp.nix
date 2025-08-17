{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      
      servers = {
        # TypeScript/JavaScript
        ts_ls.enable = true;
        
        # Nix
        nil_ls.enable = true;
        
        # 추가 언어 서버들 (필요시 활성화)
        # pyright.enable = true;      # Python
        # rust_analyzer.enable = true; # Rust
        # gopls.enable = true;        # Go
        # html.enable = true;         # HTML
        # cssls.enable = true;        # CSS
      };
      
      # keymaps = {
      #   diagnostic = {
      #     "<leader>k" = "goto_prev";
      #     "<leader>j" = "goto_next";
      #   };
      #   lspBuf = {
      #     "gd" = "definition";
      #     "gr" = "references";
      #     "K" = "hover";
      #     "<leader>rn" = "rename";
      #     "<leader>ca" = "code_action";
      #   };
      # };
    };
  };
}
