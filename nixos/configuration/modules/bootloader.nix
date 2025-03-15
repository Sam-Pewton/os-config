{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../hardware-configuration.nix
    ];

  # Use Grub.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      devices = ["nodev"];
      default = 0;
      enable = true;
      efiSupport = true;
      useOSProber = true;
      extraConfig = ''
        GRUB_TIMEOUT=-1
      '';
      extraEntries = ''
        menuentry "Windows 11" --class windows --class os {
          insmod part_gpt
          insmod fat
          search --no-floppy --fs-uuid --set=root 408D-8745
          chainloader /efi/Microsoft/Boot/bootmgfw.efi          
        }
      '';
    };
  };
}
