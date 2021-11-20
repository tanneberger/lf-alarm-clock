{stdenv, pkgs, lib, fetchFromGitHub,...}:
let
lfc = stdenv.mkDerivation {
  pname = "lfc";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "revol-xut";
    repo = "lingua-franca-nix-releases";
    rev = "11c6d5297cd63bf0b365a68c5ca31ec80083bd05";
    sha256 = "DgxunzC8Ep0WdwChDHWgG5QJbJZ8UgQRXtP1HZqL9Jg=";
  };

  buildInputs = with pkgs; [ jdk11_headless ];

  _JAVA_HOME = "${pkgs.jdk11_headless}/";

  postPatch = ''
    substituteInPlace bin/lfc \
      --replace 'base=`dirname $(dirname ''${abs_path})`' "base='$out'" \
      --replace "run_lfc_with_args" "${pkgs.jdk11_headless}/bin/java -jar $out/lib/jars/org.lflang.lfc-0.1.0-SNAPSHOT-all.jar"
  '';

  installPhase = ''
    cp -r ./ $out/
    chmod +x $out/bin/lfc
  '';

  meta = with lib; {
    description = "Polyglot coordination language";
    longDescription = ''
      Lingua Franca (LF) is a polyglot coordination language for concurrent
      and possibly time-sensitive applications ranging from low-level
      embedded code to distributed cloud and edge applications.
    '';
    homepage = "https://github.com/lf-lang/lingua-franca";
    license = licenses.bsd2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ revol-xut ];
  };
};

cpp-runtime = fetchFromGitHub {
  owner = "lf-lang";
  repo = "reactor-cpp";
  rev = "007143225dbc198a5fee233ce125c3584a9541d8";
  sha256 = "sha256-wiBTJ4jSzoAu/Tg2cMqMWv7qZD29F+ysDOOF6F/DLJM=";
};

in
  stdenv.mkDerivation {
    name = "alarm-clock";
    version = "0.0.1";

    src = fetchFromGitHub {
      owner = "revol-xut";
      repo = "lf-alarm-clock";
      rev = "2b7cecb842935c84a3a3264769ee5ece48c8ea79";
      sha256 = "sha256-zsahCcGmIg685rZjoBZ5U/QM4EyeXEWt31jpDTrNZp8=";
    };
    #src = ./.;

    buildInputs = with pkgs; [ lfc which gcc cmake git boost ];

    configurePhase = ''
      echo "Test";
    '';

    buildPhase = ''
      echo "Starting compiling"
      ${lfc}/bin/lfc src/Clock.lf src/Networking.lf
    '';

    installPhase = ''
      cp bin/Networking $out/
    '';
  }

