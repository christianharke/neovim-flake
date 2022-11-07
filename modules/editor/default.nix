{ pkgs, config, lib, ... }:

with lib;
with builtins;

let

  cfg = config.vim.editor;

in

{
  options.vim.editor = {
    indentGuide = mkEnableOption "Enable indent guides";

    underlineCurrentWord = mkEnableOption "Underline the word under the cursor";

    colourPreview = mkOption {
      description = "Enable colour previews";
      type = types.bool;
      default = true;
    };
  };

  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [ which-key ]
      ++ optionals cfg.indentGuide [ indent-blankline indentline ]
      ++ optional cfg.underlineCurrentWord cursorword;

    vim.imap = {
      "<F2>" = "<Esc>ggO#!/usr/bin/env";
    };

    vim.nnoremap = {
      "<C-h>" = "<C-w>h";
      "<C-j>" = "<C-w>j";
      "<C-k>" = "<C-w>k";
      "<C-l>" = "<C-w>l";
      "<leader>tt" = "<cmd>split<bar>terminal<cr>";
      "<leader>tv" = "<cmd>vsplit<bar>terminal<cr>";
      "<leader>wc" = "<cmd>close<cr>";
      "<leader>ws" = "<cmd>split<cr>";
      "<leader>wv" = "<cmd>vsplit<cr>";
      "<leader>wh" = "<C-w>t<C-w>H";
      "<leader>wk" = "<C-w>t<C-w>K";
      "<silent> <C-Left>" = "<cmd>vertical<bar>resize<bar>+3<cr>";
      "<silent> <C-Right>" = "<cmd>vertical<bar>resize<bar>-3<cr>";
      "<silent> <C-Up>" = "<cmd>resize<bar>+3<cr>";
      "<silent> <C-Down>" = "<cmd>resize<bar>-3<cr>";
    };

    vim.tnoremap = {
      "<C-h>" = "<C-\\><C-n><C-w>h";
      "<C-j>" = "<C-\\><C-n><C-w>j";
      "<C-k>" = "<C-\\><C-n><C-w>k";
      "<C-l>" = "<C-\\><C-n><C-w>l";
    };

    vim.luaConfigRC = ''
      local wk = require("which-key")

      wk.register({
        t = {
          name = "terminal",
          t = { "Split Horizontal" },
          v = { "Split Vertical" },
        },
        w = {
          name = "window",
          c = { "Close Window"},
          s = { "Split Horizontal" },
          v = { "Split Vertical" },
        },
      }, { prefix = "<leader>" })
    '';

    vim.configRC = optionalString cfg.indentGuide ''
      let g:indentLine_enabled = 1
      let g:indentLine_fileTypeExclude = ['startup']
      let g:indentLine_setConceal = 0
      set list lcs=tab:\|\
    '';
  };
}
