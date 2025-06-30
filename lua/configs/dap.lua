local dap = require("dap")

-- Python adapter setup
dap.adapters.python = {
  type = "executable",
  command = "/usr/bin/python",  -- Ensure this is the correct Python path on your system
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",  -- Runs the current file
    pythonPath = function()
      return "/usr/bin/python"  -- Ensure this is the correct Python path
    end,
  },
}

