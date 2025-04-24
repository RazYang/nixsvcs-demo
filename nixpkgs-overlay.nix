infuse: # using infuse rather than override and overrideAttr
final: prev: # overlay args
{
  # adding  new hello210 package into nixpkgs
  # this example use bundled infuse.nix, you can alse use original override and overrideAttr of whatever
  hello210 = infuse prev.hello {
    __attr = {
      version.__assign = "2.10";
      src.__assign = prev.fetchurl {
        url = "mirror://gnu/hello/hello-2.10.tar.gz";
        hash = "sha256-MeBmE3qWJnbon2nRtlOC3pWn732RS4y5VvQepy4PUWs=";
      };
    };
  };
}
