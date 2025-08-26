{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww.url = "github:LGFae/swww";

    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    waybar-overlay = {
      url = "github:Alexays/Waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix/24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      disko,
      agenix,
      home-manager,
      nix-flatpak,
      neovim-nightly-overlay,
      waybar-overlay,
      nix-index-database,
      zen-browser,
      spicetify-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        config = {
          allowUnfree = true;
        };
        inherit system;
      };
      pkgs-stable = import nixpkgs-stable {
        config = {
          allowUnfree = true;
        };
        inherit system;
      };
      overlays = [
        neovim-nightly-overlay.overlays.default
        waybar-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations = {
        sparta = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            agenix.nixosModules.default
            nix-index-database.nixosModules.nix-index

            home-manager.nixosModules.home-manager

            nix-flatpak.nixosModules.nix-flatpak
            {
              programs.nix-index-database.comma.enable = true;
              nixpkgs.overlays = overlays;
            }
            ./hosts/sparta/configuration.nix
          ];
          specialArgs = {
            inherit
              inputs
              pkgs-stable
              system
              ;
          };
        };
      };
      homeConfigurations = {
        "adib@sparta" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/sparta/home/adib.nix
            zen-browser.homeModules.twilight
            spicetify-nix.homeManagerModules.spicetify
          ];
          extraSpecialArgs = {
            inherit
              spicetify-nix
              zen-browser
              system
              pkgs-stable
              ;
          };
        };
      };
    };
}
