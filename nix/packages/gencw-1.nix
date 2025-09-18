{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
  gencw-bin = pkgs.fetchurl {
    url = "https://learn-eu-central-1-prod-fleet01-xythos.content.blackboardcdn.com/62b985ffa0afc/21657233?X-Blackboard-S3-Bucket=learn-eu-central-1-prod-fleet01-xythos&X-Blackboard-Expiration=1758207600000&X-Blackboard-Signature=8lwc176MfWXjA5vA7rxT5H1X9hnNMpxYSy7GOxg1+0M=&X-Blackboard-Client-Id=300200&X-Blackboard-S3-Region=eu-central-1&response-cache-control=private, max-age=21600&response-content-disposition=attachment; filename=\"gencw\"; filename*=UTF-8''gencw&response-content-type=application/octet-stream&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEEEaDGV1LWNlbnRyYWwtMSJHMEUCIQCLUDhGaY8XuQMOb7RvxAu5QvRCGY35pxIbrcIhcLlErQIgWvbyLd58psWLvTzZjjfghGAisqxBvPxThdp9UA3A5kgqxgUIuv//////////ARAEGgw2MzU1Njc5MjQxODMiDI3+5lgaE3w2GEGSrCqaBW/kGXIZOJ0wqPLb5WCwOZkvxCAprXlCWmsk01lWdKx3zqwFhfozwlsR1awL/7ANkr0aXwTxQnFCGC4e/K16tMDH/Yoc+QjfiY0+g37ZCKLBtPp3TdlUnOljQSzwh5v6f/koJo8B9sTSJv6vC7wy989nzXerfOJzGs14JzN6VwWtZQhM2bQ9Smdi5mTsj44RtCzF9ZD4g0ABxx7vZQ6V+UiC9OciJ0pKsvXTJf+XIHueUh3Tb4DAq0qVTej5I3IqcU21chrg/ytvbFWZbnUcGNMMmxDwh7w50QcqPubI/BkY1DyG8v0LCiSdgBWqMNIuxFJMLMt6PcTxNMORR8/pZbZVnYGYQQHD2b3ZVQ3Als3Gtvw0g/E05a4hFx5WBbgRRcL/HsKMqsil1L4poKlywFzMLajCSXdLnPP9PtjlT8PtbAviz8/+6TopVtvgUDw7/CYANvh7R3tmBJF4dioR0nAnsiPmrzebNw0z1Cznz3cNONviJM0iC/5C1dCCwyszfkx77Rxj6oCkLuGOPG4PFtxOLoH8mjgZF+klLDWIxcMNtT9p14X7CwzkBJeTouN7WC4yjIWE8+F4nrvkO/R22zicr5xoxaX56to89OhfMQ76r8UnElINxVogymDHxmJ/SATarMcCqjVqQUKt5vZKTCwgwyd6npC3UMDMTorPTdz7DteXO6Afg2jiiQlkwfih6PkSrzq+ixXe83wLeqWco3aecG3WdtRLN4E67uXqPxRd85p6Yl8lNHpD5hzHnvTkQrDW/wvGdoeEZTeFGX4VAA4VvkJRufOsic9wC5vRFkx+Vg3QCdwmETaBSNB8t+1q+dyX4EvODxLHnQV+orrc1IvVaLvQLWqUaSc9dlJFcxpSxY99vvhv++tjuDChiq/GBjqxAfoEW+ZUrdtfbgSk2u2KfB2AAJ1AnZRIo+cc8QYXi1IIeeWURLlLwVkVzTGeF7iy2n/gaeVDNPP5gv/bvgZjQCf1cYSLzQ29hKu5hOQuYIjYsJT1hO/YixS1r7n308Fx7MDJnsbY38juVpDSmH4g4Rmxmaxthj1wP0JjSLiRKnCpalS3oLjK6iPB1HsdqZ/WDFz+s/w7l/US3SU1LQ2XX55cAzXdnzXyMptz6MqPys4VbQ==&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20250918T090000Z&X-Amz-SignedHeaders=host&X-Amz-Expires=21600&X-Amz-Credential=ASIAZH6WM4PLXCIXMAWT/20250918/eu-central-1/s3/aws4_request&X-Amz-Signature=e77ff5224e887a3e75600dd2e68dd9fe769c24b959ff03d235c68682c78cf43c";
    hash = "sha256-sP0saSzy1LekGKIF5qU++wI0GfLpYZBnEyb8tkFlzps=";
  };
in

stdenv.mkDerivation (finalAttrs: {
  pname = "gencw";
  version = "1";

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
