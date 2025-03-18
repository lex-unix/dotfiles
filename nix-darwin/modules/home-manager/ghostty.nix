{ pkgs, userConfig }:
{
  enable = true;
  settings = {
    font-family = "SauceCodePro Nerd Font Mono";
    font-size = 14;
    adjust-cell-height = "30%";

    theme = userConfig.theme;
    cursor-style = "block";
    cursor-style-blink = false;
    window-padding-x = 12;
    window-padding-y = 8;
    confirm-close-surface = false;
    mouse-hide-while-typing = true;
    link-url = true;

    macos-titlebar-style = "hidden";
    macos-option-as-alt = "left";
    macos-icon = "custom-style";
    macos-icon-frame = "plastic";
    macos-icon-ghost-color = "white";
    macos-icon-screen-color = "sky blue";
  };
}
