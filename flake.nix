{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    { } // utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            # backend
            elixir
            elixir_ls

            # frontend
            yarn
            nodejs
            nodePackages."@angular/cli"
            nodePackages.typescript-language-server

            # infrastructure
            docker-compose

            # misc
            rnix-lsp
          ];
        };
      });
}
