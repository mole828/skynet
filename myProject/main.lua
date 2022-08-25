local skynet = require "skynet"
local socket = require "skynet.socket"

local sproto = require 'sproto'
local sprotoparser = require 'sprotoparser'
local sprotoloader = require 'sprotoloader'

package.path = "lualib/?.lua;myProject/?.lua"
local proto = require 'proto'

skynet.start(function()
    local listenfd = socket.listen("0.0.0.0", 8888, 5)

    socket.start(listenfd, function(fd, addr)
        --启⽤连接
        print(fd .. " connected addr:" .. addr)
        --消息处理
        while true do
            local readdata = socket.read(fd)
            --正常接收
            if readdata ~= nil then
                print(fd .. " recv " .. readdata)
                socket.write(fd, readdata)
                --断开连接
            else
                print(fd .. " close ")
                socket.close(fd)
            end
        end
    end)
    

end)



