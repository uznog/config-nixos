{ config, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "209566c752c4428c7692c134731971193f06b37c"; # CHANGEME 
    ref = "release-20.09";
  };
in
{
  imports = [
      ../modules/settings.nix
      (import "${home-manager}/nixos")
  ];

  time.timeZone = "Europe/Warsaw";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;
  networking.interfaces.enp0s8.useDHCP = true;

  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  services.xserver = {
    enable = true; # Actually enables the GUI
    autorun = true;
    #displayManager.defaultSession = "none+i3";
    #windowManager.i3.enable = true;
    displayManager.sddm.enable = true; # Enables SDDM
    desktopManager.plasma5.enable = true; # Enables a bare-bones Plasma desktop
    desktopManager.xterm.enable = false; # Gets rid of the bare XTerm session
    libinput.enable = true; # Better touchpad support
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.${config.settings.username} = {
    isNormalUser = true;
    home = "/home/${config.settings.username}";
    description = "${config.settings.name}";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
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

