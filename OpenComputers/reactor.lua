local component = require("component")
local term = require("term")
local red = component.redstone
local reactor = component.nc_fission_reactor
local c = component.computer
local gpu = component.gpu
active = reactor.isProcessing()
onoff = ""
power = ""
--local list = component.list()
--for address, componentType in list do
--  print("Address: ", address," | component: ", componentType)
--end

function write() -- information display THE END
  term.clear()
  gpu.setForeground(0xffffff)
  term.setCursor(1,0)
  term.write("Nuclearcraft ".. reactor.getLengthX() .. "x" .. reactor.getLengthY() .. "x" .. reactor.getLengthZ() .. " fission reactor controller")
  -- on/offline 
  term.setCursor(1,2)
  if (active == true) then
    onoff = "Online" 
    gpu.setForeground(0x37ff00)
  end
  if (active == false) then
    onoff = "Offline" 
    gpu.setForeground(0xff0000)
  end
  term.write("Reactor: " .. onoff)
  gpu.setForeground(0xffffff)
  -- power production
  term.setCursor(1,3)
  if (reactor.getEnergyChange() > 0) then
    gpu.setForeground(0x37ff00)
  end
  if (reactor.getEnergyChange() < 0) then
    gpu.setForeground(0xff0000)
  end
  term.write("Power in RF/t: " .. reactor.getEnergyChange())
  gpu.setForeground(0xffffff)
  -- 
  os.sleep(1)
end

function start()
  if(active == false) then
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