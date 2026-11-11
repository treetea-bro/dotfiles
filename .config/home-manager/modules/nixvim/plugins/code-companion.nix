{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-agent-acp
    claude-code
  ];

  programs.nixvim = {
    plugins.codecompanion = {
      enable = true;

      settings = {
        interactions = {
          chat.adapter = "claude_code";
          inline.adapter = "claude_code";
        };

        display.chat.window = {
          layout = "vertical";
          position = "right";
          width = 0.35;
          full_height = true;
        };

        input = {
          layout = "split";
          height = 8;
        };

        fold_context = true;
      };
    };

    keymaps = [
      # Actions
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ap";
        action = "<cmd>CodeCompanionActions<CR>";
        options.desc = "AI Actions";
      }
      {
        mode = "n";
        key = "<leader>aP";
        action = "<cmd>CodeCompanionActions Refresh<CR>";
        options.desc = "Refresh AI Actions";
      }

      # Chat
      {
        mode = "n";
        key = "<leader>ac";
        action = "<cmd>CodeCompanionChat Toggle<CR>";
        options.desc = "Toggle AI Chat";
      }
      {
        mode = "n";
        key = "<leader>an";
        action = "<cmd>CodeCompanionChat<CR>";
        options.desc = "New AI Chat";
      }
      {
        mode = "v";
        key = "<leader>ac";
        action = "<cmd>CodeCompanionChat Add<CR>";
        options.desc = "Add Selection to Chat";
      }

      # Inline edit (normal + visual)
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ai";
        action = ":CodeCompanion ";
        options.desc = "AI Inline Edit";
      }

      # Built-in prompts
      {
        mode = "v";
        key = "<leader>ae";
        action = "<cmd>CodeCompanion /explain<CR>";
        options.desc = "Explain Code";
      }
      {
        mode = "v";
        key = "<leader>af";
        action = "<cmd>CodeCompanion /fix<CR>";
        options.desc = "Fix Code";
      }
      {
        mode = "v";
        key = "<leader>at";
        action = "<cmd>CodeCompanion /tests<CR>";
        options.desc = "Generate Tests";
      }
      {
        mode = "v";
        key = "<leader>al";
        action = "<cmd>CodeCompanion /lsp<CR>";
        options.desc = "Explain LSP Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>am";
        action = "<cmd>CodeCompanion /commit<CR>";
        options.desc = "Generate Commit Message";
      }
      {
        mode = "n";
        key = "<leader>ah";
        action = "<cmd>CodeCompanion /help<CR>";
        options.desc = "CodeCompanion Help";
      }

      # Code review
      {
        mode = "n";
        key = "<leader>ar";
        action = "<cmd>CodeCompanionCodeReview<CR>";
        options.desc = "Review AI Changes";
      }
      {
        mode = "n";
        key = "<leader>ab";
        action = "<cmd>CodeCompanionCodeReview Branch<CR>";
        options.desc = "Review Branch";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ao";
        action = "<cmd>CodeCompanionCodeReview Comment<CR>";
        options.desc = "Comment on Review";
      }
      {
        mode = "n";
        key = "<leader>ad";
        action = "<cmd>CodeCompanionChat Changes<CR>";
        options.desc = "Show Changed Files";
      }

      # Utilities
      {
        mode = "n";
        key = "<leader>ax";
        action = "<cmd>CodeCompanionChat RefreshCache<CR>";
        options.desc = "Refresh AI Context Cache";
      }
      {
        mode = "n";
        key = "<leader>ak";
        action = ":CodeCompanionCmd ";
        options.desc = "Generate Shell Command";
      }

      # CLI interaction
      {
        mode = "n";
        key = "<leader>aC";
        action = "<cmd>CodeCompanionCLI<CR>";
        options.desc = "Open AI CLI";
      }
      {
        mode = "v";
        key = "<leader>aC";
        action = "<cmd>CodeCompanionCLI<CR>";
        options.desc = "Send Selection to AI CLI";
      }
      {
        mode = "n";
        key = "<leader>aA";
        action = "<cmd>CodeCompanionCLI Ask<CR>";
        options.desc = "Ask AI CLI";
      }
    ];
  };
}
