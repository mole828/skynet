local skynet = require "skynet"
local socket = require "skynet.socket"

package.path = "lualib/?.lua;myProject/?.lua"

local cluster = require "skynet.cluster"
require 'skynet.manager'

skynet.start(function()
    print('begin skynet.start')

    local ping1 = skynet.newservice('ping')
    local ping2 = skynet.newservice('ping')
    skynet.send(ping1, 'lua', 'start', ping2)

    print('end skynet.start')
end)

local clients = {}

function connect(fd, addr)
    print(fd.." connected addr:"..addr)
    socket.start(fd, function (...)
        -- nothing
    end)
    clients[fd]={}
    while true do
        local readdata = socket.read(fd)
        if readdata~=nil then
            print(fd.." recv "..readdata)
            for key, value in pairs(clients) do
                local msg = fd.." say:"..readdata
                socket.write(key, msg, string.len(msg))
            end
        else
            print(fd.." close ")
            socket.close(fd);
            clients[fd] = nil
        end
    end
end
