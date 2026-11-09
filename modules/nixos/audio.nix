# PipeWire with PulseAudio + ALSA shims. polybar's pulseaudio module and `wpctl` keybinds use this.
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = false; # no 32-bit on aarch64
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
