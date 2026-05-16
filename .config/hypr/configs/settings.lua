--: Layouts {{{
hl.config({
  layout = {
    single_window_aspect_ratio = "0 0",
    single_window_aspect_ratio_tolerance = 0
  },

  dwindle = {
    force_split = 2,
    preserve_split = 1,
    special_scale_factor = 1.0,
    default_split_ratio = 1.2
  },

  master = {
    new_status = "slave",
    new_on_top = 0,
    mfact = 0.6,
    special_scale_factor = 1.0
  },

  scrolling = {
    fullscreen_on_one_column = true,
    column_width = 0.99,
    focus_fit_method = 0, -- 0 = center, 1 = fit
    follow_focus = true,
    follow_min_visible = 0.005,
    direction = "right",
  },

  --: }}}

  --: General Settings {{{
  general = {
    border_size = 1,
    gaps_in = { top = 0, left = 0, right = 0, bottom = 0 },
    gaps_out = { top = 1, left = 0, right = 0, bottom = 0 },
    float_gaps = { top = 0, left = 0, right = 0, bottom = 0 },
    gaps_workspaces = 1,
    col = {
      active_border = "rgb(990000)",
      -- active_border = { colors = { "rgba(fa6982aa)", "rgba(fafa00aa)", "rgba(96f06eaa)", "rgba(6ec8faaa)", "rgba(dc6ea5aa)" } },
      inactive_border = "rgb(121212)",
    },
    layout = "scrolling", --master,scrolling,monocle,dwindle
    resize_on_border = true,
    extend_border_grab_area = 0,
    allow_tearing = false,
    locale = "en_US",
    snap = {
      enabled = true,
      window_gap = 10,
      monitor_gap = 10,
      border_overlap = false,
      respect_gaps = true
    }
  },
  --: }}}

  --: Decorations {{{
  decoration = {
    rounding = 1,
    rounding_power = 1.0,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    fullscreen_opacity = 1.0,
    dim_modal = true,
    dim_inactive = false,
    dim_strength = 0.05,
    dim_special = 0.5,
    dim_around = 0.2,
    border_part_of_window = true,

    blur = {
      enabled = false
    },
    shadow = {
      enabled = false
    },
    glow = {
      enabled = false,
    },
  },
  --: }}}

  animations = {
    enabled = false
  },

  --: Input Settings {{{
  input = {
    kb_layout = "us,ara",
    kb_options = "grp:alt_shift_toggle,caps:escape",
    numlock_by_default = true,
    repeat_rate = 35,   --30
    repeat_delay = 200, --350
    sensitivity = 1.0,
    accel_profile = "flat",
    scroll_method = "2fg", -- edge
    follow_mouse = 1,
    float_switch_override_focus = 1,

    touchpad = {
      disable_while_typing = true,
      natural_scroll = true,
      scroll_factor = 0.5,
      middle_button_emulation = true,
      clickfinger_behavior = false,
      tap_to_click = true,
      drag_lock = true,
      tap_and_drag = true,
    }
  },

  gestures = {
    workspace_swipe_distance = 300,
    workspace_swipe_touch = false,
    workspace_swipe_invert = true,
    workspace_swipe_min_speed_to_force = 30,
    workspace_swipe_cancel_ratio = 0.5,
    workspace_swipe_create_new = true,
    workspace_swipe_forever = false
  },
  --: }}}

  --: Groups {{{
  group = {
    auto_group = true,
    insert_after_current = false,
    drag_into_group = 1,
    ["col.border_active"] = "rgb(990000)",
    ["col.border_inactive"] = "rgb(000000)",
    groupbar = {
      enabled = true,
      font_family = "RecMonoSmCasualMono Nerd Font",
      font_size = 13,
      height = 12,
      indicator_gap = -15,
      indicator_height = 15,
      render_titles = true,
      text_color = "rgb(ffffff)",
      ["col.active"] = "rgb(990000)",
      ["col.inactive"] = "rgb(121212)",
      gaps_in = 0,
      gaps_out = 0,
      keep_upper_gap = 1
    }
  },
  --: }}}

  --: Misc Settings {{{
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    mouse_move_enables_dpms = true,
    font_family = "RecMonoSmCasualMono Nerd Font",
    vrr = 0,
    disable_autoreload = false,
    enable_swallow = true,
    swallow_regex = "(kitty|foot|Alacritty)$",
    swallow_exception_regex = "(wev)$",
    initial_workspace_tracking = 1
  },

  --: }}}

  binds = {
    pass_mouse_when_bound = false,
    scroll_event_delay = 300,
    workspace_back_and_forth = true,
    hide_special_on_workspace_change = true,
    allow_workspace_cycles = true,
    workspace_center_on = 1
  },

  xwayland = {
    enabled = true,
    force_zero_scaling = true
  },

  render = {
    direct_scanout = 2,
  },

  cursor = {
    sync_gsettings_theme = true,
    persistent_warps = true,
    warp_on_change_workspace = 1,
    warp_on_toggle_special = 1,
    zoom_factor = 1.0,
    enable_hyprcursor = true,
  },

  ecosystem = {
    no_update_news = true,
    no_donation_nag = true
  },

  debug = {
    overlay = false,
  },

  --: Plugins {{{
  plugin = {
  }
  --: }}}
})
-- vim:fileencoding=utf-8:foldmethod=marker:fdl=0
