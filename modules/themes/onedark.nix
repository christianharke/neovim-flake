{ pkgs, config, lib, ... }:

with lib;
with builtins;

let

  cfg = config.vim.theme.onedark;
  lightlineCfg = config.vim.statusline.lightline;

  mkStyleOption = default: mkOption {
    inherit default;
    type = with types; listOf (enum [ "NONE" "bold" "italic" ]);
  };

in

{
  options.vim.theme.onedark = {
    enable = mkEnableOption "Enable one dark theme";

    styles = {
      comments = mkStyleOption [ "italic" ];
      keywords = mkStyleOption [ "bold" "italic" ];
      functions = mkStyleOption [ "NONE" ];
      strings = mkStyleOption [ "NONE" ];
      variables = mkStyleOption [ "NONE" ];
    };

    options = {
      bold = mkEnableOption "Use the themes opinionated bold styles" // { default = true; };
      italic = mkEnableOption "Use the themes opinionated italic styles" // { default = true; };
      underline = mkEnableOption "Use the themes opinionated underline styles" // { default = true; };
      undercurl = mkEnableOption "Use the themes opinionated undercurl styles" // { default = true; };
      cursorline = mkEnableOption "Use cursorline highlighting" // { default = true; };
      transparency = mkEnableOption "Use a transparent background";
      terminal_colors = mkEnableOption "Use the theme's colors for Neovim's :terminal" // { default = true; };
      window_unfocussed_color = mkEnableOption "When the window is out of focus, change the normal background" // { default = true; };
    };
  };

  config = mkIf cfg.enable {
    vim.luaConfigRC = ''
      local onedarkpro = require("onedarkpro")
      onedarkpro.setup({
        styles = {
            ${concatStringsSep "\n" (mapAttrsToList (name: value: "${name} = \"${concatStringsSep "," value}\",") cfg.styles)}
        },
        options = {
            ${concatStringsSep "\n" (mapAttrsToList (name: value: "${name} = ${boolToString value},") cfg.options)}
        }
      })
      onedarkpro.load()
    '';

    vim.startPlugins = with pkgs.neovimPlugins; [ theme-onedark ]
      ++ optional lightlineCfg.enable statusline-lightline-onedark;

    vim.statusline.lightline.theme = mkIf lightlineCfg.enable "onedark";
  };
}
