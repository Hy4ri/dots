-- : Environment Variable

-- : Apps {{{
hl.env("TERMINAL", "foot")
--- : }}}

-- : Toolkit Backend Variables {{{
hl.env("GDK_BACKEND", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
-- : }}}

-- : XDG Specifications {{{
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
-- : }}}

-- : Qt Variables {{{
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "gtk3")
-- : }}}

-- : GTK Theme {{{
hl.env("GDK_SCALE", "1")
-- : }}}

-- : Cursor Theme {{{
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")
-- : }}}

-- : Firefox Specifies {{{
hl.env("MOZ_DBUS_REMOTE", "1")
-- : }}}

-- : Electron {{{
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("OZONE_PLATFORM", "wayland")
-- : }}}

-- : NVIDIA Specific {{{
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("NVD_BACKEND", "direct")
hl.env("GSK_RENDERER", "ngl")
-- : }}}

--  vim:fileencoding=utf-8:foldmethod=marker:fdl=0
