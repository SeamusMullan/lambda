# Exposes flake inputs as ordinary pkgs.<name> so modules never touch `inputs` directly.
inputs: final: prev:
let
  system = final.stdenv.hostPlatform.system;
in
{
  vista = inputs.vista.packages.${system}.default;

  # TODO: your dmenu replacement
  # <launcher> = inputs.launcher.packages.${system}.default;
}
