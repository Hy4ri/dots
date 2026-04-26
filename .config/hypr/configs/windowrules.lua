-- WindowRules {{{

-- Float {{{
hl.window_rule({
  name = "thunar-progress-float",
  match = {
    class = "([Tt]hunar)",
    title = "(File Operation Progress)$"
  },
  float = true
})
hl.window_rule({
  name = "thunar-replace-float",
  match = {
    class = "([Tt]hunar)",
    title = "(Confirm to replace files)$"
  },
  float = true
})
hl.window_rule({
  name = "portal-gtk-float",
  match = { class = "(xdg-desktop-portal-gtk)$" },
  float = true
})
hl.window_rule({
  name = "nemo-properties-float",
  match = {
    class = "(nemo)",
    title = "(.*)(Properties)$"
  },
  float = true
})
hl.window_rule({
  name = "audiocontrol-float",
  match = { class = "(pavucontrol|org.pulseaudio.pavucontrol|hyprpwcenter)$" },
  float = true
})
hl.window_rule({
  name = "wallpaper-tools-float",
  match = { class = "(waller)$" },
  float = true
})
hl.window_rule({
  name = "calculator-float",
  match = { class = "(galculator|qalculate-gtk)$" },
  float = true
})
hl.window_rule({
  name = "network-tools-float",
  match = { class = "(nm-connection-editor|.blueman-(.*))$" },
  float = true
})
hl.window_rule({
  name = "qt-look-float",
  match = { class = "(nwg-look|qt5ct|qt6ct)$" },
  float = true
})
hl.window_rule({
  name = "yad-float",
  match = { class = "(yad)$" },
  float = true
})
hl.window_rule({
  name = "file-roller-float",
  match = { class = "(file-roller|org.gnome.FileRoller)$" },
  float = true
})
hl.window_rule({
  name = "pip-window-float",
  match = { title = "(Picture-in-Picture)$" },
  float = true
})
hl.window_rule({
  name = "open-file-float",
  match = { title = "(Open File)(.*)$" }
})
hl.window_rule({
  name = "select-file-float",
  match = { title = "(Select a File)(.*)$" },
  float = true
})
hl.window_rule({
  name = "save-as-float",
  match = { title = "(Save As)(.*)$" },
  float = true
})
hl.window_rule({
  name = "save-file-float",
  match = { title = "(Save File)(.*)$" },
  float = true
})
hl.window_rule({
  name = "library-window-float",
  match = { title = "(Library)(.*)$" },
  float = true
})
hl.window_rule({
  name = "rename-window-float",
  match = { title = "(Rename)(.*)$" },
  float = true
})
hl.window_rule({
  name = "file-upload-float",
  match = { title = "(File Upload)(.*)$" },
  float = true
})
hl.window_rule({
  name = "nmtui-float",
  match = { title = "(nmtui)$" },
  float = true
})

--: }}}

-- Tile {{{
hl.window_rule({
  name = "onlyoffice-tile",
  match = { class = "(ONLYOFFICE Desktop Editors)$" },
  tile = true
})
hl.window_rule({
  name = "mpv-tile",
  match = { class = "(mpv)$" },
  tile = true
})
hl.window_rule({
  name = "warp-terminal-tile",
  match = { class = "(dev.warp.Warp)$" },
  tile = true
})
hl.window_rule({
  name = "chromium-tile",
  match = { class = "(Chromium)$" },
  tile = true
})
hl.window_rule({
  name = "affinity-tile",
  match = { class = "(affinity.exe)$" },
  tile = true
})

--: }}}

-- Fullscreen {{{
hl.window_rule({
  name = "waydroid-fullscreen",
  match = { class = "(Waydroid)$" },
  fullscreen = true
})
hl.window_rule({
  name = "cs2-fullscreen",
  match = { class = "(cs2)$" },
  fullscreen = true,
  no_blur = true
})
hl.window_rule({
  name = "steam-app-fullscreen",
  match = { class = "(steam_app_(.*))$" },
  fullscreen = true
})
hl.window_rule({
  name = "genshinimpact-fullscreen",
  match = { class = "(genshinimpact.exe)$" },
  fullscreen = true
})

--: }}}

-- Center {{{
hl.window_rule({
  name = "audiocontrol-center",
  match = { class = "(pavucontrol|org.pulseaudio.pavucontrol|hyprpwcenter)$" },
  center = true
})
hl.window_rule({
  name = "thunar-progress-center",
  match = {
    class = "([Tt]hunar)",
    title = "(File Operation Progress)$"
  },
  center = true
})
hl.window_rule({
  name = "thunar-replace-center",
  match = {
    class = "([Tt]hunar)",
    title = "(Confirm to replace files)$"
  },
  center = true
})
hl.window_rule({
  name = "portal-gtk-center",
  match = { class = "(xdg-desktop-portal-gtk)$" },
  center = true
})
hl.window_rule({
  name = "nemo-properties-center",
  match = {
    class = "(nemo)",
    title = "(.*)(Properties)$"
  },
  center = true
})
hl.window_rule({
  name = "wallpaper-tools-center",
  match = { class = "(waller)$" },
  center = true
})
hl.window_rule({
  name = "calculator-center",
  match = { class = "(galculator|qalculate-gtk)$" },
  center = true
})
hl.window_rule({
  name = "network-tools-center",
  match = { class = "(nm-connection-editor|.blueman-(.*))$" },
  center = true
})
hl.window_rule({
  name = "qt-look-center",
  match = { class = "(nwg-look|qt5ct|qt6ct)$" },
  center = true
})
hl.window_rule({
  name = "yad-center",
  match = { class = "(yad)$" },
  center = true
})
hl.window_rule({
  name = "file-roller-center",
  match = { class = "(file-roller|org.gnome.FileRoller)$" },
  center = true
})
hl.window_rule({
  name = "smile-app-center",
  match = { class = "(it.mijorus.smile)$" },
  center = true
})
hl.window_rule({
  name = "pip-window-center",
  match = { title = "(Picture-in-Picture)$" },
  center = true
})
hl.window_rule({
  name = "open-file-center",
  match = { title = "(Open File)(.*)$" },
  center = true
})
hl.window_rule({
  name = "select-file-center",
  match = { title = "(Select a File)(.*)$" },
  center = true
})
hl.window_rule({
  name = "save-as-center",
  match = { title = "(Save As)(.*)$" },
  center = true
})
hl.window_rule({
  name = "save-file-center",
  match = { title = "(Save File)(.*)$" },
  center = true
})
hl.window_rule({
  name = "library-window-center",
  match = { title = "(Library)(.*)$" },
  center = true
})
hl.window_rule({
  name = "rename-window-center",
  match = { title = "(Rename)(.*)$" },
  center = true
})
hl.window_rule({
  name = "file-upload-center",
  match = { title = "(File Upload)(.*)$" },
  center = true
})
hl.window_rule({
  name = "nmtui-center",
  match = { title = "(nmtui)$" },
  center = true
})
hl.window_rule({
  name = "blueman-manager-center",
  match = { class = "(blueman-manager)$" },
  center = true
})

--: }}}

-- IdleInhibit {{{

-- idle_inhibit : none, always, focuse, fullscreen
hl.window_rule({
  name = "fullscreen-idleinhibit",
  match = { fullscreen = true },
  idle_inhibit = "fullscreen",
  no_blur = true
})

hl.window_rule({
  name = "Youtube-idleinhibit",
  match = { title = "(.*YouTube.*)" },
  idle_inhibit = "always"
})

--: }}}

-- Monitor {{{
hl.window_rule({
  name = "chat-apps-hdmi3",
  match = { class = "^(vesktop|equibop)$" },
  monitor = "HDMI-A-3"
})
hl.window_rule({
  name = "spotify-hdmi3",
  match = { class = "^([Ss]potify)$" },
  monitor = "HDMI-A-3"
})
hl.window_rule({
  name = "steam-edp1",
  match = { class = "^([Ss]team)$" },
  monitor = "eDP-1"
})

--: }}}

-- Workspaces {{{
hl.window_rule({
  name = "browsers-ws1",
  match = { class = "([Vv]ivaldi-(.*)|zen-alpha|LibreWolf|firefox|Brave-browser)$" },
  workspace = "1 silent"
})
hl.window_rule({
  name = "editors-ws2",
  match = { class = "(dev.zed.Zed|Code|VSCodium|antigravity)$" },
  workspace = "2 silent"
})
hl.window_rule({
  name = "filemanagers-ws3",
  match = { class = "([Tt]hunar|nemo)$" },
  workspace = "3 silent"
})
hl.window_rule({
  name = "chatapps-ws4",
  match = { class = "(vesktop|discord|equibop)$" },
  workspace = "4 silent"
})
hl.window_rule({
  name = "gaming-ws5",
  match = { class = "(steam|steam_app_(.*)|heroic|cs2|net.lutris.Lutris|moe.launcher.an-anime-game-launcher|genshinimpact.exe|ModrinthApp|Minecraft(.*))$" },
  workspace = "5 silent"
})
hl.window_rule({
  name = "gimp-ws6",
  match = { class = "(gimp|affinity.exr)$" },
  workspace = "6 silent"
})
hl.window_rule({
  name = "reading-ws7",
  match = { class = "(org.pwmt.zathura|obsidian)$" },
  workspace = "7 silent"
})
hl.window_rule({
  name = "music-ws8",
  match = { class = "([Ss]potify|spotube|kew)$" },
  workspace = "8 silent"
})
hl.window_rule({
  name = "virtualization-ws9",
  match = { class = "((.*)virt-manager(.*)|virt-viewer|Waydroid|VirtualBox(.*))$" },
  workspace = "9 silent"
})
hl.window_rule({
  name = "todo-ws10",
  match = { class = "(todoist-tui)$" },
  workspace = "10 silent"
})

--: }}}

-- Pin {{{
hl.window_rule({
  name = "audiocontrol-pin",
  match = { class = "(org.pulseaudio.pavucontrol|hyprpwcenter)$" },
  pin = true
})
hl.window_rule({
  name = "blueman-pin",
  match = { class = "(blueman-manager)$" },
  pin = true
})
hl.window_rule({
  name = "pip-pin",
  match = { title = "(Picture-in-Picture)$" },
  pin = true
})
hl.window_rule({
  name = "color-picker-pin",
  match = { title = "(Choose a color)$" },
  pin = true
})

--: }}}

-- Opacity {{{
-- hl.window_rule({
--   name = "browser-opacity",
--   match = { class = "([Vv]ivaldi-(.*)|zen-alpha|LibreWolf|firefox|Brave-browser)$" },
--   opacity = "0.9 0.9"
-- })
--
-- hl.window_rule({
--   name = "youtube-opacity",
--   match = { title = "(.*YouTube.*)$" },
--   opacity = "1.0 1.0"
-- })
--
-- hl.window_rule({
--   name = "filemanager-opacity",
--   match = { class = "([Tt]hunar|nemo)$" },
--   opacity = "0.9 0.9"
-- })
-- hl.window_rule({
--   name = "reading-opacity",
--   match = { class = "(obsidian|org.pwmt.zathura)$" },
--   opacity = "0.9 0.9"
-- })
-- hl.window_rule({
--   name = "codeeditor-opacity",
--   match = { class = "(Code|VSCodium|Cursor|[Aa]ntigravity|dev.zed.Zed)$" },
--   opacity = "0.9 0.9"
-- })
-- hl.window_rule({
--   name = "obsstudio-opacity",
--   match = { class = "(com.obsproject.Studio)$" },
--   opacity = "0.9 0.9"
-- })
-- hl.window_rule({
--   name = "chatapps-opacity",
--   match = { class = "(discord|vesktop|equibop)$" },
--   opacity = "0.9 0.9"
-- })
-- hl.window_rule({
--   name = "spotify-opacity",
--   match = { class = "([Ss]potify)$" },
--   opacity = "0.8 0.8"
-- })
-- hl.window_rule({
--   name = "pip-opacity",
--   match = { title = "(Picture-in-Picture)$" },
--   opacity = "0.9 0.9"
-- })

--: }}}

-- Border {{{
hl.window_rule({
  name = "pinned",
  match = { pin = true },
  border_color = "rgb(990000)",
  border_size = 3
})
hl.window_rule({
  name = "smart-borders",
  match = {
    float = false,
    workspace = "w[tv1]"
  },
  border_size = 0
})
hl.window_rule({
  name = "smart-borders-2",
  match = {
    float = false,
    workspace = "f[1]"
  },
  border_size = 0
})

--: }}}

-- Size {{{
local centerWindow = "(monitor_w*0.7) (monitor_h*0.8)"
hl.window_rule({
  name = "pip-size",
  match = { title = "(Picture-in-Picture)$" },
  size = "25% 25%"
})
hl.window_rule({
  name = "audiocontrol-size",
  match = { class = "(pavucontrol|org.pulseaudio.pavucontrol|hyprpwcenter)$" },
  size = centerWindow
})
hl.window_rule({
  name = "waydroid-size",
  match = { class = "(waydroid(.*))$" },
  size = "576 1024"
})
hl.window_rule({
  name = "xdg-portal-size",
  match = { class = "(xdg-desktop-portal-gtk)$" },
  size = centerWindow
})
hl.window_rule({
  name = "nwg-look-size",
  match = { class = "(nwg-look)$" },
  size = centerWindow
})
hl.window_rule({
  name = "wallpaper-tools-size",
  match = { class = "(waller)$" },
  size = centerWindow
})
hl.window_rule({
  name = "blueman-manager-size",
  match = { class = "(blueman-manager)$" },
  size = centerWindow
})

--: }}}

-- Move {{{
hl.window_rule({
  name = "pip-move",
  match = { title = "(Picture-in-Picture)$" },
  move = "72% 7%"
})

--: }}}

-- KeepAspectRatio {{{
hl.window_rule({
  name = "pip-aspect",
  match = { title = "(Picture-in-Picture)$" },
  keep_aspect_ratio = true
})

--: }}}

--: }}}

-- LayerRules {{{

-- Blur {{{
hl.layer_rule({
  name = "layer-blur-w",
  match = { namespace = "waybar" },
  blur = true
})
hl.layer_rule({
  name = "layer-blur-v",
  match = { namespace = "vicinae" },
  blur = true
})

--: }}}

-- IgnoreAlpha {{{
hl.layer_rule({
  name = "layer-ignorealpha-w",
  match = { namespace = "waybar" },
  ignore_alpha = 0
})
hl.layer_rule({
  name = "layer-ignorealpha-v",
  match = { namespace = "vicinae" },
  ignore_alpha = 0
})

--: }}}

-- Dimaround {{{
hl.layer_rule({
  name = "layer-dimaround-r",
  match = { namespace = "rofi" },
  dim_around = true
})

--: }}}

-- NoAnim {{{
hl.layer_rule({ match = { namespace = "^(quickshell)$" }, no_anim = true })
hl.layer_rule({ match = { namespace = "^dms:.*" }, no_anim = true })
-- }}}

-- }}}

-- WorkspaceRules {{{
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", layout = "scrolling" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-3" })

-- }}}

-- vim: foldmethod=marker fdl=0
