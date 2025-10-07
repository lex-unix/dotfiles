{ pkgs, ... }:
{
  enable = true;
  enableFishIntegration = true;
  enableZshIntegration = true;
  shellWrapperName = "y";
  keymap = {
    mgr.prepend_keymap = [
      {
        on = [ "-" ];
        run = "leave";
        desc = "Up directory (Oil-like)";
      }
      {
        on = [ "<Enter>" ];
        run = "enter";
        desc = "Enter directory (Oil-like)";
      }
      {
        on = [ "l" ];
        run = "link";
        desc = "Symlink yanked files (absolute)";
      }
      {
        on = [ "L" ];
        run = "link --relative";
        desc = "Symlink yanked files (relative)";
      }
      {
        on = [ "<Tab>" ];
        run = [
          "toggle"
          "arrow next"
        ];
        desc = "Toggle selection";
      }
      {
        on = [ "<BackTab>" ];
        run = [
          "toggle"
          "arrow prev"
        ];
        desc = "Toggle selection and move up";
      }
      {
        on = [ "i" ];
        run = "spot";
        desc = "Spot hovered file";
      }
    ];

    spot.prepend_keymap = [
      {
        on = [ "i" ];
        run = "close";
        desc = "Close the spot";
      }
    ];
  };
}
