{ pkgs, config, lib, ... }:
with builtins;
with lib;
let
  cfg = config.vim.dashboard.startup;

  mkVimBool = val: if val then "1" else "0";

in
{
  options.vim.dashboard.startup = {
    enable = mkEnableOption "Enable startup";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [ dashboard-startup telescope plenary ];

    vim.luaConfigRC = ''
      require"startup".setup()

      require("which-key").register({
        s = {
          name = "Start",
          s = { "Display Dashboard" },
        },
      }, { prefix = "<leader>" })
    '';

    vim.nnoremap = {
      "<leader>ss" = "<cmd>Startup display<cr>";
    };
  };
}
