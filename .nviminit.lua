local wk = require("which-key");

wk.register({
    ["<leader>d"] =  {
        name = "RGBDS",
        r = { ":!make run<CR>", "Run Game" } }
}, {
    mode="n"
})
