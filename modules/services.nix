{ lib, config, ... }:

with lib;
{
  options.settings = {
    services = {
      grafana = {
        enable = mkOption {
          type = types.bool;
          default = true;
          example = false;
          description = "True if Grafana is to be enabled locally";
        };
      };

      prometheus = {
        enable = mkOption {
          type = types.bool;
          default = true;
          example = false;
          description = "True if Prometheus is to be enabled locally";
        };
      };

      traefik = {
        enable = mkOption {
          type = types.bool;
          default = true;
          example = false;
          description = "True if Traefik is to be enabled locally";
        };
      };
    };
  };
}
