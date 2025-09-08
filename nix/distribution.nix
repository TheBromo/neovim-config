{
  lib,
  pkgs,
  callPackage,

  neovim-unwrapped,
  neovimUtils,
  makeNeovimConfig ? neovimUtils.makeNeovimConfig,
  wrapNeovimUnstable,

  git,
  rocks ? pkgs.luajitPackages.luarocks,
  gcc,
  gnumake,
  cmake,
  fd,
  ripgrep,

  custom-config ? callPackage ./config.nix { },
  preinstalled-lsp ? [ ],
}:
let
  deps = [
    git
    rocks
    gcc
    gnumake
    cmake

    # required for fuzzy finding in telescope
    fd
    ripgrep
  ]
  ++ preinstalled-lsp;

  extraWrapperArgs = [
    "--suffix"
    "PATH"
    ":"
    (lib.makeBinPath deps)
  ];

  res = makeNeovimConfig {
    withPython3 = true;
    withRuby = false;

    plugins = [ custom-config ];
  };
in
wrapNeovimUnstable neovim-unwrapped (
  res // { wrapperArgs = lib.escapeShellArgs (res.wrapperArgs ++ extraWrapperArgs); }
)
