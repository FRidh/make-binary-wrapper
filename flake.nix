{
  description = "Tool to generate binary wrappers that wrap executables";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: let 
    pkgs = nixpkgs.legacyPackages.${system};

  in rec {
    packages.make-binary-wrapper = pkgs.callPackage ./default.nix { };

    defaultPackage = packages.make-binary-wrapper;

    checks = pkgs.callPackages ./tests.nix {
      inherit (packages) make-binary-wrapper;
    };
  });
}
