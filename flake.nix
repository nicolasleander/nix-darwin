{
  description = "Nix darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    fzf-git-sh = {
      url = "https://raw.githubusercontent.com/junegunn/fzf-git.sh/28b544a7b6d284b8e46e227b36000089b45e9e00/fzf-git.sh";
      flake = false;
    };
    yamb-yazi = {
      url = "github:h-hg/yamb.yazi";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, nix-darwin, home-manager, sops-nix, fzf-git-sh, yamb-yazi, ... }:
    let
      system = "aarch64-darwin";

      pkgs = nixpkgs.legacyPackages.${system};
      fzf-git-sh-package = pkgs.writeShellScriptBin "fzf-git.sh" (builtins.readFile fzf-git-sh);
    in
    {
      darwinConfigurations."Apple-M2-Max-2023" = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          {
          }
          sops-nix.darwinModules.sops
          ./system.nix
          home-manager.darwinModules.home-manager
          {
            users.users.myk = {
              name = "myk";
              home = "/Users/myk";
            };
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit fzf-git-sh-package yamb-yazi;
              };
              users.myk = import ./home.nix;
            };
          }
        ];
      };
    };
}
