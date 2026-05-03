{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs_22 # Or another version
    pkgs.nodePackages.pnpm # Optional: for pnpm support
  ];
  
  shellHook = ''
    echo "Node.js $(node --version) loaded"
    # Optional: Automatically start fish
    # exec fish
  '';
}