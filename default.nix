# default.nix

{ nixpkgs ? import <nixpkgs> { } }:

let
  # Import the Nixpkgs library
  pkgs = import <nixpkgs> { inherit (nixpkgs) lib; };

  # Import your package definition and pass the required arguments
in
pkgs.callPackage ./package.nix { }

