{
  description = "My neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Import nixpkgs with specific system
        pkgs = import nixpkgs {
          inherit system; # Change this according to your system architecture
        };

        # The list of dependencies
        runtimeDeps = [
          pkgs.stdenv.cc
          pkgs.cargo
          pkgs.curl
          pkgs.fd
          pkgs.fzf
          pkgs.git
          pkgs.gnumake
          pkgs.gnused
          pkgs.gnutar
          pkgs.gzip
          pkgs.wget

          #lsp's
          pkgs.lua-language-server
          pkgs.nixd
          pkgs.nodePackages.typescript-language-server
          pkgs.typescript
          pkgs.vscode-langservers-extracted
          pkgs.yaml-language-server
          pkgs.gopls
          pkgs.tailwindcss-language-server
          pkgs.kotlin-language-server

          pkgs.neovim
          pkgs.nodejs
          pkgs.nodePackages.neovim
          pkgs.python3
          pkgs.ripgrep
          pkgs.tree-sitter
          pkgs.unzip
          pkgs.lua
          pkgs.luajitPackages.luarocks-nix
        ];
      in
      {
        # Define the default package
        packages = {
          default = pkgs.stdenv.mkDerivation {
            pname = "nvim";
            version = "1.0.0";
            src = ./.;
            dontUseCmakeConfigure = true;


            nativeBuildInputs = [
              pkgs.gnused
              pkgs.makeWrapper
            ];

            buildInputs = runtimeDeps;

            buildPhase = ''
              runHook preBuild

              mkdir -p share/nvim
              cp init.lua  share/nvim
              cp -r lua share/nvim

              mkdir bin
              cp utils/bin/nvim.template bin/nvim
              chmod +x bin/nvim

              substituteInPlace bin/nvim \
                 --replace RUNTIME_DIR_VAR \$HOME/.local/share/nvim \
                 --replace CONFIG_DIR_VAR \$HOME/.config/nvim \
                 --replace CACHE_DIR_VAR \$HOME/.cache/nvim \
                 --replace BASE_DIR_VAR $out/share/nvim \
                 --replace neovim-binary ${pkgs.neovim}/bin/nvim

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall

              mkdir -p $out
              cp -r bin share $out

              wrapProgram $out/bin/nvim --prefix PATH : ${pkgs.lib.makeBinPath runtimeDeps} \
                --prefix LD_LIBRARY_PATH : ${pkgs.stdenv.cc.cc.lib} \
                --prefix CC : ${pkgs.stdenv.cc.targetPrefix}cc

              runHook postInstall
            '';

            meta = with pkgs.lib; {
              description = "My personal IDE layer for Neovim";
              homepage = "https://www.strenge.ch/";
              platforms = platforms.unix;
              mainProgram = "nvim";
            };
          };
        };
      });
}
