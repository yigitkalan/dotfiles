local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.register_source("easy-dotnet", require("easy-dotnet").package_completion_source)
-- Configure nvim-cmp
local cmp_config = lsp_zero.defaults.cmp_config({

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'easy-dotnet' },
    }),

    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- ['<Tab>'] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     else
        --         fallback()
        --     end
        -- end, { 'i', 's' }),
        -- ['<S-Tab>'] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     else
        --         fallback()
        --     end
        -- end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(entry, vim_item)
                return vim_item
            end
        })
    },
    preselect = cmp.PreselectMode.Item,
    completion = {
        completeopt = 'menu,menuone,noinsert',
        delay = 0,    -- No delay
        throttle = 0, -- No throttling
        get_trigger_characters = function(trigger_characters)
            return trigger_characters
        end,
    },
    performance = {
        debounce = 0,                 -- No debouncing
        throttle = 0,                 -- No throttling
        fetching_timeout = 200,       -- Faster timeout
        confirm_resolve_timeout = 80, -- Faster resolve
        async_budget = 1,             -- Process more items per cycle
        max_view_entries = 10,
    },
    window = {
        completion = cmp.config.window.bordered({
            maxheight = 10,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            border = 'rounded',
        }),
        documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            border = 'rounded',
        }),
    },
})

cmp.setup(cmp_config)
