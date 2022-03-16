{ pkgs, config, lib, ... }:
{
  imports = [
    ./lightline.nix
    ./lualine.nix
  ];
}
