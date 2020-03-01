local component = require("component")
local term = require("term")
local red = component.redstone
local reactor = component.nc_fission_reactor
local c = component.computer
local gpu = component.gpu
local active = reactor.isProcessing()
--local list = component.list()
--for address, componentType in list do
--  print("Address: ", address," | component: ", componentType)
--end

function write() 
  term.clear()
  term.setCursor(1,0)
  term.write("Nuclearcraft ".. reactor.getLengthX() .. "x" .. reactor.getLengthY() .. "x" .. reactor.getLengthZ() .. "fission reactor controler")
  term.setCursor(1,1)
  if (active == true) 
    local onoff = "Online" then
    gpu.setForeground(0x37ff00)
  end
  if (active == false)
    local onoff = "Offline" then
    gpu.setForeground(0xff0000)
  end
  term.write("Reactor: ", onoff)
  gpu.setForeground(0xffffff)
  os.sleep(1)
end

function start()
  if(active == false) 
    --reactor.activate()
    --active = true;
    --monitor()
  end
end

function monitor()
  
end

while true do 
  write()
  --c.beep()
end