{
  description = "Lambda — Carrrot's NixOS config. X11 + i3, Stylix-themed (Half-Life: black & orange).";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Your software. Each repo ships its own flake.nix exposing packages.default.
    # While hacking locally, point at a checkout the VM can see (UTM shared folder of
    # ~/Coding/Personal on the Mac, or a clone inside the VM):
    #   sudo nixos-rebuild switch --flake . --override-input vista path:/path/to/vista
    vista = {
      url = "github:SeamusMullan/vista"; # TODO confirm owner/repo
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: your dmenu replacement — uncomment, then see overlays/default.nix + modules/home/launcher.nix
    # launcher = {
    #   url = "github:SeamusMullan/<launcher>";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.lambda = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ (import ./overlays inputs) ]; }

          ./hosts/lambda

          stylix.nixosModules.stylix
          ./theme # the ONE place colours / fonts / cursor / wallpaper live

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true; # one nixpkgs + overlay set for system and user
              useUserPackages = true;
              backupFileExtension = "bak"; # first switch won't choke on existing dotfiles
              extraSpecialArgs = { inherit inputs; };
              users.carrrot = import ./home/carrrot.nix;
            };
          }
        ];
      };

      formatter.${system} = pkgs.nixfmt;

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nil # Nix LSP
          nixfmt
          nix-output-monitor
        ];
      };
    };
}
