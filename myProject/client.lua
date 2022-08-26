package.cpath = "luaclib/?.so"
package.path = "lualib/?.lua;myProject/?.lua"

local socket = require "client.socket"
local proto = require "proto"
local sproto = require "sproto"

local host = sproto.new(proto.s2c):host "package"
local request = host:attach(sproto.new(proto.c2s))

local fd = assert(socket.connect("127.0.0.1", 8888))

local function send_package(fd, pack)
	local package = string.pack(">s2", pack)
	socket.send(fd, package)
end

local session = 0
local function send_request(name, args)
	session = session + 1
	local str = request(name, args, session)
	send_package(fd, str)
	print("Request:", session)
end

send_request("handshake")

while true do
    local cmd = socket.readstdin()
    if cmd then
        local package = string.pack(">s2", cmd)
        socket.send(fd, package)
    end
end