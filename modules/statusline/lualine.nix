{ pkgs, config, lib, ... }:

with lib;
with builtins;

let

  cfg = config.vim.statusline.lualine;

in

{
  options.vim.statusline.lualine = {
    enable = mkEnableOption "Enable lualine";

    theme = mkOption {
      default = "auto";
      description = "Theme for lualine. For possible values see: https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md";
      type = types.enum [
        "auto"
        "16color"
        "ayu_dark"
        "ayu_light"
        "ayu_mirage"
        "ayu"
        "codedark"
        "dracula"
        "everforest"
        "gruvbox_dark"
        "gruvbox_light"
        "gruvbox"
        "gruvbox-material"
        "horizon"
        "iceberg_dark"
        "iceberg_light"
        "icebergb"
        "jellybeans"
        "material"
        "modus-vivendi"
        "molokai"
        "moonfly"
        "nightfly"
        "nord"
        "OceanicNext"
        "onedark"
        "onelight"
        "palenight"
        "papercolor_dark"
        "papercolor_light"
        "PaperColor"
        "powerline"
        "powerline_dark"
        "pywal"
        "seoul256"
        "solarized_dark"
        "solarized_light"
        "Tomorrow"
        "wombat"
      ];
    };

    enableSeparators = mkEnableOption "Enable section and component separators";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [ statusline-lualine ];

    vim.luaConfigRC = ''
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = '${cfg.theme}',
          component_separators = ${if cfg.enableSeparators then "{ left = '', right = ''}" else "{ left = '•', right = '•'}"},
          section_separators = ${if cfg.enableSeparators then "{ left = '', right = ''}" else "''"},
          disabled_filetypes = {},
          always_divide_middle = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    '';
  };
}
