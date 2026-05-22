final: prev: {
  fnox = prev.stdenvNoCC.mkDerivation rec {
    pname = "fnox";
    version = "1.27.1";

    src = let
      system = prev.stdenvNoCC.hostPlatform.system;
      releases = {
        aarch64-darwin = {
          target = "aarch64-apple-darwin";
          hash = "sha256-D4LQNGhyvJiEPIQov9BecsqfisnraZvkVJ56IdLPCn8=";
        };
        aarch64-linux = {
          target = "aarch64-unknown-linux-musl";
          hash = "sha256-uTB7xlrixLIXgXWHYDSzrQSn/e1a6omBgUGnsF5sQ6o=";
        };
        x86_64-linux = {
          target = "x86_64-unknown-linux-musl";
          hash = "sha256-XVul9necOYtPsjsG/ILDA/zCgfVrwO2EnyNAOsqg5BM=";
        };
      };
      release = releases.${system};
    in
      prev.fetchurl {
        url = "https://github.com/jdx/fnox/releases/download/v${version}/fnox-${release.target}.tar.gz";
        hash = release.hash;
      };

    nativeBuildInputs = [
      prev.installShellFiles
      prev.makeWrapper
    ];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall

      install -Dm755 fnox $out/bin/fnox
      wrapProgram $out/bin/fnox \
        --prefix PATH : "${prev.lib.makeBinPath [prev.usage]}"

      $out/bin/fnox completion bash > fnox.bash
      $out/bin/fnox completion fish > fnox.fish
      $out/bin/fnox completion zsh > _fnox

      substituteInPlace fnox.bash fnox.fish _fnox \
        --replace-fail '-p usage' '-p ${prev.lib.getExe prev.usage}' \
        --replace-fail 'usage complete-word' '${prev.lib.getExe prev.usage} complete-word'

      installShellCompletion --cmd fnox \
        --bash fnox.bash \
        --fish fnox.fish \
        --zsh _fnox

      runHook postInstall
    '';

    meta = {
      description = "encrypted/remote secret manager";
      homepage = "https://github.com/jdx/fnox";
      license = prev.lib.licenses.mit;
      mainProgram = "fnox";
    };
  };
}
