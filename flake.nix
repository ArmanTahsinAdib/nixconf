{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    inputs.agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    flake-utils.url = "github:numtide/flake-utils";
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

    spicetify-nix.url = "github:Gerg-L/spicetify-nix/24.11";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      disko,
      agenix,
      home-manager,
      nix-index-database,
      grub2-theme,
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
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations = {
        adib = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            # agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            grub2-theme.nixosModules.default
            nix-index-database.nixosModules.nix-index
            spicetify-nix.homeManagerModules.spicetify
            {
              programs.nix-index-database.comma.enable = true;
              nixpkgs.overlays = overlays;
              home-manager.extraSpecialArgs = { inherit inputs; };
              # home-manager.useGlobalPkgs = true;
              # home-manager.useUserPackages = true;
              home-manager.users.adib = import ./hosts/adib/home.nix;
            }
            ./hosts/adib/configuration.nix
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
    };
}
