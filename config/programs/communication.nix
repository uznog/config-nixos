{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (
      self: super: {
        ferdi = super.ferdi.overrideAttrs (
          old: rec {
            version = "5.6.0-beta.5";
            name = "${old.pname}-${version}";
            src = super.fetchurl {
              url = "https://github.com/getferdi/ferdi/releases/download/${version}/ferdi_${version}_amd64.deb";
              sha256 = "0x26hnszgq9pn76j1q9zklagwq5hyip7hgca7cvy9p7r59i36dbw";
            };
          }
        );
      }
    )
  ];

  home.packages = with pkgs; [
    ferdi
    signal-desktop

  ];
}
