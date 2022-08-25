package.cpath = "luaclib/?.so"
package.path = "lualib/?.lua;myProject/?.lua"

local socket = require "client.socket"
local proto = require "proto"
local sproto = require "sproto"

-- local host = sproto.new(proto.msg):host "package"
-- local request = host:attach(sproto.new(proto.c2s))

local fd = assert(socket.connect("127.0.0.1", 8888))


while true do
    local cmd = socket.readstdin()
    if cmd then
        local package = string.pack(">s2", cmd)
        socket.send(fd, package)
    end
end