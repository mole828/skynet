package.cpath = "luaclib/?.so"
package.path = "lualib/?.lua;myProject/?.lua"

local socket = require 'client.socket'
local sproto = require 'sproto'


local proto = require 'proto'

local msg = sproto.parse(proto.msg):host "msg"

local fd = assert(socket.connect('127.0.0.1', 8888))

