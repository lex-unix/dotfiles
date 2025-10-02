{ pkgs, config, ... }:
{
  enable = true;
  env.GOPATH = "${config.home.homeDirectory}/go";
}
