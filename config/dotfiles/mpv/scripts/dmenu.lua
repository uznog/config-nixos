local opt = require 'mp.options'

local user_opts = {
    cmd = 'dmenu -b < /dev/null'
}

read_options(user_opts, "prompt")

function prompt_exec()
    mp.resume_all()

    local f = io.popen(user_opts.cmd)
    local s = f:read('*a'):gsub("^%s*(.-)%s*$", "%1")
    f:close()

    if (s ~= '') then
        mp.command(s)
    end
end

mp.add_key_binding("ctrl+d", "prompt", prompt_exec)