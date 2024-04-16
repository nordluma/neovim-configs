-- This is only for testing a educational lsp
--[[
local client = vim.lsp.start_client {
    name = "educationalsp",
    cmd = { "/home/wolfhe/dev/go/educational-lsp/build/main" },
    on_attach = require("null-ls").on_attach,
}

if not client then
    vim.notify("failed to start client")
    return
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.lsp.buf_attach_client(0, client)
    end
})
--]]
