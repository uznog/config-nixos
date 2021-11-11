{ config, pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./hardware-configuration.nix
    <nixos-hardware/dell/xps/15-9500/nvidia>
    <home-manager/nixos>
  ];


  home-manager.users.${config.settings.user.name} = import ../home/home.nix;
  home-manager.useGlobalPkgs = true;

  boot.loader = {
    systemd-boot.enable = true;
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      gfxmodeEfi = "1024x768";
      useOSProber = false;
      extraEntries = ''
        menuentry "Windows 10" {
          insmod part_gpt
          insmod fat
          search --fs-uuid --set=root 2E0A-0011
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/dbcb9474-96b2-4049-8bd7-ce395a333cdc";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.binfmt = {
    emulatedSystems = [
      "aarch64-linux"
    ];
  };

  boot.supportedFilesystems = [ "ntfs" ];
  
  time.timeZone = "Europe/Warsaw";

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-switch-on-connect
    '';
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable="Source,Sink,Media,Socket";
      };
    };
  };

  networking = {
    hostName = "nixos";
    useDHCP = false;
    hostFiles = [ "${/. + config.settings.host.hostsFile}" ];

    firewall = {
      enable = false;
      # KDE Connect required ports
      allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
      allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
    };

    networkmanager = {
      enable = true;
      enableStrongSwan = true;
      packages = with pkgs; [
        networkmanager-l2tp
      ];
    };
  };

  console.useXkbConfig = true;

  services = {
    cron.enable = true;

    openssh.enable = true;

    blueman.enable = true;

    strongswan = {
      enable = true;
      secrets = [
        "ipsec.d/ipsec.nm-l2tp.secrets"
      ];
    };

    tlp.enable = true;

    k3s.enable = false;

    xserver = {
      enable = true;
      autorun = true;

      libinput = {
        enable = true;
      };

      layout = "pl"; 
      xkbOptions = "ctrl:nocaps";

      desktopManager = {
        xterm.enable = false;
        plasma5.enable = true;
      };

      displayManager = {
        autoLogin = {
          enable = true;
          user = "${config.settings.user.name}";
        };
      };

      windowManager.bspwm = {
        enable = false;
      };

      windowManager.i3 = {
        enable = false;
        package = pkgs.i3-gaps;
      };
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      liveRestore = false;
    };

    containerd.enable = true;

    libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu = {
        runAsRoot = false;
        ovmf = {
          enable = true;
          package = pkgs.OVMFFull;
        };
      };
    };
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
    doas = {
      enable = false;
    };
  };

  users.users.${config.settings.user.name} = {
    isNormalUser = true;
    home = config.settings.user.homeDir;
    description = config.settings.user.fullname;
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "libvirtd" ];
    uid = 1000;
    shell = pkgs.bash;
  };

  environment = {

    systemPackages = with pkgs; [
      wget
      git
      xdg_utils
    ];

    loginShellInit = ''
      if [ -e $HOME/.profile ]
      then
        . $HOME/.profile
      fi
    '';
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  system.stateVersion = "21.11";
}
