# nixconf

This repository contains my personal NixOS configuration using flakes. It manages system and user environments in a modular and reproducible way, leveraging the power of Nix, NixOS, and Home Manager.

## Features

- **Flake-based**: Uses the latest Nix flakes for reproducibility and modularity.
- **Multi-source inputs**: Integrates upstream channels like `nixos-unstable`, `nixos-25.05`, and overlays for software such as Neovim Nightly and Waybar.
- **Home Manager**: Declarative user environment configuration.
- **Custom Modules**: Easily extend and organize configurations in the `modules/` directory.
- **Host-specific configs**: Each machine is described in the `hosts/` directory.
- **Overlays & Packages**: Use the `overlays/` and `pkgs/` directories for extra packages and overlays.
- **Integration**: Built-in support for Disko partitioning, Age encryption (`agenix`), Hyprland, Zen Browser, Spicetify, and more.

## Directory Structure

- `flake.nix` — Main entrypoint, managing inputs and outputs.
- `hosts/` — Host-specific NixOS and Home Manager configurations.
- `modules/` — Custom NixOS modules.
- `overlays/` — Custom Nixpkgs overlays.
- `pkgs/` — Custom packages.
