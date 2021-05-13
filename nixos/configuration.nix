{ config, pkgs, ... }:

let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    rev = "241d8300b2746c1db715eaf8d64748990cd0bb7a";
    ref = "master";
  };
in
{
  imports = [
      ../modules/settings.nix
      ./hardware-configuration.nix
      (import "${nixos-hardware}/dell/xps/15-9500/nvidia")
      <home-manager/nixos>
  ];

  nix.trustedUsers = [ "root" "@wheel" ];
  nixpkgs.config = import ../nixpkgs.nix;

  home-manager.users.${config.settings.username} = import ../config/home.nix { inherit pkgs config;};

  boot.loader = {
    systemd-boot.enable = true;
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      gfxmodeEfi = "1024x768";
      useOSProber = true;
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/96b3ec4e-83fb-4bd7-ae3a-bd1c3d92066a";
      preLVM = true;
      allowDiscards = true;
    };
  };
  
  time.timeZone = "Europe/Warsaw";

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;


  networking = {
    hostName = "nixos";
    useDHCP = false;

    interfaces.wlp0s20f3.useDHCP = true;

    networkmanager = {
      enable = true;
      dns = "dnsmasq";
      enableStrongSwan = true;
      packages = with pkgs; [
        networkmanager_l2tp
      ];
    };
  };

  environment.etc = {
    "${config.settings.username}-hosts".source = ../../config-sensitive/hosts;
    "NetworkManager/dnsmasq.d/dns.conf".text = "addn-hosts=/etc/${config.settings.username}-hosts";
  };

  programs.nm-applet.enable = true;

  console.useXkbConfig = true;

  services = {
    openssh.enable = true;

    blueman.enable = true;

    strongswan = {
      enable = true;
      secrets = [
        "ipsec.d/ipsec.nm-l2tp.secrets"
      ];
    };

    tlp.enable = true;

    xserver = {
      enable = true;
      autorun = true;

      libinput = {
        enable = true;
        disableWhileTyping = true;
      };

      layout = "pl"; 
      xkbOptions = "ctrl:nocaps";

      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        autoLogin = {
          enable = true;
          user = "${config.settings.username}";
        };
        defaultSession = "none+i3";
      };

      windowManager.bspwm = {
        enable = false;
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };

    libvirtd = {
      enable = true;
      onBoot = "ignore";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.${config.settings.username} = {
    isNormalUser = true;
    home = "/home/${config.settings.username}";
    description = "${config.settings.name}";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "libvirtd" ];
    uid = 1000;
    shell = pkgs.bash;
  };

  users.users.nixos.initialPassword = "nixos";

  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    xdg_utils
  ];

  environment.loginShellInit = ''
	if [ -e $HOME/.profile ]
	then
		. $HOME/.profile
	fi
  '';

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];


  system.stateVersion = "20.09";
}
