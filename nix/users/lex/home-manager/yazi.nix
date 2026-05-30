{ ... }:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
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
          on = [ "_" ];
          run = "link";
          desc = "Create a symbolic link to the yanked files";
        }
        {
          on = [ "L" ];
          run = "forward";
          desc = "Go forwared to next directory";
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
  };
}
