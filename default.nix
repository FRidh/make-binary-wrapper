{ stdenv
, targetPackages
, python3Minimal
}:

# Python is used for creating the instructions for the Nim program which
# is compiled into a binary.
#
# The python3Minimal package is used because its available early on during bootstrapping.
# Python packaging tools are avoided because this needs to be available early on in bootstrapping.

let
  python = python3Minimal;
  sitePackages = "${placeholder "out"}/${python.sitePackages}";
  nim = targetPackages.nim;
in stdenv.mkDerivation {
  name = "make-binary-wrapper";

  src = ./src;

  buildInputs = [
    python
  ];

  strictDeps = true;

  postPatch = ''
    ls -l
    substituteInPlace lib/libwrapper/compile_wrapper.py \
      --replace 'NIM_EXECUTABLE = "nim"' 'NIM_EXECUTABLE = "${nim}/bin/nim"' \
      --replace 'STRIP_EXECUTABLE = "strip"' 'STRIP_EXECUTABLE = "${targetPackages.binutils-unwrapped}/bin/strip"'
    substituteAllInPlace bin/make-wrapper
  '';

  inherit sitePackages;  
  
  dontBuild = true;
  
  installPhase = ''
    mkdir -p $out/${python.sitePackages}
    mv bin $out/
    mv lib/libwrapper $out/${python.sitePackages}
  '';

  meta = {
    description = "Tool to create binary wrappers";
    license = with stdenv.lib.licenses; [ mit ];
  };
}