{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      settings = {
        options = {
          # 핀(Pin)된 버퍼를 항상 목록의 앞쪽(왼쪽)으로 정렬
          persist_buffer_sort = true;
          # 핀 된 버퍼가 우선순위를 갖도록 그룹화 설정
          groups = {
            items = [
              {
                name = "Pinned";
                priority = 2;
                matcher = ''
                  function(buf)
                    return vim.api.nvim_buf_get_var(buf.id, 'pinned')
                  end
                '';
              }
            ];
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>bp";
        action = "<Cmd>BufferLineTogglePin<CR>";
        options.desc = "Toggle pin";
      }
      {
        mode = "n";
        key = "<leader>bP";
        action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
        options.desc = "Delete non-pinned buffers";
      }
      {
        mode = "n";
        key = "<A-h>";
        action = "<Cmd>BufferLineMovePrev<CR>";
        options.desc = "Move buffer left";
      }
      {
        mode = "n";
        key = "<A-l>";
        action = "<Cmd>BufferLineMoveNext<CR>";
        options.desc = "Move buffer right";
      }
      {
        mode = "n";
        key = "H";
        action = "<Cmd>BufferLineCyclePrev<CR>";
        options.desc = "Cycle buffer left (UI order)";
      }
      {
        mode = "n";
        key = "L";
        action = "<Cmd>BufferLineCycleNext<CR>";
        options.desc = "Cycle buffer right (UI order)";
      }

      { mode = "n"; key = "<C-1>"; action = "<Cmd>BufferLineGoToBuffer 1<CR>"; options.desc = "Go to buffer 1"; }
      { mode = "n"; key = "<C-2>"; action = "<Cmd>BufferLineGoToBuffer 2<CR>"; options.desc = "Go to buffer 2"; }
      { mode = "n"; key = "<C-3>"; action = "<Cmd>BufferLineGoToBuffer 3<CR>"; options.desc = "Go to buffer 3"; }
      { mode = "n"; key = "<C-4>"; action = "<Cmd>BufferLineGoToBuffer 4<CR>"; options.desc = "Go to buffer 4"; }
      { mode = "n"; key = "<C-5>"; action = "<Cmd>BufferLineGoToBuffer 5<CR>"; options.desc = "Go to buffer 5"; }
      { mode = "n"; key = "<C-6>"; action = "<Cmd>BufferLineGoToBuffer 6<CR>"; options.desc = "Go to buffer 6"; }
      { mode = "n"; key = "<C-7>"; action = "<Cmd>BufferLineGoToBuffer 7<CR>"; options.desc = "Go to buffer 7"; }
      { mode = "n"; key = "<C-8>"; action = "<Cmd>BufferLineGoToBuffer 8<CR>"; options.desc = "Go to buffer 8"; }
      # 9번은 마지막 버퍼로 이동
      { mode = "n"; key = "<C-9>"; action = "<Cmd>BufferLineGoToBuffer -1<CR>"; options.desc = "Go to last buffer"; }
    ];
  };
}
