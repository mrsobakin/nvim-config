local M = {}


function M.init_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)
end


function M.get_hl_resolved(hl_name)
    local attrs = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
    while attrs.link do
        attrs = vim.api.nvim_get_hl(0, { name = attrs.link, link = false })
    end
    return attrs
end


local icon_hl_cache = {}

function M.blend_hl(base_hl, override_hl)
  local blended_name = 'Blended__' .. base_hl .. '__' .. override_hl
  local cached = icon_hl_cache[blended_name]
  if cached then return blended_name end

  local blended = vim.tbl_extend(
      "force",
      M.get_hl_resolved(base_hl),
      M.get_hl_resolved(override_hl)
  )

  vim.api.nvim_set_hl(0, blended_name, blended)
  icon_hl_cache[blended_name] = true
  return blended_name
end


return M
