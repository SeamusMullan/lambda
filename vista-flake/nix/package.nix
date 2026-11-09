{
  lib,
  stdenv,
  src,
  cmake,
  pkg-config,
  makeWrapper,
  SDL2,
  SDL2_image,
  feh,
  # optional OpenGL renderer (CMake option USE_SHADERS)
  withShaders ? false,
  libGL,
  glew,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "vista";
  version = "0.1.0";
  inherit src;

  nativeBuildInputs = [
    cmake
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    SDL2
    SDL2_image
  ]
  ++ lib.optionals withShaders [
    libGL
    glew
  ];

  # Nix builds are sandboxed and reproducible; -march=native is neither. Strip it if present.
  postPatch = ''
    substituteInPlace CMakeLists.txt --replace-quiet "-march=native" ""
  '';

  cmakeFlags = [
    (lib.cmakeBool "USE_SHADERS" withShaders)
    (lib.cmakeBool "BUILD_DOCS" false)
  ];

  # vista execs `feh` at runtime — make sure it's on PATH regardless of the user's profile.
  postInstall = ''
    wrapProgram $out/bin/vista --prefix PATH : ${lib.makeBinPath [ feh ]}
  '';

  meta = {
    description = "dmenu-style wallpaper switcher with thumbnails";
    homepage = "https://github.com/SeamusMullan/vista"; # TODO confirm
    license = lib.licenses.mit; # TODO match LICENSE
    platforms = lib.platforms.linux;
    mainProgram = "vista";
  };
})
