return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod" },
  },
  keys = {
    {
      "\\d",
      "<cmd>tabnew<cr><cmd>DBUI<cr>",
      desc = "DBUI",
    },
  },
}
