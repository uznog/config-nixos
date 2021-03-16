{ config, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "209566c752c4428c7692c134731971193f06b37c";
    ref = "release-20.09";
  };
in
{
  imports = [
      ../modules/settings.nix
      (import "${home-manager}/nixos")
  ];

  time.timeZone = "Europe/Warsaw";

  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;
  networking.interfaces.enp0s8.useDHCP = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  virtualisation.virtualbox.guest.enable = true;

  services.xserver = {
    enable = true;
    autorun = true;
    libinput.enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.${config.settings.username} = {
    isNormalUser = true;
    home = "/home/${config.settings.username}";
    description = "${config.settings.name}";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" ];
    uid = 1000;
    shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
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

  home-manager.users.${config.settings.username} = import ../config/home.nix;

  system.stateVersion = "20.09";
}
