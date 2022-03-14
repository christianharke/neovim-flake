{ pkgs, lib, config, ... }:

with lib;
with builtins;

let

  cfg = config.vim;

in

{
  options.vim = {
    colourTerm = mkOption {
      default = true;
      description = "Set terminal up for 256 colours";
      type = types.bool;
    };

    disableArrows = mkOption {
      default = false;
      description = "Set to prevent arrow keys from moving cursor";
      type = types.bool;
    };

    hideSearchHighlight = mkOption {
      default = true;
      description = "Hide search highlight so it doesn't stay highlighted";
      type = types.bool;
    };

    scrollOffset = mkOption {
      default = 8;
      description = "Start scrolling this number of lines from the top or bottom of the page.";
      type = types.int;
    };

    wordWrap = mkOption {
      default = false;
      description = "Enable word wrapping.";
      type = types.bool;
    };

    syntaxHighlighting = mkOption {
      default = true;
      description = "Enable syntax highlighting";
      type = types.bool;
    };

    mapLeader = mkOption {
      default = ",";
      description = "Map leader key";
      type = types.str;
    };

    useSystemClipboard = mkOption {
      default = true;
      description = "Make use of the clipboard for default yank and paste operations. Don't use * and +";
      type = types.bool;
    };

    mouseSupport = mkOption {
      default = "a";
      description = "Set modes for mouse support. a - all, n - normal, v - visual, i - insert, c - command";
      type = types.str;
    };

    lineNumberMode = mkOption {
      default = "relNumber";
      description = "How line numbers are displayed. none, relative, number, relNumber";
      type = with types; enum [ "relative" "number" "relNumber" "none" ];
    };

    preventJunkFiles = mkOption {
      default = true;
      description = "Prevent swapfile, backupfile from being created";
      type = types.bool;
    };

    tabWidth = mkOption {
      default = 2;
      description = "Set the width of tabs to 2";
      type = types.int;
    };

    autoIndent = mkOption {
      default = true;
      description = "Enable auto indent";
      type = types.bool;
    };

    cmdHeight = mkOption {
      default = 1;
      description = "Hight of the command pane";
      type = types.int;
    };

    updateTime = mkOption {
      default = 300;
      description = "The number of milliseconds till Cursor Hold event is fired";
      type = types.int;
    };

    showSignColumn = mkOption {
      default = true;
      description = "Show the sign column";
      type = types.bool;
    };

    bell = mkOption {
      default = "none";
      description = "Set how bells are handled. Options: on, visual or none";
      type = types.enum [ "none" "visual" "on" ];
    };

    mapTimeout = mkOption {
      default = 500;
      description = "Timeout in ms that neovim will wait for mapped action to complete";
      type = types.int;
    };

    splitBelow = mkOption {
      default = true;
      description = "New splits will open below instead of on top";
      type = types.bool;
    };

    splitRight = mkOption {
      default = true;
      description = "New splits will open to the right";
      type = types.bool;
    };
  };

  config = {
    vim.nmap = mkIf cfg.disableArrows {
      "<up>" = "<nop>";
      "<down>" = "<nop>";
      "<left>" = "<nop>";
      "<right>" = "<nop>";
    };

    vim.imap = mkIf cfg.disableArrows {
      "<up>" = "<nop>";
      "<down>" = "<nop>";
      "<left>" = "<nop>";
      "<right>" = "<nop>";
    };

    vim.nnoremap = mkIf (cfg.mapLeader == " ") {
      "<space>" = "<nop>";
    };

    vim.configRC = ''
      "Settings that are set for everything
      set encoding=utf-8
      set mouse=${cfg.mouseSupport}
      set tabstop=${toString cfg.tabWidth}
      set shiftwidth=${toString cfg.tabWidth}
      set softtabstop=${toString cfg.tabWidth}
      set expandtab
      set cmdheight=${toString cfg.cmdHeight}
      set updatetime=${toString cfg.updateTime}
      set shortmess+=c
      set tm=${toString cfg.mapTimeout}
      set hidden

      ${optionalString cfg.splitBelow ''
        set splitbelow
      ''}

      ${optionalString cfg.splitRight ''
        set splitright
      ''}

      ${optionalString cfg.showSignColumn ''
        set signcolumn=yes
      ''}

      ${optionalString cfg.autoIndent ''
        set ai
      ''}
            
      ${optionalString cfg.preventJunkFiles ''
        set noswapfile
        set nobackup
        set nowritebackup
      ''}

      ${optionalString (cfg.bell == "none") ''
        set noerrorbells
        set novisualbell
      ''}

      ${optionalString (cfg.bell == "on") ''
        set novisualbell
      ''}

      ${optionalString (cfg.bell == "visual") ''
        set noerrorbells
      ''}

      ${optionalString (cfg.lineNumberMode == "relative") ''
        set relativenumber
      ''}

      ${optionalString (cfg.lineNumberMode == "number") ''
        set number
      ''}

      ${optionalString (cfg.lineNumberMode == "relNumber") ''
        set number relativenumber
      ''}

      ${optionalString cfg.useSystemClipboard ''
        set clipboard+=unnamedplus
      ''}

      ${optionalString (cfg.mapLeader != null) ''
        let mapleader="${cfg.mapLeader}"
        let maplocalleader="${cfg.mapLeader}"
      ''}

      ${optionalString cfg.syntaxHighlighting ''
        syntax on 
      ''}

      ${optionalString (!cfg.wordWrap) ''
        set nowrap
      ''}

      ${optionalString cfg.hideSearchHighlight ''
        set nohlsearch
        set incsearch
      ''}

      ${optionalString cfg.colourTerm ''
        set termguicolors
        set t_Co=256
      ''}

      " Open terminal inside vim
      map <Leader>tt :split<bar>terminal<CR>
      map <Leader>tv :vsplit<bar>terminal<CR>

      " Remap splits navigation to just CTRL + hjkl
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      " Make adjusing split sizes a bit more friendly
      noremap <silent> <C-Left> :vertical resize +3<CR>
      noremap <silent> <C-Right> :vertical resize -3<CR>
      noremap <silent> <C-Up> :resize +3<CR>
      noremap <silent> <C-Down> :resize -3<CR>

      " Change 2 split windows from vert to horiz or horiz to vert
      map <Leader>th <C-w>t<C-w>H
      map <Leader>tk <C-w>t<C-w>K
    '';
  };
}
