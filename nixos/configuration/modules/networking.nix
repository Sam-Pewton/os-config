{ config, lib, pkgs, ... }:

{
  imports = [];

  # Networking
  networking = {
    hostName = "nixos-desktop";
    hosts = {};
    networkmanager = {
      enable = true;
    };
  };
}
