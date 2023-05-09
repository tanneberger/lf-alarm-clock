{ pkgs, lib, ... }:
let
  alarm-clock = pkgs.callPackage ../derivation.nix {
    mkDerivation = pkgs.stdenv.mkDerivation;
  };
  cfg = config.deployment.alarm-clock;
in
{
  options.deployment.alarm-clock = with lib; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable lf-alarm-clock";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd = {
      services."lf-alarm-clock" = {
        enable = true;
        wantedBy = [ "multi-user.target" ];
        script = ''
          ${pkgs.coreutils}/bin/touch /home/${users.users.lf-alarm-clock.name}/alarm_clock_events.csv
          ${pkgs.coreutils}/bin/chmod 777 /home/${users.users.lf-alarm-clock.name}/alarm_clock_events.csv
          ${pkgs.coreutils}/bin/chmod 777 /home/${users.users.lf-alarm-clock.name}
          ${pkgs.coreutils}/bin/chown lf-alarm-clock /home/${users.users.lf-alarm-clock.name}/alarm_clock_events.csv
          ${pkgs.coreutils}/bin/echo "Starting AlarmClock"
          ${alarm-clock}/bin/AlarmClock
        '';

        serviceConfig = {
          User = "lf-alarm-clock";
          Restart = "on-failure";
        };
      };
    };

    users.users.lf-alarm-clock = {
      name = "lf-alarm-clock";
      extraGroups = [ "audio" "wheel" ];
      description = "custom user for service";
      createHome = true;
      isNormalUser = true;
    };
  };
}

