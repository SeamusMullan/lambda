# picom compositor — needed for kitty opacity (theme/default.nix stylix.opacity.terminal).
# xrender backend: works on virtio-gpu without 3D accel. On bare metal switch to "glx".
{
  services.picom = {
    enable = true;
    backend = "xrender";
    vSync = false; # VM: avoids stutter against the host compositor
    fade = true;
    fadeDelta = 4;
    shadow = false;
    settings = {
      unredir-if-possible = true;
      detect-client-opacity = true;
      detect-rounded-corners = false;
    };
  };
}
