require("core")
require("mappings")

require("utils").init_lazy()
require("lazy").setup("plugins", {
    change_detection = {
        enabled = false,
        notify = false,
    }
})

require("lsp")

require('langmapper').automapping({ global = true, buffer = true })
require("theme")
