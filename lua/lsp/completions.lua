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

    vim.api.nvim_create_autocmd('CompleteChanged', {
        callback = vim.schedule_wrap(function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local suffix = line:sub(col + 1):match('^[%w_]+') or ''

            local new_suffix = ''

            if vim.fn.complete_info()['selected'] == -1 then
                if orig_suffix ~= nil then
                    new_suffix = orig_suffix
                else
                    orig_suffix = suffix
                    return
                end
            end

            vim.api.nvim_buf_set_text(
                0,
                vim.api.nvim_win_get_cursor(0)[1] - 1, col,
                vim.api.nvim_win_get_cursor(0)[1] - 1, col + #suffix,
                { new_suffix }
            )
        end)
    })

    vim.api.nvim_create_autocmd('CompleteDone', {
        callback = function ()
            orig_suffix = nil
        end
    })
end

setup_triggers()
setup_suffix_fixup()
