{ lib
, stdenv
, makeWrapper
, cargo
, curl
, fd
, gcc
, fzf
, git
, gnumake
, gnused
, gnutar
, gzip
, lua-language-server
, neovim
, nodejs
, nodePackages
, ripgrep
, tree-sitter
, unzip
, nvimAlias ? false
, viAlias ? false
, vimAlias ? false
, globalConfig ? ""
}:
let
  sourceFiles = ./.;
  fs = lib.fileset;
in

stdenv.mkDerivation (finalAttrs: {
  inherit nvimAlias viAlias vimAlias globalConfig;

  pname = "nvim";
  version = "1.0.0";
  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };


  nativeBuildInputs = [
    gnused
    makeWrapper
  ];

  runtimeDeps = [
    stdenv.cc
    cargo
    curl
    gcc
    fd
    fzf
    git
    gnumake
    gnutar
    gzip
    lua-language-server
    neovim
    nodejs
    nodePackages.neovim
    ripgrep
    tree-sitter
    unzip
  ];

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
       --replace neovim-binary ${neovim}/bin/nvim

    # Allow language servers to be overridden by appending instead of prepending
    # the mason.nvim path.
    # echo "nvim.builtin.mason.PATH = \"append\"" > share/nvim/global.lua
    # echo ${ lib.strings.escapeShellArg finalAttrs.globalConfig } >> share/nvim/global.lua
    # sed -i "s/add_to_path()/add_to_path(true)/" share/nvim/lua/custom/plugins/mason.lua
    # sed -i "/Log:set_level/idofile(\"$out/share/nvim/global.lua\")" share/nvim/lua/nvim/config/init.lua
    #
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r bin share $out

    wrapProgram $out/bin/nvim --prefix PATH : ${ lib.makeBinPath finalAttrs.runtimeDeps } \
      --prefix LD_LIBRARY_PATH : ${stdenv.cc.cc.lib} \
      --prefix CC : ${stdenv.cc.targetPrefix}cc
  '' + lib.optionalString finalAttrs.nvimAlias ''
    ln -s $out/bin/nvim $out/bin/nvim
  '' + lib.optionalString finalAttrs.viAlias ''
    ln -s $out/bin/nvim $out/bin/vi
  '' + lib.optionalString finalAttrs.vimAlias ''
    ln -s $out/bin/nvim $out/bin/vim
  '' + ''
    runHook postInstall
  '';

  meta = with lib; {
    description = "IDE layer for Neovim";
    homepage = "https://www.strenge.ch/";
    sourceProvenance = with sourceTypes; [ fromSource ];
    platforms = platforms.unix;
    mainProgram = "nvim";
  };
})
