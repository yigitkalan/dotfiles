local dap = require("dap")
local dapui = require('dapui')
dapui.setup()



-- .NET specific setup using `easy-dotnet`
require("easy-dotnet.netcoredbg").register_dap_variables_viewer() -- Special variables viewer for .NET
local dotnet = require("easy-dotnet")
local debug_dll = nil

local function ensure_dll()
    if debug_dll ~= nil then
        return debug_dll
    end
    local dll = dotnet.get_debug_dll(true)
    debug_dll = dll
    return dll
end

local function rebuild_project(co, path)
    local spinner = require("easy-dotnet.ui-modules.spinner").new()
    spinner:start_spinner("Building")
    vim.fn.jobstart(string.format("dotnet build %s", path), {
        on_exit = function(_, return_code)
            if return_code == 0 then
                spinner:stop_spinner("Built successfully")
            else
                spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
                error("Build failed")
            end
            coroutine.resume(co)
        end,
    })
    coroutine.yield()
end


vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Configure DAP for C# and F#
        for _, value in ipairs({ "cs", "fsharp" }) do
            dap.configurations[value] = {
                {
                    type = "coreclr",
                    name = "Program",
                    request = "launch",
                    env = function()
                        local dll = ensure_dll()
                        local vars = dotnet.get_environment_variables(dll.project_name, dll.relative_project_path, false)
                        return vars or nil
                    end,
                    program = function()
                        local dll = ensure_dll()
                        local co = coroutine.running()
                        rebuild_project(co, dll.project_path)
                        return dll.relative_dll_path
                    end,
                    cwd = function()
                        local dll = ensure_dll()
                        return dll.relative_project_path
                    end,
                    justMyCode = false,
                    stopAtEntry = false
                },
                {
                    type = "coreclr",
                    name = "Test",
                    request = "attach",
                    processId = function()
                        local res = require("easy-dotnet").experimental.start_debugging_test_project()
                        return res.process_id
                    end
                }
            }
        end
    end,
})


-- Set up mason-nvim-dap to handle netcoredbg
require("mason-nvim-dap").setup({
    ensure_installed = { "netcoredbg" },
    automatic_installation = true,
    handlers = {},
})


-- Optional: Set up DAP UI
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    -- Reset debug_dll after each terminated session
    debug_dll = nil
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- Define the coreclr adapter
dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    options = {
        detached = false,
    },
    args = { "--interpreter=vscode" },
}
