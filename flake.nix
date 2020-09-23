{
  description = "Tool to generate binary wrappers that wrap executables";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: let 
    pkgs = nixpkgs.legacyPackages.${system};

  in rec {
    packages.make-binary-wrapper = pkgs.callPackage ./default.nix { };

    packages.tests = pkgs.callPackage ./tests.nix {
      inherit (packages) make-binary-wrapper;
    };
  
    defaultPackage = packages.make-binary-wrapper;
  
    checks.tests = packages.tests;
  });
}
