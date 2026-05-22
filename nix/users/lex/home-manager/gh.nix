{isLinux, ...}: {
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = isLinux;
    };
  };
}
