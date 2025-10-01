{
  programs.nixvim = {
    plugins.grug-far.enable = true;

    extraConfigLua = ''
      local grugfar = require("grug-far")
      local grugfar_bufnr = nil

      function _G.toggle_grugfar(opts)
        if grugfar_bufnr and vim.api.nvim_buf_is_valid(grugfar_bufnr) then
          local wins = vim.fn.win_findbuf(grugfar_bufnr)
          if #wins > 0 then
            vim.api.nvim_win_close(wins[1], true)
          end
          vim.api.nvim_buf_delete(grugfar_bufnr, { force = true })
          grugfar_bufnr = nil
          return
        end

        grugfar.open(opts or {})
        vim.defer_fn(function()
          grugfar_bufnr = vim.api.nvim_get_current_buf()

          -- grug-far 결과창에서 Enter → 기존 코드 윈도우에 파일 열기
          vim.keymap.set("n", "<CR>", function()
            local file = vim.fn.expand("<cfile>")
            if file ~= "" then
              local prev_win = vim.fn.win_getid(vim.fn.winnr("#")) -- 이전 윈도우 id
              if prev_win ~= 0 and vim.api.nvim_win_is_valid(prev_win) then
                vim.api.nvim_set_current_win(prev_win)
                vim.cmd("edit " .. vim.fn.fnameescape(file))
              end
            end
          end, { buffer = grugfar_bufnr, silent = true })
        end, 10)
      end
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>ft";
        action = "<cmd>lua toggle_grugfar()<cr>";
        options.desc = "Toggle grug-far: (project)";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>lua toggle_grugfar({ prefills = { search = vim.fn.expand('<cword>') } })<cr>";
        options.desc = "Toggle grug-far: cursor word (project)";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua toggle_grugfar({ prefills = { paths = vim.fn.expand('%') } })<cr>";
        options.desc = "Toggle grug-far: (current file)";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>lua toggle_grugfar({ prefills = { search = vim.fn.expand('<cword>'), paths = vim.fn.expand('%') } })<cr>";
        options.desc = "Toggle grug-far: cursor word (current file)";
      }
      {
        mode = "x";
        key = "<leader>fi";
        action = ":'<,'>GrugFarWithin<cr>";
        options.desc = "grug-far: within visual selection";
      }
    ];
  };
}
