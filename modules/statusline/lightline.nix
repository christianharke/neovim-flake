{ pkgs, config, lib, ...}:

with lib;
with builtins;

let

  cfg = config.vim.statusline.lightline;

in

{
  options.vim.statusline.lightline = {
    enable = mkEnableOption "Enable lightline";

    theme = mkOption {
      default = "wombat";
      description = "Theme for light line. Can be: powerline, wombat, jellybeans, solarized dark, solarized light, papercolor dark, papercolor light, seoul256, onedark, onelight, landscape";
      type = types.enum ["wombat" "powerline" "jellybeans" "solarized dark" "solarized dark" "papercolor dark" "papercolor light" "seoul256" "onedark" "onelight" "landscape"];
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [ statusline-lightline ];

    vim.globals = {
      "lightline" = {
        "colorscheme" = cfg.theme;
      };
    };
  };
}
