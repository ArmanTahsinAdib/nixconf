{
  description = "Home Manager configuration of arman-adib";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix/24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {

      nixpkgs,
      nixpkgs-stable,
      home-manager,
      spicetify-nix,
      zen-browser,
      catppuccin,
      neovim-nightly-overlay,
      nix-index-database,
      ...
    }:
    let
      overlays = [ neovim-nightly-overlay.overlays.default ];
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations."arman-adib" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          # { nixpkgs.overlays = overlays; }
          nix-index-database.homeModules.nix-index

          { programs.nix-index-database.comma.enable = true; }
          zen-browser.homeModules.twilight
          spicetify-nix.homeManagerModules.spicetify
          ./home.nix
          catppuccin.homeModules.catppuccin
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
}
