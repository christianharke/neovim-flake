{ pkgs, lib, config, ... }:
with lib;
with builtins;

let

  cfg = config.vim.fuzzyfind.telescope;

in

{
  options.vim.fuzzyfind.telescope = {
    enable = mkEnableOption "Enable telescope";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      plenary
      popup
      telescope
      telescope-file-browser
    ];

    vim.luaConfigRC = ''
      require("telescope").load_extension "file_browser"

      local wk = require("which-key")

      wk.register({
        f = {
          name = "Files",
          b = { "List Buffers" },
          f = { "Find Files" },
          g = { "Live Grep" },
          h = { "Help Tags" },
          r = { "Recent Files" },
        },
      }, { prefix = "<leader>" })
    '';

    vim.nnoremap = {
      "<leader>fb" = "<cmd>Telescope buffers<cr>";
      "<leader>ff" = "<cmd>Telescope find_files<cr>";
      "<leader>fg" = "<cmd>Telescope live_grep<cr>";
      "<leader>fh" = "<cmd>Telescope help_tags<cr>";
      "<leader>fr" = "<cmd>Telescope oldfiles<cr>";
    };
  };
}
