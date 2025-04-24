{
  description = "nixsvcs demo";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };
    nixsvcs = {
      url = "github:RazYang/nixsvcs";
    };
  };

  outputs =
    { nixpkgs, nixsvcs, ... }:
    {
      packages = (with nixpkgs; lib.genAttrs lib.systems.flakeExposed) (
        system:
        let
          nixpkgsConfig = {
            inherit system;
            overlays = [
              (import ./nixpkgs-overlay.nix nixsvcs.lib.infuse)
            ];
          };
          pkgs = import nixpkgs nixpkgsConfig;

          svcs = import nixsvcs {
            inherit nixpkgs nixpkgsConfig;
            overlays = [
              (import ./nixsvcs-overlay.nix)
            ];
          };
        in
        {
          # `svcs.hell210` equals to `svcs.svcsCross.musl64.hello210`
          hello210 = svcs.hello210;
          hello210-closure = svcs.svcClosure.hello210;
          hello210-image = svcs.svcImage.hello210;
          hello210-image-interactive = nixsvcs.lib.infuse svcs.svcImage.hello210 {
            __args.copyToRoot.__args.paths.__append = with pkgs; [
              toybox
              bashInteractive
            ];
          };

          hello210-musl64 = svcs.svcsCross.musl64.hello210;
          hello210-musl64-closure = svcs.svcsCross.musl64.svcClosure.hello210;
          hello210-musl64-image = svcs.svcsCross.musl64.svcImage.hello210;
          hello210-musl64-image-interactive = nixsvcs.lib.infuse svcs.svcsCross.musl64.svcImage.hello210 {
            __args.copyToRoot.__args.paths.__append = with pkgs.pkgsCross.musl64; [
              toybox
              bashInteractive
            ];
          };
        }
      );
    };

}
