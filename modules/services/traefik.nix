{ config, ... }:

{
  sops.secrets = {

    "star.nixos.local.crt" = {
      format = "binary";      
      owner = "traefik";
      sopsFile = ../../secrets/certs/star.nixos.local.crt;
    };

    "star.nixos.local.key" = {
      format = "binary";      
      owner = "traefik";
      sopsFile = ../../secrets/certs/star.nixos.local.key;
    };
  };

  services.traefik = {
    enable = true;
    group = "docker";

    staticConfigOptions = {
      global.sendAnonymousUsage = false;

      api = {
        dashboard = true;
        insecure = true;
        debug = false;
      };

      log.level = "DEBUG";

      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        websecure.address = ":443";
      };
    };

    dynamicConfigOptions = {
      tls.certificates = [
        {
          certFile = config.sops.secrets."star.nixos.local.crt".path;
          keyFile = config.sops.secrets."star.nixos.local.key".path;
        }
      ];

      http = {
        routers = {
          dashboard = {
            rule = "Host(`traefik.nixos.local`)";
            service = "api@internal";
            entryPoints = [ "web" "websecure" ];
            tls = true;
          };
        };
      };
    };
  };
}
