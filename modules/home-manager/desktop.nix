{ pkgs, ... }:
{
  xdg.desktopEntries = {
    YouTube = {
      name = "YouTube";
      genericName = "YouTube";
      exec = "${pkgs.brave}/bin/brave --app=https://yt.be";
      icon = "youtube";
      type = "Application";
      terminal = false;
      comment = "Youtube Web App";
      categories = [
        "AudioVideo"
        "Video"
        "Network"
        "WebBrowser"
      ];
    };
    FaceBook = {
      name = "FaceBook";
      genericName = "FaceBook";
      exec = "${pkgs.brave}/bin/brave --app=https://fb.me";
      icon = "facebook";
      type = "Application";
      terminal = false;
      comment = "FaceBook Web App";
      categories = [
        "Network"
        "WebBrowser"
        "SocialNetworking"
      ];
    };
    GitHub = {
      name = "GitHub";
      genericName = "GitHub";
      exec = "${pkgs.brave}/bin/brave --app=https://github.com";
      icon = "github";
      type = "Application";
      terminal = false;
      comment = "GitHub Web App";
      categories = [
        "Network"
        "Development"
        "WebBrowser"
      ];
    };
    ChatGPT = {
      name = "ChatGPT";
      genericName = "ChatGPT";
      exec = "${pkgs.brave}/bin/brave --app=https://chat.openai.com";
      icon = "./chatgpt.svg";
      type = "Application";
      terminal = false;
      categories = [
        "Utility"
        "ArtificialIntelligence"
        "Network"
      ];
    };
  };
}
