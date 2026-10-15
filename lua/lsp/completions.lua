-- Autocomplete
vim.opt.complete:append('o')
vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }

-- Don't autocomplete unless we actually start to type something.
local function setup_triggers()
    local function should_complete()
        if not vim.v.char:match('[%w_.:]') then
            return false
        end

        return true
    end

    vim.api.nvim_create_autocmd('InsertCharPre', {
        callback = function()
            if vim.fn.pumvisible() == 1 then return end
            vim.opt.autocomplete = should_complete()
        end
    })
end

-- By default, if you call completions mid-word, the old suffix will not be overriten.
--
--   obj.foobar()
--          ^ cursor
--   obj.foobazbar()
--
-- This is a hack to fix that.
local function setup_suffix_fixup()
    local orig_suffix = nil

    local function get_suffix()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local suffix = vim.api.nvim_get_current_line():sub(col + 1):match('^[%w_]+') or ''
        return row, col, suffix
    end

    local function set_suffix(text)
        local row, col, suffix = get_suffix()
        if suffix ~= text then
            vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col + #suffix, { text })
        end
    end

    vim.api.nvim_create_autocmd('CompleteChanged', {
        callback = vim.schedule_wrap(function()
            -- Completion may have ended before we got scheduled.
            if vim.fn.pumvisible() == 0 then return end

            if orig_suffix == nil then
                orig_suffix = select(3, get_suffix())
            end

            local selected = vim.fn.complete_info({ 'selected' }).selected ~= -1
            set_suffix(selected and '' or orig_suffix)
        end)
    })

    vim.api.nvim_create_autocmd('CompleteDone', {
        callback = function()
            local suffix = orig_suffix
            orig_suffix = nil

            -- <C-e> restores the typed text, but not the suffix we've removed.
            if suffix and vim.v.event.reason == 'cancel' then
                vim.schedule(function() set_suffix(suffix) end)
            end
        end
    })
end

setup_triggers()
setup_suffix_fixup()
