{ pkgs, lib ? pkgs.lib, ... }:

{ config }:

let

  neovimPlugins = pkgs.neovimPlugins;

  vimOptions = lib.evalModules {
    modules = [
      { imports = [../modules]; }
      config 
    ];

    specialArgs = {
      inherit pkgs; 
    };
  };

  vim = vimOptions.config.vim;

in

pkgs.wrapNeovim pkgs.neovim-unwrapped {
  viAlias = vim.viAlias;
  vimAlias = vim.vimAlias;
  configure = {
    customRC = vim.configRC;

    packages.myVimPackage = with neovimPlugins; {
      start = vim.startPlugins;
      opt = vim.optPlugins;
    };
  };
}
