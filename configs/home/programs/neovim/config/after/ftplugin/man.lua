vim.opt_local.spell = false

-- Nicer scrolling
vim.keymap.set('n', 'K', 'k<c-y>', { buffer = true, silent = true })
vim.keymap.set('n', 'J', 'j<c-e>', { buffer = true, silent = true })
