final: prev: {
  pitchfork = prev.rustPlatform.buildRustPackage rec {
    pname = "pitchfork-cli";
    version = "2.5.0";

    src = prev.fetchCrate {
      inherit pname version;
      hash = "sha256-Qf/1hfS/a4K/12pxniPEWSy70IAxZe8iApDdjoQXF94=";
    };

    cargoHash = "sha256-lGoorhblY9mgeWMRdppUlNAFtXrTKwCHBp5/clUpuMc=";

    nativeBuildInputs = [
      prev.installShellFiles
      prev.makeWrapper
    ];

    postPatch = ''
      substituteInPlace src/cli/completion.rs \
        --replace-fail '"usage",' '"${prev.lib.getExe prev.usage}",'
    '';

    postInstall = ''
      wrapProgram $out/bin/pitchfork \
        --prefix PATH : "$out/bin"

      $out/bin/pitchfork completion bash > pitchfork.bash
      $out/bin/pitchfork completion fish > pitchfork.fish
      $out/bin/pitchfork completion zsh > _pitchfork

      substituteInPlace pitchfork.bash pitchfork.fish _pitchfork \
        --replace-fail '-p usage' '-p ${prev.lib.getExe prev.usage}' \
        --replace-fail 'usage complete-word' '${prev.lib.getExe prev.usage} complete-word'

      installShellCompletion --cmd pitchfork \
        --bash pitchfork.bash \
        --fish pitchfork.fish \
        --zsh _pitchfork
    '';

    meta = {
      description = "Daemons with DX";
      homepage = "https://github.com/endevco/pitchfork";
      license = prev.lib.licenses.mit;
      mainProgram = "pitchfork";
    };
  };
}
