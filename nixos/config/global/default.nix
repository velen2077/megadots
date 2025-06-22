{myLib, ...}: {
  imports = mylib.file.scanPaths ./.;
}
