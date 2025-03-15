{ config, lib, pkgs, ... }:

{
  imports = [];

  # Virtualisation
  virtualisation = {
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
    };
  };
}
