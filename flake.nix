{
  description = "Christian Harke's NeoVim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rnix-lsp = {
      url = "github:nix-community/rnix-lsp";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "flake-utils";
      };
    };

    ###
    # Vim plugins
    ###

    # Appearance
    cursorword = { url = "github:itchyny/vim-cursorword"; flake = false; };
    devicons = { url = "github:kyazdani42/nvim-web-devicons"; flake = false; };
    indent-blankline = { url = "github:lukas-reineke/indent-blankline.nvim"; flake = false; };
    indentline = { url = "github:Yggdroot/indentLine"; flake = false; };
    statusline-lualine = { url = "github:nvim-lualine/lualine.nvim"; flake = false; };
    statusline-lightline = { url = "github:itchyny/lightline.vim"; flake = false; };
    statusline-lightline-onedark = { url = "github:NovaDev94/lightline-onedark"; flake = false; };
    theme-gruvbox = { url = "github:morhetz/gruvbox"; flake = false; };
    theme-nord = { url = "github:arcticicestudio/nord-vim"; flake = false; };
    theme-onedark = { url = "github:olimorris/onedarkpro.nvim"; flake = false; };
    tree = { url = "github:kyazdani42/nvim-tree.lua"; flake = false; };

    # Git
    blame-line = { url = "github:tveskag/nvim-blame-line"; flake = false; };
    fugitive = { url = "github:tpope/vim-fugitive"; flake = false; };
    vimagit = { url = "github:jreybert/vimagit"; flake = false; };

    # Programming
    dap = { url = "github:mfussenegger/nvim-dap"; flake = false; };
    dap-telescope = { url = "github:nvim-telescope/telescope-dap.nvim"; flake = false; };
    dap-virtual-text = { url = "github:theHamsta/nvim-dap-virtual-text"; flake = false; };
    editorconfig = { url = "github:editorconfig/editorconfig-vim"; flake = false; };
    lang-nix = { url = "github:LnL7/vim-nix"; flake = false; };
    lightbulb = { url = "github:kosayoda/nvim-lightbulb"; flake = false; };
    lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    surround = { url = "github:tpope/vim-surround"; flake = false; };
    test = { url = "github:vim-test/vim-test"; flake = false; };
    treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    treesitter-context = { url = "github:romgrk/nvim-treesitter-context"; flake = false; };

    # Workflow
    calendar = { url = "github:hoaxdream/calendar-vim"; flake = false; };
    popup = { url = "github:nvim-lua/popup.nvim"; flake = false; };
    dashboard-startify = { url = "github:mhinz/vim-startify"; flake = false; };
    dashboard-startup = { url = "github:startup-nvim/startup.nvim"; flake = false; };
    telescope = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    telescope-file-browser = { url = "github:nvim-telescope/telescope-file-browser.nvim"; flake = false; };
    vimwiki = { url = "github:vimwiki/vimwiki"; flake = false; };
    which-key = { url = "github:folke/which-key.nvim"; flake = false; };

    # Internals
    plenary = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
  };

  outputs = { self, nixpkgs, flake-utils, pre-commit-hooks, ... } @ inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        name = "neovim";

        inherit (lib) neovimBuilder;
        pluginOverlay = lib.buildPluginOverlay;

        plugins = [
          "blame-line"
          "calendar"
          "cursorword"
          "dap"
          "dap-telescope"
          "dap-virtual-text"
          "dashboard-startify"
          "dashboard-startup"
          "devicons"
          "editorconfig"
          "fugitive"
          "indent-blankline"
          "indentline"
          "lang-nix"
          "lightbulb"
          "lspconfig"
          "plenary"
          "popup"
          "statusline-lightline"
          "statusline-lightline-onedark"
          "statusline-lualine"
          "surround"
          "telescope"
          "telescope-file-browser"
          "test"
          "theme-gruvbox"
          "theme-nord"
          "theme-onedark"
          "tree"
          "treesitter"
          "treesitter-context"
          "vimagit"
          "vimwiki"
          "which-key"
        ];

        neovimPkg = neovimBuilder {
          config = {
            # Core
            vim.viAlias = true;
            vim.vimAlias = true;

            # Modules
            vim.dashboard.startup.enable = true;
            vim.disableArrows = true;
            vim.editor.indentGuide = true;
            vim.editor.underlineCurrentWord = true;
            vim.filetree.nvimTreeLua.enable = true;
            vim.formatting.editorConfig.enable = true;
            vim.fuzzyfind.telescope.enable = true;
            vim.git.enable = true;
            vim.lsp.bash = true;
            vim.lsp.clang = true;
            vim.lsp.cmake = false; # Currently broken
            vim.lsp.css = true;
            vim.lsp.docker = true;
            vim.lsp.enable = true;
            vim.lsp.go = true;
            vim.lsp.html = true;
            vim.lsp.json = true;
            vim.lsp.lightbulb = true;
            vim.lsp.nix = true;
            vim.lsp.python = true;
            vim.lsp.ruby = true;
            vim.lsp.rust = true;
            vim.lsp.terraform = true;
            vim.lsp.tex = true;
            vim.lsp.typescript = true;
            vim.lsp.variableDebugPreviews = true;
            vim.lsp.vimscript = true;
            vim.lsp.yaml = true;
            vim.markdown.enable = true;
            vim.statusline.lualine.enable = true;
            vim.test.enable = true;
            vim.theme.onedark.enable = true;
            vim.wiki.enable = true;
          };
        };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            pluginOverlay
            (final: prev: {
              rnix-lsp = inputs.rnix-lsp.defaultPackage.${system};
            })
            inputs.neovim-nightly-overlay.overlay
          ];
        };

        lib = import ./lib { inherit pkgs inputs plugins; };
      in
      rec {

        apps = {
          ${name} = flake-utils.lib.mkApp {
            drv = packages.${name};
            exePath = "/bin/nvim";
          };
          default = apps.${name};
        };

        packages = {
          ${name} = neovimPkg;
          default = neovimPkg;
        };

        checks = {
          build = pkgs.${name};

          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
              statix.enable = true;
            };
          };
        };

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            # banner printing on enter
            figlet
            lolcat

            nixpkgs-fmt
            statix

            packages.default
          ];
          shellHook = ''
            figlet ${name} | lolcat --freq 0.5
            ${checks.pre-commit-check.shellHook}
          '';
        };
      });
}
