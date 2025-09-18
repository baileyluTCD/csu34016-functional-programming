{ pkgs, ... }:
pkgs.mkShell {
  packages = with pkgs; [
    stack
  ];
}
