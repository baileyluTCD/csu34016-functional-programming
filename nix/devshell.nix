{ pkgs, ... }:
pkgs.mkShell {
  packages = with pkgs; [
    stack
    ihaskell
    haskellPackages.quickcheck-io
    haskellPackages.QuickCheck
    haskellPackages.test-framework
    haskellPackages.test-framework-quickcheck2
  ];
}
