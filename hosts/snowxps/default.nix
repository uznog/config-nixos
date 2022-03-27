inputs@{ config, pkgs, ... }:

let
  username = config.settings.user.name;
in
{
  imports = [
    ./settings.nix
    ./hardware-configuration.nix

    ../../modules/services/docker.nix
    ../../modules/services/grafana.nix
    ../../modules/services/libvirtd.nix
    ../../modules/services/minio.nix
    ../../modules/services/pipewire.nix
    ../../modules/services/prometheus.nix
    ../../modules/services/ssh.nix
    ../../modules/services/strongswan.nix
    ../../modules/services/traefik.nix

    ../../modules/desktop/kde.nix
  ];

  boot.loader = {
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
  boot.kernelPackages = pkgs.linuxPackages_latest;


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
    mediaKeys.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
  };

  networking = {
    hostName = "snowxps";
    useDHCP = false;

    firewall = {
      enable = false;
      # KDE Connect required ports
      allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
      allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
    };

    networkmanager = {
      enable = true;
    };
  };

  console.useXkbConfig = true;

  services = {
    blueman.enable = true;
    tlp.enable = true;
  };

  programs.atop = {
    enable = false;
    atopService.enable = true;
    atopacctService.enable = true;
    atopgpu.enable = true;
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };


  users.users.${username} = {
    isNormalUser = true;
    home = config.settings.user.homeDir;
    description = config.settings.user.fullname;
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "libvirtd" ];
    uid = 1000;
    shell = pkgs.bash;
  };

  home-manager = {
    users.${username} = import ../../home/users/${username};
    extraSpecialArgs = {
      inherit (inputs) dotfiles;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      git
      xdg_utils
      wget
    ];
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  system.stateVersion = "22.05";
}
