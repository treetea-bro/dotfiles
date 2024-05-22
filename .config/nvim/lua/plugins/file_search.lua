return {
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = false,
          show_hidden_count = true,
          hide_by_name = {
            ".git",
            -- ".gitignore",
            ".DS_Store",
            -- 'thumbs.db',
          },
          hide_dotfiles = false,
          never_show = {},
        },
      },
    },
  },
}
