final: prev:

{
  boot2windows = final.callPackage ./scripts/boot2windows {};
  tidal = final.callPackage ./scripts/tidal {};
  edit-l2tp-vpn = final.callPackage ./scripts/edit-l2tp-vpn {};
  run-minio = final.callPackage ./scripts/run-minio {};
}
