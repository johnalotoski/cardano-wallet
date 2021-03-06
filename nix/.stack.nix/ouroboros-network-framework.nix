let
  buildDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (build dependency).
      
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
  sysDepError = pkg:
    builtins.throw ''
      The Nixpkgs package set does not contain the package: ${pkg} (system dependency).
      
      You may need to augment the system package mapping in haskell.nix so that it can be found.
      '';
  pkgConfDepError = pkg:
    builtins.throw ''
      The pkg-conf packages does not contain the package: ${pkg} (pkg-conf dependency).
      
      You may need to augment the pkg-conf package mapping in haskell.nix so that it can be found.
      '';
  exeDepError = pkg:
    builtins.throw ''
      The local executable components do not include the component: ${pkg} (executable dependency).
      '';
  legacyExeDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (executable dependency).
      
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
  buildToolDepError = pkg:
    builtins.throw ''
      Neither the Haskell package set or the Nixpkgs package set contain the package: ${pkg} (build tool dependency).
      
      If this is a system dependency:
      You may need to augment the system package mapping in haskell.nix so that it can be found.
      
      If this is a Haskell dependency:
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
in { system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = {
        name = "ouroboros-network-framework";
        version = "0.1.0.0";
        };
      license = "Apache-2.0";
      copyright = "2019 Input Output (Hong Kong) Ltd.";
      maintainer = "alex@well-typed.com, duncan@well-typed.com, marcin.szamotulski@iohk.io";
      author = "Alexander Vieth, Duncan Coutts, Marcin Szamotulski";
      homepage = "";
      url = "";
      synopsis = "";
      description = "";
      buildType = "Simple";
      isLocal = true;
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."async" or (buildDepError "async"))
          (hsPkgs."bytestring" or (buildDepError "bytestring"))
          (hsPkgs."containers" or (buildDepError "containers"))
          (hsPkgs."mtl" or (buildDepError "mtl"))
          (hsPkgs."stm" or (buildDepError "stm"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."time" or (buildDepError "time"))
          (hsPkgs."cborg" or (buildDepError "cborg"))
          (hsPkgs."io-sim-classes" or (buildDepError "io-sim-classes"))
          (hsPkgs."typed-protocols" or (buildDepError "typed-protocols"))
          (hsPkgs."network" or (buildDepError "network"))
          (hsPkgs."network-mux" or (buildDepError "network-mux"))
          (hsPkgs."contra-tracer" or (buildDepError "contra-tracer"))
          (hsPkgs."Win32-network" or (buildDepError "Win32-network"))
          (hsPkgs."dns" or (buildDepError "dns"))
          (hsPkgs."iproute" or (buildDepError "iproute"))
          (hsPkgs."serialise" or (buildDepError "serialise"))
          (hsPkgs."typed-protocols-examples" or (buildDepError "typed-protocols-examples"))
          (hsPkgs."cardano-prelude" or (buildDepError "cardano-prelude"))
          ] ++ (pkgs.lib).optionals (system.isWindows) [
          (hsPkgs."Win32-network" or (buildDepError "Win32-network"))
          (hsPkgs."Win32" or (buildDepError "Win32"))
          ];
        buildable = true;
        };
      exes = {
        "demo-ping-pong" = {
          depends = [
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."async" or (buildDepError "async"))
            (hsPkgs."bytestring" or (buildDepError "bytestring"))
            (hsPkgs."cborg" or (buildDepError "cborg"))
            (hsPkgs."containers" or (buildDepError "containers"))
            (hsPkgs."contra-tracer" or (buildDepError "contra-tracer"))
            (hsPkgs."directory" or (buildDepError "directory"))
            (hsPkgs."network-mux" or (buildDepError "network-mux"))
            (hsPkgs."network" or (buildDepError "network"))
            (hsPkgs."ouroboros-network-framework" or (buildDepError "ouroboros-network-framework"))
            (hsPkgs."io-sim-classes" or (buildDepError "io-sim-classes"))
            (hsPkgs."stm" or (buildDepError "stm"))
            (hsPkgs."text" or (buildDepError "text"))
            (hsPkgs."typed-protocols" or (buildDepError "typed-protocols"))
            (hsPkgs."typed-protocols-examples" or (buildDepError "typed-protocols-examples"))
            ] ++ (pkgs.lib).optionals (system.isWindows) [
            (hsPkgs."Win32-network" or (buildDepError "Win32-network"))
            (hsPkgs."Win32" or (buildDepError "Win32"))
            ];
          buildable = true;
          };
        };
      tests = {
        "ouroboros-network-framework-tests" = {
          depends = [
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."bytestring" or (buildDepError "bytestring"))
            (hsPkgs."containers" or (buildDepError "containers"))
            (hsPkgs."directory" or (buildDepError "directory"))
            (hsPkgs."text" or (buildDepError "text"))
            (hsPkgs."time" or (buildDepError "time"))
            (hsPkgs."cborg" or (buildDepError "cborg"))
            (hsPkgs."serialise" or (buildDepError "serialise"))
            (hsPkgs."io-sim-classes" or (buildDepError "io-sim-classes"))
            (hsPkgs."typed-protocols" or (buildDepError "typed-protocols"))
            (hsPkgs."typed-protocols-examples" or (buildDepError "typed-protocols-examples"))
            (hsPkgs."network" or (buildDepError "network"))
            (hsPkgs."network-mux" or (buildDepError "network-mux"))
            (hsPkgs."ouroboros-network-framework" or (buildDepError "ouroboros-network-framework"))
            (hsPkgs."ouroboros-network-testing" or (buildDepError "ouroboros-network-testing"))
            (hsPkgs."contra-tracer" or (buildDepError "contra-tracer"))
            (hsPkgs."dns" or (buildDepError "dns"))
            (hsPkgs."iproute" or (buildDepError "iproute"))
            (hsPkgs."io-sim" or (buildDepError "io-sim"))
            (hsPkgs."QuickCheck" or (buildDepError "QuickCheck"))
            (hsPkgs."tasty" or (buildDepError "tasty"))
            (hsPkgs."tasty-quickcheck" or (buildDepError "tasty-quickcheck"))
            ] ++ (pkgs.lib).optionals (system.isWindows) [
            (hsPkgs."Win32-network" or (buildDepError "Win32-network"))
            (hsPkgs."Win32" or (buildDepError "Win32"))
            ];
          buildable = true;
          };
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchgit {
      url = "https://github.com/input-output-hk/ouroboros-network";
      rev = "65a7abfd704c58091dd7b862b5e9f78cf334f8dc";
      sha256 = "0dz8sq4vzhh2asi0h7l1y7578rzkcss9z6gf7njrbajg7ymh5qrz";
      });
    postUnpack = "sourceRoot+=/ouroboros-network-framework; echo source root reset to \$sourceRoot";
    }