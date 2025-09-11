{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    google-cloud-sdk
    # (google-cloud-sdk.withExtraComponents [
    #   google-cloud-sdk.components.cloud-build-local
    # ])
  ];
}
