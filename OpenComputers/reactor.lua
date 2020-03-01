local component = require("component")
local term = require("term")
local red = component.redstone
local reactor = component.nc_fission_reactor
local c = component.computer
--local list = component.list()
--for address, componentType in list do
--  print("Address: ", address," | component: ", componentType)
--end

function write() 
  term.clear()
  term.setCursor(0,0)
  term.write(" Nuclearcraft".. reactor.getLengthX() .. reactor.getLengthY() .. reactor.getLengthZ() .. "fission reactor controler")
  os.sleep(1)
end

while true do 
  write()
  c.beep()
end