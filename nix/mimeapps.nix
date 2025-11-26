{
lib,
config,
pkgs,
...
}: {
  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        "video/mp4" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "audio/mpeg" = "mpv.desktop";
        "audio/flac" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";
        "audio/wav" = "mpv.desktop";
        "image/jpeg" = "oculante.desktop";
        "image/png" = "oculante.desktop";
        "image/gif" = "oculante.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        "text/html" = "vivaldi-stable.desktop";
        "x-scheme-handler/http" = "vivaldi-stable.desktop";
        "x-scheme-handler/https" = "vivaldi-stable.desktop";
        "x-scheme-handler/about" = "vivaldi-stable.desktop";
        "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
        "x-scheme-handler/discord" = "equibop.desktop";
      };
    };
  };
}
