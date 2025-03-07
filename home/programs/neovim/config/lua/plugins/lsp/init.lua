return {
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'SmiteshP/nvim-navbuddy',
    enabled = false,
    dependencies = {
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Nabuddy',
    keys = {
      { '<leader>n', '<cmd>Navbuddy<CR>', desc = 'Open Navbuddy' },
    },
    opts = {
      window = { border = 'single' },
      lsp = { auto_attach = true },
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = { 'nvim-dap-ui' },
    },
  },
  {
    'jmbuhr/otter.nvim',
    ft = { 'markdown', 'quarto' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<leader>oa', require('otter').activate, desc = 'Activate otter' },
      { '<leader>od', require('otter').deactivate, desc = 'Deactivate otter' },
    },
  },
  {
    'pmizio/typescript-tools.nvim',
    ft = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java', 'kotlin', 'groovy' },
    opts = function()
      return {
        cmd = { 'jdtls' },
        root_dir = vim.fs.dirname(
          vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]
        ),
        init_options = {
          bundles = {
            vim.fn.glob(require('nix').java_debug_path, 1),
          },
        },
      }
    end,
    config = function(_, opts)
      local jdtls = require('jdtls')

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'java', 'kotlin', 'groovy' },
        callback = function()
          jdtls.start_or_attach(opts)
        end,
      })

      vim.api.nvim_create_user_command('JdtOrganizeImports', function()
        jdtls.organize_imports()
      end, {})
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    event = 'VeryLazy',
  },
  {
    'Civitasv/cmake-tools.nvim',
    ft = { 'cpp', 'cmake' },
    dependencies = { 'nvim-lua/plenary.nvim', 'stevearc/overseer.nvim' },
    main = 'cmake-tools',
    opts = {},
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    ft = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'css',
      'scss',
      'sass',
      'svelte',
    },
    main = 'tailwind-tools',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'neovim/nvim-lspconfig',
      'ibhagwan/fzf-lua',
    },
    opts = {
      document_color = {
        enabled = true,
        kind = 'background', -- Until debounce actually works
      },
      conceal = { enabled = true },
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      menu = {
        win_configs = { border = 'single' },
        keymaps = {
          -- Move with hjkl
          ['h'] = '<C-w>q',
          ['l'] = function()
            local utils = require('dropbar.utils')
            local menu = utils.menu.get_current()
            if not menu then
              return
            end
            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
            if component then
              menu:click_on(component, nil, 1, 'l')
            end
          end,
        },
      },
      bar = {
        sources = function(buf, _)
          local utils = require('dropbar.utils')
          local sources = require('dropbar.sources')
          if vim.bo[buf].ft == 'markdown' then
            return { sources.markdown }
          end
          if vim.bo[buf].buftype == 'terminal' then
            return { sources.terminal }
          end
          return {
            utils.source.fallback({
              sources.lsp,
              sources.treesitter,
            }),
          }
        end,
      },
    },
    keys = {
      {
        '<leader>;',
        require('dropbar.api').pick,
        desc = 'Pick symbols in winbar',
      },
      {
        '[;',
        require('dropbar.api').goto_context_start,
        { desc = 'Go to start of current context' },
      },
      {
        '];',
        require('dropbar.api').goto_next_context,
        { desc = 'Select next context' },
      },
    },
  },
}
