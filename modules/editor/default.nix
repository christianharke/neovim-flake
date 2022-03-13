{ pkgs, config, lib, ...}:

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

    vim.nnoremap = {
     "<leader>wc" = "<cmd>close<cr>";
     "<leader>wh" = "<cmd>split<cr>";
     "<leader>wv" = "<cmd>vsplit<cr>";
    };

    vim.luaConfigRC = ''
      local wk = require("which-key")

      wk.register({
        w = {
          name = "window",
          c = { "Close Window"},
          h = { "Split Horizontal" },
          v = { "Split Vertical" },
        },
      }, { prefix = "<leader>" })
    '';

    vim.configRC = optionalString cfg.indentGuide ''
      let g:indentLine_enabled = 1
      set list lcs=tab:\|\
    '';
  };
}
