local theme = require('theme')

hl.config({
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
      active_border = 'rgb(' .. theme.blue .. ')',
      inactive_border = 'rgb(' .. theme.base04 .. ')',
    },
    no_focus_fallback = true,
    allow_tearing = true,
  },
  dwindle = {
    force_split = 2, -- Split to the bottom right
    preserve_split = true,
    default_split_ratio = 1.04,
  },
  decoration = {
    rounding = 0,
    shadow = { enabled = false },
    blur = { enabled = false },
  },
  animations = { enabled = false },
  xwayland = {
    enabled = true,
    force_zero_scaling = true,
  },
  input = {
    kb_layout = 'us',
    kb_variant = 'altgr-intl',
    kb_options = 'altwin:swap_lalt_lwin',
    follow_mouse = 2,
    float_switch_override_focus = 0,
    touchpad = { natural_scroll = true },
    repeat_rate = 50,
    repeat_delay = 300,
  },
  cursor = {
    no_hardware_cursors = 1, -- Nvidia thing
    no_warps = true,
  },
  gestures = {
    workspace_swipe_forever = true,
    workspace_swipe_min_speed_to_force = 7,
  },
  misc = {
    disable_hyprland_logo = true,
    middle_click_paste = false,
    mouse_move_focuses_monitor = false,
    focus_on_activate = true,
    vrr = 1,
  },
  binds = { allow_workspace_cycles = true },
})

hl.device({ name = 'wacom-one-by-wacom-s-pen', output = 'eDP-1' })

for workspace = 1, 10 do
  hl.workspace_rule({
    workspace = tostring(workspace),
    monitor = workspace <= 5 and 'eDP-1' or 'HDMI-A-1',
    persistent = true,
    default = workspace == 1 or workspace == 6,
  })
end
