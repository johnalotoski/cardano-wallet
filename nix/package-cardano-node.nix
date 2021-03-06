############################################################################
# Release builds for cardano-wallet-{byron,shelley}
############################################################################

{ pkgs
# library from iohk-nix
, haskellBuildUtils
# git revision to stamp the executable with
, gitrev
# executable component for the program, from Haskell.nix
, exe
# node backend
, cardano-node
}:

with pkgs.lib;

pkgs.stdenv.mkDerivation rec {
  name = "${exe.identifier.name}-${version}";
  version = exe.identifier.version;
  phases = [ "installPhase" ];
  nativeBuildInputs = [ haskellBuildUtils pkgs.buildPackages.binutils pkgs.buildPackages.nix ];
  meta.platforms = platforms.all;
  installPhase = ''
    cp -R ${exe} $out
    chmod -R +w $out
    set-git-rev "${gitrev}" $out/bin/${exe.identifier.name}* || true
  '' + (if pkgs.stdenv.hostPlatform.isWindows then ''
    cp --remove-destination -v ${pkgs.libffi}/bin/libffi-6.dll $out/bin
    cp --remove-destination -v ${cardano-node}/bin/* $out/bin
    cp -Rv ${cardano-node.configs} $out/configuration
  '' else (if pkgs.stdenv.hostPlatform.isDarwin then ''
    cp -v ${cardano-node}/bin/cardano-node $out/bin
    chmod -R +w $out
    rewrite-libs $out/bin $out/bin/${exe.identifier.name} $out/bin/cardano-node
  '' else ''
    $STRIP $out/bin/${exe.identifier.name}
  ''));
}
