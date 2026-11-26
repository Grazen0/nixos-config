local theme = require('theme')

-- Gives complete control over maximizing.
hl.window_rule({ match = { class = '.*' }, suppress_event = 'maximize' })
hl.window_rule({
  match = { fullscreen = true },
  border_color = 'rgb(' .. theme.yellow .. ')',
})

-- Workspace-specific programs
hl.window_rule({ match = { class = 'vesktop' }, workspace = '7' })
hl.window_rule({ match = { class = 'spotify' }, workspace = '10' })

hl.window_rule({
  match = { class = '[Tt]hunar' },
  float = true,
  size = { 960, 540 },
})
hl.window_rule({
  match = { class = 'swayimg_(.*)' },
  float = true,
  size = { 'monitor_w * 0.9', 'monitor_h * 0.9' },
  center = true,
})
hl.window_rule({
  match = { class = [[org\.pulseaudio\.pavucontrol]] },
  float = true,
  size = { 'monitor_w * 0.75', 'monitor_h * 0.75' },
})
hl.window_rule({
  match = { class = 'fceux' },
  float = true,
  size = { 639, 612 },
})

for _, class in ipairs({
  [[\.blueman-manager-wrapped]],
  [[org\.gnome\.FileRoller]],
  'nm-connection-editor',
  'nvidia-settings',
  'gemu',
  'nessie',
  'qemu',
  'gtkwave',
  'org-tinyuml-Main',
  'Matplotlib',
}) do
  hl.window_rule({ match = { class = class }, float = true })
end

for _, title in ipairs({
  '^(Choose one)$',
  '^(Steam Settings)$',
  'gemu',
  'nessie',
  'Logic Simulator',
  'annotate_toolbar',
}) do
  hl.window_rule({ match = { title = title }, float = true })
end

for _, title in ipairs({
  'Open File',
  'Select a File',
  'Choose wallpaper',
  'Open Folder',
  'Save As',
  'Library',
  'File Upload',
}) do
  hl.window_rule({ match = { title = '^(' .. title .. ')(.*)$' }, float = true })
end
