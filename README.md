# Neovim Flake

[![NixOS][nixos-badge]][nixos]
[![Build and Test][ci-badge]][ci]
[![Update][update-badge]][update]

This is my personal neovim config. Feel free to take bits of it to build your own or run it yourself.

As this is my personal config I am bound to change it a lot so I recommend forking rather then pointing to
this config.

# How to use

Clone the repo and run the following from the directory:

```bash
nix run .
```

or

```bash
nix run github:christianharke/neovim-flake
```

# How to update plugins

```bash
nix flake update
```

# Folder structure

```
|-[lib] -- Contains my utility functions
|-[modules] -- Contains modules which are used to configure neovim
|-flake.nix -- Flake file
|-README.md -- This file
```

[nixos]: https://nixos.org/
[nixos-badge]: https://img.shields.io/badge/NixOS-blue.svg?logo=NixOS&logoColor=white
[ci]: https://github.com/christianharke/neovim-flake/actions/workflows/ci.yml
[ci-badge]: https://github.com/christianharke/neovim-flake/actions/workflows/ci.yml/badge.svg
[update]: https://github.com/christianharke/neovim-flake/actions/workflows/update.yml
[update-badge]: https://github.com/christianharke/neovim-flake/actions/workflows/update.yml/badge.svg

