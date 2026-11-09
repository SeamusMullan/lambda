# UTM / QEMU guest integration. Import from VM hosts only.
#
# UTM settings that make this work:
#   • Backend:  QEMU (not Apple Virtualization — no SPICE there)
#   • Display:  virtio-gpu-pci  (ramfb locks the resolution)
#   • Clipboard sharing: on
{
  services.qemuGuest.enable = true; # host ↔ guest agent (clean shutdown, time sync)
  services.spice-vdagentd.enable = true; # clipboard + auto-resize the X display with the UTM window

  # Retina MacBook: if everything is tiny, uncomment. Stylix does NOT set DPI.
  # services.xserver.dpi = 144;

  # Virtual GPU: a software compositor backend is the safe choice (see modules/home/picom.nix).
}
