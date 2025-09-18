{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
  gencw-bin = pkgs.fetchurl {
    url = "https://learn-eu-central-1-prod-fleet01-xythos.content.blackboardcdn.com/62b985ffa0afc/21941527?X-Blackboard-S3-Bucket=learn-eu-central-1-prod-fleet01-xythos&X-Blackboard-Expiration=1759428000000&X-Blackboard-Signature=udDiqD8%2FHjQiWBof%2By3u0%2FS8W8iKuBQnmVX%2FH96V9Ig%3D&X-Blackboard-Client-Id=300200&X-Blackboard-S3-Region=eu-central-1&response-cache-control=private%2C%20max-age%3D21600&response-content-disposition=attachment%3B%20filename%3D%22gencw%22%3B%20filename%2A%3DUTF-8%27%27gencw&response-content-type=application%2Foctet-stream&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEJX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDGV1LWNlbnRyYWwtMSJHMEUCIBoY1rdcKY0AZm2iBBQi3qZDkb0rVivK9mqiCELi%2BON5AiEArCqbBe2Cx00dHaOWZeMptPmXnm9v4EoX0CNm5u46lmwqvQUILxAEGgw2MzU1Njc5MjQxODMiDL7lFv02JP%2BUkkgeGyqaBTcIqSv9CmgQFHYhanMkOTOpmTRCsIUZ8atdGMKEocr6zYVmZkYDBf%2F0LC32TkfSMT4TCJ3CMNzGfqC1pYesySamI5kyQ2hsAZrr5P1XPoKMbQwI9zoEfZRkVB%2FKHZw3Jb8SqJri%2FmzS1JaEKrxJ4uXryfWI40OjmdTjLVbDASpSb69Q9A31GXZ1S7lxPjtQvdp6mrPaKPrS6TXVZkA5iXwGB2g37h%2F9oLTZnpYKvGfMykM%2FwV2BXfQ7qjFMXgmR6k%2B1k%2FS%2BdNtN73mW022ITjBLRjy1%2By9reV2K%2BcuZwIFr1KDnK8%2Fae3pfyLIkXfYV7xIC9wv0ZIbiQq0P2RPDj72eIoAQ%2F9aF81dQrtWS0gVYv0WqU5r1NgysIE%2Bqr9Iq2CUl47Zg4UthfFfJXoYcBtChEnyTj5v8Xmn8Gp%2BsgrUCMxB73K5bId1XJeXB91xRtT6SiTjOglKVf6RYPk4%2B7Fg3ROJLO3FAdGY%2FFeJ73ZtlE6vcelrJB1N4W%2FRpN2kQ6%2FDin4mdCbpK1pjMzeOidYBS1m1l%2FuG1v0eNlm7bNgBiOpHqk9iTXAWuL4A%2F%2BwH11z7Z6SWV3knbyjSJNF9ycZnUbIlAtga3LO1OBHg9T023ajCEGx7QM%2BCGbu012B%2Fh%2F4050N2jq2atGAotX2RqF99ljQHVQLhO4xVrJDAfshQQxEFaLl%2Fed8Gz0xEchUDDYVUXWreciWrq4a2KfCTEi7kT0RPfB3Kdl9oLH9TQEuB4YtQXtaL3YG1px1fM4gY%2FJRfbfJ3kAh8qkjvdCyrsaZdpqWnTU30a0%2FHEw7Met1yO1TujctLCCzDk3pRz5dU%2FuMHJGnWbSEGbRgcGgEO%2FA3mnHonUX1bvY0Ta7bGrySH%2B42mv7nOMh7IFXDDi%2BfnGBjqxAZX0cFSNDq4USTBC0p8FEYSFCGnC5eB%2Binw9WzoEorbrfAsmh%2FAxDbVzK%2Fk0P07onKy7ka8mLosZqzSdh06k8vHTJbR5Vu1VdQBuYa%2B1MxhfIYVrWFFJQCO3Nrqh8rF8x7%2BFgLN1cy3PV1snuz0kdusE23TMRgg10ZfK58OkFVckx48drd1sqKeLe%2FGKTeSZKEJ%2FP0cZNFRvPMUjpRQuXh%2BcH3kZmzgFc7d8r8aML6HOsA%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20251002T120000Z&X-Amz-SignedHeaders=host&X-Amz-Expires=21600&X-Amz-Credential=ASIAZH6WM4PLW3O4222S%2F20251002%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Signature=dcbc813e14caf108365b8b1332af937603e7f56ceb7031b1d4a4b520e468e2e0";
    hash = "sha256-X2czquCICRN+uNzMtq7LoNsV0Udinvh+8xgWAaG1848=";
  };
in

stdenv.mkDerivation (finalAttrs: {
  pname = "gencw";
  version = "2";

  src = gencw-bin;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    gmp
  ];

  sourceRoot = ".";

  dontUnpack = true;

  installPhase = ''
    install -m755 -D ${gencw-bin} $out/bin/gencw-${finalAttrs.version}
  '';

  meta.mainProgram = "gencw-${finalAttrs.version}";
})
