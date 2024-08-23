{
  description = "YorikSar's resume";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils}: 
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      makeScripts = attrs: builtins.mapAttrs (name: value: {
        type = "app";
        program = "${pkgs.writeShellScriptBin name value}/bin/${name}";
      }) attrs;
      git = "${pkgs.git}/bin/git";
    in rec {
      defaultApp = apps.page;
      apps = makeScripts rec {
        page = "${pkgs.docutils}/bin/rst2html resume.rst index.html";
      };
    });
}
