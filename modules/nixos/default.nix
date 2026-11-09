# Core system modules every Lambda host gets.
# Hardware-specific modules (vm-guest.nix, future laptop.nix…) are imported by the host instead.
{
  imports = [
    ./nix.nix
    ./x11-i3.nix
    ./users.nix
    ./audio.nix
  ];
}
