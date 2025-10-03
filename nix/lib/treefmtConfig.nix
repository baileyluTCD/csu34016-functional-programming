_: {
  projectRootFile = "flake.nix";

  programs = {
    deadnix.enable = true;
    nixfmt.enable = true;
    shfmt.enable = true;
    mdformat.enable = true;
    fourmolu.enable = true;
  };
}
