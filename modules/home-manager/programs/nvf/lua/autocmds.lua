local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

-- Restore cursor position on buffer enter
create_autocmd("BufReadPost", {
    command = 'silent! normal g`"zv',
})

-- Highlight yanked text
create_augroup("YankHighlight", { clear = true })
create_autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "Search", timeout = 500 })
    end,
})

-- Open help windows in vertical split
create_autocmd("FileType", {
    pattern = "help",
    command = "wincmd L",
})

-- Show diagnostic window when cursor is over warning/error
create_augroup("FloatDiagnosticCursor", { clear = true })
create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = "FloatDiagnosticCursor",
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
    end,
})

-- Enable spellcheck for LaTeX files
create_autocmd("FileType", {
    pattern = { "tex", "plaintex" },
    callback = function()
        vim.opt_local.spell = true
    end,
})
