{
  description = "Christian Harke's NeoVim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    rnix-lsp = { url = "github:nix-community/rnix-lsp"; };

    ###
    # Vim plugins
    ###

    # Appearance
    cursorword = { url = "github:itchyny/vim-cursorword"; flake = false; };
    devicons = { url = "github:kyazdani42/nvim-web-devicons"; flake = false; };
    indentline = { url = "github:Yggdroot/indentLine"; flake = false; };
    indent-blankline = { url = "github:lukas-reineke/indent-blankline.nvim"; flake = false; };
    statusline-lightline = { url = "github:itchyny/lightline.vim"; flake = false; };
    theme-gruvbox = { url = "github:morhetz/gruvbox"; flake = false; };
    theme-nord = { url = "github:arcticicestudio/nord-vim"; flake = false; };
    tree = { url = "github:kyazdani42/nvim-tree.lua"; flake = false; };

    # Git
    vimagit = { url = "github:jreybert/vimagit"; flake = false; };
    fugitive = { url = "github:tpope/vim-fugitive"; flake = false; };
    blame-line = { url = "github:tveskag/nvim-blame-line"; flake = false; };

    # Programming
    dap = { url = "github:mfussenegger/nvim-dap"; flake = false; };
    dap-telescope = { url = "github:nvim-telescope/telescope-dap.nvim"; flake = false; };
    dap-virtual-text = { url = "github:theHamsta/nvim-dap-virtual-text"; flake = false; };
    editorconfig = { url = "github:editorconfig/editorconfig-vim"; flake = false; };
    lang-nix = { url = "github:LnL7/vim-nix"; flake = false; };
    lightbulb = { url = "github:kosayoda/nvim-lightbulb"; flake = false; };
    lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    test = { url = "github:vim-test/vim-test"; flake = false; };
    treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false;};
    treesitter-context = { url = "github:romgrk/nvim-treesitter-context"; flake = false;};

    # Workflow
    completion = { url = "github:nvim-lua/completion-nvim"; flake = false; };
    popup = { url = "github:nvim-lua/popup.nvim"; flake = false; };
    startify = { url = "github:mhinz/vim-startify"; flake = false; };
    telescope = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    which-key = { url = "github:folke/which-key.nvim"; flake = false; };

    # Internals
    plenary = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
  };

  outputs = { self, nixpkgs, neovim, rnix-lsp, ... }@inputs:
  let
    plugins = [
      "theme-gruvbox"
      "theme-nord"
      "startify"
      "statusline-lightline"
      "lspconfig"
      "completion"
      "lang-nix"
      "dap"
      "telescope"
      "popup"
      "plenary"
      "devicons"
      "tree"
      "dap-telescope"
      "vimagit"
      "fugitive" 
      "lightbulb"
      "treesitter"
      "treesitter-context"
      "editorconfig"
      "indent-blankline"
      "indentline"
      "blame-line"
      "dap-virtual-text"
      "cursorword"
      "test"
      "which-key"
    ];

    externalBitsOverlay = top: last: {
      rnix-lsp = rnix-lsp.defaultPackage.${top.system};
      neovim-nightly = neovim.defaultPackage.${top.system};
    };

    pluginOverlay = top: last: let
      buildPlug = name: top.vimUtils.buildVimPluginFrom2Nix {
        pname = name;
        version = "master";
        src = builtins.getAttr name inputs;
      };
    in {
      neovimPlugins = builtins.listToAttrs (map (name: { inherit name; value = buildPlug name; }) plugins);
    };
    
    allPkgs = lib.mkPkgs { 
      inherit nixpkgs; 
      cfg = { };
      overlays = [
        pluginOverlay
        externalBitsOverlay
      ];
    };

    lib = import ./lib;

    mkNeoVimPkg = pkgs: lib.neovimBuilder {
        inherit pkgs;
        config = {
          vim.viAlias = true;
          vim.vimAlias = true;
          vim.dashboard.startify.enable = true;
          vim.dashboard.startify.customHeader = [ "NIXOS NEOVIM CONFIG" ];
          vim.theme.nord.enable = true;
          vim.disableArrows = true;
          vim.statusline.lightline.enable = true;
          vim.lsp.enable = true;
          vim.lsp.bash = true;
          vim.lsp.go = true;
          vim.lsp.nix = true;
          vim.lsp.python = true;
          vim.lsp.ruby = true;
          vim.lsp.rust = true;
          vim.lsp.terraform = true;
          vim.lsp.typescript = true;
          vim.lsp.vimscript = true;
          vim.lsp.yaml = true;
          vim.lsp.docker = true;
          vim.lsp.tex = true;
          vim.lsp.css = true;
          vim.lsp.html = true;
          vim.lsp.json = true;
          vim.lsp.clang = true;
          vim.lsp.cmake = false; # Currently broken
          vim.lsp.lightbulb = true;
          vim.lsp.variableDebugPreviews = true;
          vim.fuzzyfind.telescope.enable = true;
          vim.filetree.nvimTreeLua.enable = true;
          vim.git.enable = true;
          vim.formatting.editorConfig.enable = true;
          vim.editor.indentGuide = true;
          vim.editor.underlineCurrentWord = true;
          vim.test.enable = true;
        };
      };

  in {

    apps = lib.withDefaultSystems (sys:
    {
      nvim = {
        type = "app";
        program = "${self.defaultPackage."${sys}"}/bin/nvim";
      };
    });

    defaultApp = lib.withDefaultSystems (sys: {
      type = "app";
      program = "${self.defaultPackage."${sys}"}/bin/nvim";
    });

    defaultPackage = lib.withDefaultSystems (sys: self.packages."${sys}".neovimWT);

    packages = lib.withDefaultSystems (sys: {
      neovimWT = mkNeoVimPkg allPkgs."${sys}";
    });
  };
}
