{ config, pkgs, ... }:

let
  selfsigned_crt = "${/. + config.settings.user.homeDir + "/etc/config-sensitive/certs/star.nixos.local.crt"}";
  selfsigned_key = "${/. + config.settings.user.homeDir + "/etc/config-sensitive/certs/star.nixos.local.key"}";
in
{
  services.traefik = {
    enable = config.settings.services.traefik.enable;
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
          certFile = selfsigned_crt;
          keyFile = selfsigned_key;
        }
      ];

      http = {
        routers = {
          grafana = {
            rule = "Host(`grafana.nixos.local`)";
            service = "grafana";
            entryPoints = [ "web" "websecure" ];
            tls = true;
          };

          prometheus = {
            rule = "Host(`prometheus.nixos.local`)";
            service = "prometheus";
            entryPoints = [ "web" "websecure" ];
            tls = true;
          };

          dashboard = {
            rule = "Host(`traefik.nixos.local`)";
            service = "api@internal";
            entryPoints = [ "web" "websecure" ];
            tls = true;
          };
        };

        services = {
          grafana.loadBalancer.servers = [ { url = "http://127.0.0.1:3000"; } ];
          prometheus.loadBalancer.servers = [ { url = "http://127.0.0.1:9090"; } ];
        };

      };
    };
  };
}
