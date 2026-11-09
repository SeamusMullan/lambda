# Lambda

NixOS config. X11 + i3. One theme file drives every app via [Stylix](https://nix-community.github.io/stylix/).
Host `lambda` = aarch64 guest in UTM on the MacBook.

## Theme flow

```
theme/half-life.yaml  +  theme/default.nix        ← edit here, nowhere else
            │
            ▼
         Stylix  ──▶  i3 · rofi · dunst · kitty · GTK · Qt · Firefox · Chromium · lightdm · console   (built-in targets)
            │
            └──▶  config.lib.stylix.colors.base0X  ──▶  polybar.nix · vista.nix · launcher.nix   (no target → read colours directly)

Vista (runtime) ──▶ feh ──▶ wallpaper          Stylix feh target OFF so Vista's pick sticks
```

Rule: `modules/home/*` contains behaviour only. No hex, no font names.

## Layout

```
flake.nix               inputs: nixpkgs-unstable · home-manager · stylix · vista · (launcher)
hosts/lambda/           this machine: hostname, bootloader, stateVersion, hardware-configuration.nix
modules/nixos/          system: nix.nix · x11-i3.nix · users.nix · audio.nix · vm-guest.nix
modules/home/           user: options.nix · i3 · polybar · launcher · vista · kitty · browsers · dunst · picom · gtk · shell
theme/                  default.nix (Stylix, system) · home.nix (Stylix, HM-only) · half-life.yaml · wallpapers/
home/carrrot.nix        which modules this user imports
overlays/default.nix    flake inputs → pkgs.vista, pkgs.<launcher>
vista-flake/            → copy into the vista repo root (flake.nix + nix/package.nix)
```

## First build — on the VM

| # | Step | Command |
|---|------|---------|
| 1 | Clone | `git clone <repo> ~/lambda && cd ~/lambda` |
| 2 | Real hardware config | `cp /etc/nixos/hardware-configuration.nix hosts/lambda/` |
| 3 | Match install | set `system.stateVersion` + `home.stateVersion` to the value in `/etc/nixos/configuration.nix`; set username if not `carrrot` (`whoami`) |
| 4 | Vista flake | copy `vista-flake/*` into the vista repo, commit, push. Confirm the URL in `flake.nix` |
| 5 | Chromium cache check | `nix build nixpkgs#chromium --dry-run` → must say *fetched*, not *built* |
| 6 | Build | `sudo nixos-rebuild switch --flake .#lambda` |
| 7 | Check palette | open `/etc/stylix/palette.html` |

After step 6, `rebuild` (alias for `nh os switch`) does it with a diff.

## Daily

| Want | Do |
|------|----|
| Retheme | edit `theme/half-life.yaml` → `rebuild` |
| New wallpaper | drop in `theme/wallpapers/` (or `~/Pictures/Wallpapers/`) → `Super+Shift+W` |
| Hack on Vista without pushing | `sudo nixos-rebuild switch --flake . --override-input vista path:/path/to/vista` — a checkout the **VM** can see (UTM shared folder of `~/Coding/Personal`, or a clone in the VM) |
| Update everything | `nix flake update && rebuild` |
| Update one input | `nix flake update vista` |
| Add an app | new file in `modules/home/`, add to `modules/home/default.nix`. Colours: `config.lib.stylix.colors.withHashtag.base0D` |
| Turn a Stylix target off | `stylix.targets.<name>.enable = false;` in `theme/home.nix` |

## Keys (Super = Cmd)

| Key | Action |
|-----|--------|
| `Super+Return` | kitty |
| `Super+D` | launcher |
| `Super+B` | Firefox |
| `Super+Shift+W` | Vista · `Super+Ctrl+W` roulette |
| `Super+Shift+S` | region screenshot → clipboard |
| `Super+H/J/K/L` | focus · `+Shift` move |
| `Super+1–0` | workspace · `+Shift` move window |
| `Super+F` | fullscreen · `Super+Shift+Space` float |
| `Super+R` | resize mode |
| `Super+Shift+C/R/E` | reload · restart · exit |

## Verified

Full `system.build.toplevel` evaluation passes against nixpkgs `f4a03c0` (nixos-unstable, 2026-11-07), home-manager `2c0c1f0`, Stylix `3e27b6c`.
Checked outputs: i3 focused border `#ff9f43`, i3 font Inter, kitty font JetBrainsMono NF, GTK adw-gtk3, cursor Bibata, Chromium `BrowserThemeColor #0a0a0a`, Vista config rendered with scheme hex.
Vista: `vista-flake/` evaluated against the real `SeamusMullan/vista` tree → SDL3 3.4 / SDL3_image / SDL3_ttf / OpenSSL / GLEW from nixpkgs, submodules unused.
Not verified here: `stylix.targets.firefox.colorTheme` (pulls the Firefox Color extension via NUR — fine on your VM, unreachable from the sandbox).

## TODO markers

`grep -rn TODO .` — launcher wiring, git identity, keyboard layout, stateVersion, Vista config keys, repo URL.

## UTM

QEMU backend · virtio-gpu-pci display · clipboard sharing on. Retina: uncomment `services.xserver.dpi` in `modules/nixos/vm-guest.nix`.
