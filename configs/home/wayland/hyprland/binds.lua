local cmd = require('commands')
local dsp = hl.dsp

local function exec(key, command, flags, rules)
  hl.bind(key, dsp.exec_cmd(command, rules), flags)
end

-- Hyprland control
hl.bind('SUPER + ALT + Q', dsp.exit())
hl.bind('SUPER + ALT + R', dsp.reload_config())

-- Programs
exec('SUPER + Return', cmd.terminal)
exec(
  'SUPER + SHIFT + Return',
  cmd.terminal,
  nil,
  { float = true, size = { 960, 540 } }
)
exec('SUPER + E', cmd.fileManager)
exec(
  'SUPER + SHIFT + E',
  cmd.terminal .. ' ' .. cmd.fileManagerCli,
  nil,
  { float = true, size = { 960, 540 } }
)
exec('SUPER + B', cmd.browser)

-- Menus
exec('SUPER + Space', cmd.appLauncher)
exec(
  'SUPER + V',
  cmd.cliphist
  .. ' list | '
  .. cmd.dmenu
  .. ' | '
  .. cmd.cliphist
  .. ' decode | '
  .. cmd.wlCopy
)
exec(
  'SUPER + Period',
  "BEMOJI_PICKER_CMD='fuzzel --dmenu' " .. cmd.bemoji .. ' -t'
)
exec('SUPER + SHIFT + X', cmd.powerMenu)

-- Screen capture
exec(
  'Print',
  'pidof -q slurp || '
  .. cmd.slurp
  .. ' -w 0 -b 00000088 | '
  .. cmd.grim
  .. ' -g - - | '
  .. cmd.wlCopy
)
exec(
  'SHIFT + Print',
  'pidof -q slurp || '
  .. cmd.slurp
  .. ' -ro -w 0 -b 00000088 -B 00000088 | '
  .. cmd.grim
  .. ' -g - - | '
  .. cmd.wlCopy
)

-- Window controls
hl.bind('SUPER + Q', dsp.window.close())
hl.bind('SUPER + F', dsp.window.fullscreen())
hl.bind('SUPER + M', dsp.window.fullscreen({ mode = 'maximized' }))
hl.bind('SUPER + T', dsp.window.float())

-- Raise the newly focused window after changing focus.
local function focus_and_raise(key, action)
  hl.bind(key, function()
    hl.dispatch(action)
    hl.dispatch(dsp.window.alter_zorder({ mode = 'top' }))
  end)
end

for _, item in ipairs({
  { 'H', 'l', -20, 0 },
  { 'J', 'd', 0, 20 },
  { 'K', 'u', 0, -20 },
  { 'L', 'r', 20, 0 },
}) do
  local key, direction, x, y = table.unpack(item)
  focus_and_raise('SUPER + ' .. key, dsp.focus({ direction = direction }))
  hl.bind('SUPER + SHIFT + ' .. key, dsp.window.swap({ direction = direction }))
  hl.bind(
    'SUPER + ALT + ' .. key,
    dsp.window.resize({ x = x, y = y, relative = true }),
    { repeating = true }
  )
end

focus_and_raise('SUPER + Grave', dsp.focus({ last = true }))
focus_and_raise('SUPER + C', dsp.window.cycle_next())
focus_and_raise('SUPER + SHIFT + C', dsp.window.cycle_next({ next = false }))

-- Switch workspaces and move windows without following them.
for workspace = 1, 10 do
  local key = tostring(workspace % 10)
  hl.bind('SUPER + ' .. key, dsp.focus({ workspace = tostring(workspace) }))
  hl.bind(
    'SUPER + SHIFT + ' .. key,
    dsp.window.move({ workspace = tostring(workspace), follow = false })
  )
end

hl.bind('SUPER + A', dsp.focus({ workspace = 'r-1' }))
hl.bind('SUPER + S', dsp.focus({ workspace = 'r+1' }))
hl.bind('SUPER + CTRL + A', dsp.focus({ monitor = 'l' }))
hl.bind('SUPER + CTRL + S', dsp.focus({ monitor = 'r' }))
hl.bind('SUPER + Tab', dsp.focus({ workspace = 'previous_per_monitor' }))
hl.bind(
  'SUPER + SHIFT + A',
  dsp.window.move({ workspace = 'r-1', follow = false })
)
hl.bind(
  'SUPER + SHIFT + S',
  dsp.window.move({ workspace = 'r+1', follow = false })
)

-- Special workspace (scratchpad)
hl.bind('SUPER + W', dsp.workspace.toggle_special())
hl.bind(
  'SUPER + SHIFT + W',
  dsp.window.move({ workspace = 'special', follow = false })
)

-- Mouse controls
hl.bind('SUPER + mouse_up', dsp.focus({ workspace = 'r+1' }))
hl.bind('SUPER + mouse_down', dsp.focus({ workspace = 'r-1' }))
hl.bind('SUPER + mouse:272', dsp.window.drag(), { mouse = true })
hl.bind('SUPER + mouse:273', dsp.window.resize(), { mouse = true })

-- Audio control (also available while locked)
exec(
  'XF86AudioRaiseVolume',
  cmd.pamixer .. ' -i 5 && ' .. cmd.volumeUpdate,
  { repeating = true, locked = true }
)
exec(
  'XF86AudioLowerVolume',
  cmd.pamixer .. ' -d 5 && ' .. cmd.volumeUpdate,
  { repeating = true, locked = true }
)
exec(
  'XF86AudioMute',
  cmd.pamixer .. ' -t && ' .. cmd.volumeUpdate,
  { locked = true }
)
exec('XF86AudioPlay', cmd.playerctl .. ' play-pause', { locked = true })
exec('XF86AudioPrev', cmd.playerctl .. ' previous', { locked = true })
exec('XF86AudioNext', cmd.playerctl .. ' next', { locked = true })

-- Brightness control
exec('XF86MonBrightnessUp', cmd.brightnessctl .. ' set 10%+', { locked = true })
exec(
  'XF86MonBrightnessDown',
  cmd.brightnessctl .. ' set 10%-',
  { locked = true }
)
