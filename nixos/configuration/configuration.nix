# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in
{
  imports =
    [
      (import "${home-manager}/nixos")
      ./hardware-configuration.nix
      ./modules/bootloader.nix
      ./modules/networking.nix
      ./modules/unfree.nix
      ./modules/virtualisation.nix
    ];
  
  # System Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];

  # Users
  users.users = {
    sam = {
      shell = pkgs.zsh;
      isNormalUser = true;
      home = "/home/sam";
      description = "Sam Pewton";
      extraGroups = ["audio" "wheel" "networkmanager" "docker" "libvirtd"];
      packages = with pkgs; [
	alacritty
	ansible
	awscli
	clang
	cmake
        cudatoolkit
	discord
	docker-buildx
        docker-compose
        gcc
	gimp
	gnumake
	go
	htop
	iosevka
	jq
	libreoffice-qt
	micromamba
        neovim
	nodejs
	obs-studio
	obsidian
	postman
	python3
	rustup
	rust-analyzer
	spotify
	steam
	sqlite
	tmux
        tree
	unzip
      ];
    };
  };
  home-manager.users.sam = { pkgs, ... }: {
    home.stateVersion = "24.05";
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
	  blur-my-shell.extensionUuid
        ];
      };
    };
    programs = {
      alacritty = {};
      chromium = {
        enable = true;
	package = pkgs.brave;
	extensions = [
	  { id = "bcjindcccaagfpapjjmafapmmgkkhgoa"; }
	];
	commandLineArgs = [];
      };
      git = {
	enable = true;
	userName = "Sam Pewton";
	userEmail = "s.pewton@outlook.com";
      };
      zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          rebuild = "sudo nixos-rebuild switch";
	  ll = "ls -l";
	  nix-shell-rust = "nix-shell --run zsh ~/nix-shells/rust.nix";
	  nix-shell-py = "nix-shell --run zsh ~/nix-shells/python.nix";
	  mamba = "micromamba";
        };
	dotDir = ".config/zsh";
        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "history"
            "rust"
          ];
          theme = "half-life";
        };
      };
    };
  };

  # Time
  time = {
    timeZone = "Europe/London";
  };

  hardware = {
    # Audio
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    # OpenGL
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    # Nvidia
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  services = {
    # X11
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    # Printing
    printing = {
      enable = true;
    };
    # Touchpad support
    libinput = {
      enable = true;
    };
    # OpenSSH
    openssh = {
      enable = true;
    };
  };

  # Packages to exclude from GNOME
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-music
    epiphany
    geary
    totem
    tali
    iagno
    hitori
    atomix
  ]);

  # Oth program enablement
  programs = {
    virt-manager = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

