{ config, ... }:

{
  services.openssh.enable = true;

  programs.ssh.ciphers = [
    "aes128-cbc"
    "3des-cbc"
    "aes192-cbc"
    "aes256-cbc"
    "chacha20-poly1305@openssh.com"
    "aes128-ctr"
    "aes192-ctr"
    "aes256-ctr"
    "aes128-gcm@openssh.com"
    "aes256-gcm@openssh.com"
  ];
}
