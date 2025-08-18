{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    mini-surround = {
      enable = true;
      settings = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
        
        n_lines = 50;
        respect_selection_type = true;
        search_method = "cover_or_next";
      };
    };
  };
}
