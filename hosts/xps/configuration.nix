inputs@{ config, pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./hardware-configuration.nix
  ];

  documentation.nixos.enable = true;

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
    enable = false;
    mediaKeys.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    media-session.config.bluez-monitor.rules = [
      {
        # Matches all cards
        matches = [ { "device.name" = "~bluez_card.*"; } ];
        actions = {
          "update-props" = {
            "bluez5.reconnect-profiles" = [ "a2dp_sink" "hfp_hf" "hsp_hs" ];
            # mSBC is not expected to work on all headset + adapter combinations.
            "bluez5.msbc-support" = true;
            # SBC-XQ is not expected to work on all headset + adapter combinations.
            "bluez5.sbc-xq-support" = true;
          };
        };
      }
      {
        matches = [
          # Matches all sources
          { "node.name" = "~bluez_input.*"; }
          # Matches all outputs
          { "node.name" = "~bluez_output.*"; }
        ];
        actions = {
          "node.pause-on-idle" = false;
        };
      }
    ];
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
    hostFiles = [ "${inputs.sensitive}/hosts" ];

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

  programs.ssh.ciphers = [ "aes128-cbc" "3des-cbc" "aes192-cbc" "aes256-cbc" "chacha20-poly1305@openssh.com" "aes128-ctr" "aes192-ctr" "aes256-ctr" "aes128-gcm@openssh.com" "aes256-gcm@openssh.com" ];

  services = {
    cron.enable = true;
    openssh.enable = true;
    blueman.enable = true;

    minio = {
      enable = true;
      listenAddress = ":9000";
      consoleAddress = ":9001";
      rootCredentialsFile = "${config.settings.user.homeDir}/etc/config-sensitive/minio/credentials";
    };

    strongswan = {
      enable = true;
      secrets = [
        "ipsec.d/ipsec.nm-l2tp.secrets"
      ];
    };

    tlp.enable = true;

    #thermald.configFile = ./thermal-conf.xml;

    xserver = {
      enable = true;
      autorun = true;

      libinput = {
        enable = true;
      };

      layout = "pl"; 
      xkbOptions = "ctrl:nocaps";
      libinput = {
        touchpad = {
          tapping = true;
        };
      };

      desktopManager = {
        xterm.enable = false;
        plasma5.enable = true;
      };

      displayManager = {
        autoLogin = {
          enable = true;
          user = "${config.settings.user.name}";
        };
        sddm = {
          enable = true;
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

  programs.atop = {
    enable = true;
    atopService.enable = true;
    atopacctService.enable = true;
    atopgpu.enable = true;
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

  home-manager = {
    users.${config.settings.user.name} = import ../../home/home.nix;
    extraSpecialArgs = {
      # inputs from line1 will be available as `args` in home.nix
      inherit (inputs) dotfiles;
    };
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

  system.stateVersion = "22.05";
}
