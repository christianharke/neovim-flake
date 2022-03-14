{ pkgs, lib ? pkgs.lib, ... }:

{ config }:

let

  inherit (pkgs) neovimPlugins;

  vimOptions = lib.evalModules {
    modules = [
      { imports = [ ../modules ]; }
      config
    ];

    specialArgs = {
      inherit pkgs;
    };
  };

  inherit (vimOptions.config) vim;

in

pkgs.wrapNeovim pkgs.neovim-unwrapped {
  inherit (vim) viAlias;
  inherit (vim) vimAlias;
  configure = {
    customRC = vim.configRC;

    packages.myVimPackage = with neovimPlugins; {
      start = vim.startPlugins;
      opt = vim.optPlugins;
    };
  };
}
