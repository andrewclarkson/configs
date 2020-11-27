{
  description = "Work macbook configuration nicknamed 'komondor'";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, darwin, nixpkgs }: {
    darwinConfigurations."komondor" = darwin.lib.darwinSystem {
      modules = [ ./configuration.nix ];
    };
  };
} 
