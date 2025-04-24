final: prev: # overlay args
{
  # add your own services here
  # pkgs.hello210 is added in nixpkgs-overlay.nix
  # callService ≈ callPackage, you can also use this like `callService ./some_service.nix { }`
  # idle service as current service dependencies
  hello210 = final.callService (
    {
      pkgs,
      mkS6Longrun,
      idle,
      ...
    }:
    mkS6Longrun {
      sname = "hello210";
      deps = [ idle ];
      run = pkgs.writeShellScript "run" ''
        while true; do
          ${pkgs.hello210}/bin/hello
          ${pkgs.s6-portable-utils}/bin/s6-sleep 1
        done
      '';
    }
  ) { };

  # idle service, just sleep
  idle = final.callService (
    { pkgs, mkS6Longrun, ... }:
    mkS6Longrun {
      sname = "idle";
      run = pkgs.writeShellScript "run" ''
        while true; do
          ${pkgs.s6-portable-utils}/bin/s6-sleep 60
        done
      '';
    }
  ) { };
}
