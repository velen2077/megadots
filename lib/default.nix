{
  lib,
  builtins,
  ...
}: {
  file = import ./file.nix {inherit lib builtins;};
}
