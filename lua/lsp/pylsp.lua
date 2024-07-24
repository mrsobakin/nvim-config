return {
    "pylsp",
    settings = {
        ["pylsp"] = {
            plugins = {
                pylint = {
                    enabled = true,
                },
                pyflakes = {
                    enabled = false,
                },
            },
        },
    },
}
