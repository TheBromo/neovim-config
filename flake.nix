{
  description = "personal neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    neovim-src = {
      url = "github:neovim/neovim";
      flake = false;
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        neovim-src.follows = "neovim-src";
      };
    };
  };

  outputs =
    { self
    , nixpkgs
    , neovim-nightly
    , ...
    }:
    let
      systems = builtins.attrNames neovim-nightly.packages;
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          config = pkgs.runCommand "neovim-config" { } "cp -r ${./.} $out/";

          default = pkgs.callPackage ./nix/distribution.nix {
            neovim-unwrapped = neovim-nightly.packages.${system}.default.overrideAttrs (
              final: prev: {
                treesitter-parsers = { };
                postPatch = ''
                  mkdir -p $out/share/nvim/runtime/plugin
                  echo "let g:loaded_netrwPlugin = 1" >> $out/share/nvim/runtime/plugin/netrwPlugin.vim
                  echo "let g:loaded_netrw = 1" >> $out/share/nvim/runtime/plugin/netrwPlugin.vim
                  substituteInPlace runtime/plugin/netrwPlugin.vim --replace "call s:ScriptCmd('netrw')" "\" call s:ScriptCmd('netrw')"
                '';
              }
            );

            custom-config = self.packages.${system}.config;

            preinstalled-lsp = [
              pkgs.lua-language-server
              pkgs.nixd
              pkgs.nixfmt-rfc-style
              pkgs.gopls
              pkgs.yaml-language-server

              pkgs.nodePackages.typescript-language-server
              pkgs.vscode-langservers-extracted
            ];
          };
        }
      );

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nvim";
        };
      });

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
