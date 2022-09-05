local skynet = require "skynet"
local CMD = {
    start = function (source)
        print(source)
    end
}
skynet.start(function()
    skynet.dispatch("lua", function(session, source, cmd, ...)
        local f = assert(CMD[cmd])
        f(source, ...)
    end)
end)
