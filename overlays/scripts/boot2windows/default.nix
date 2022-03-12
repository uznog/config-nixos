{ writeScriptBin, stdenv, grub2 }:

writeScriptBin "boot2windows" ''
  #!${stdenv.shell}
  sudo ${grub2}/bin/grub-reboot "Windows 10"
  systemctl reboot
''
