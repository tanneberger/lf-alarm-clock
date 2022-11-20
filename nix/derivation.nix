{ stdenv, pkgs, lib, fetchFromGitHub, reactor-cpp, ... }:
stdenv.mkDerivation {
  name = "alarm-clock";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "revol-xut";
    repo = "lf-alarm-clock";
    rev = "d7e1265fa9a24484ed2bd3eb63ec9d3781ec0228";
    sha256 = "sha256-K3qK1oYo27nSlj3WnTgfUr7CPaaUk71Ixb5EjftyTX8=";
    fetchSubmodules = true;
  };

  buildInputs = with pkgs; [ which gcc cmake git boost ];

  configurePhase = ''
    echo "Test"
  '';

  buildPhase = ''
    echo "Starting compiling"
    mkdir -p include/reactor-cpp/
    cp -r ${reactor-cpp}/include/reactor-cpp/* include/reactor-cpp/
    ${pkgs.lingua-franca}/bin/lfc --external-runtime-path ${reactor-cpp}/ src/AlarmClock.lf
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./bin/* $out/bin
  '';
}

