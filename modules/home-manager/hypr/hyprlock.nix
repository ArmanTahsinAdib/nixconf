{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];
      label = [
        {
          monitor = "";
          color = "rgba(216, 222, 233, .7)";
          font_size = 160;
          font_family = "steelfish outline regular";
          position = "0, 370";
          brightness = 0.8172;
          halign = "center";
          valign = "center";
        }
      ];

    };
  };
}
