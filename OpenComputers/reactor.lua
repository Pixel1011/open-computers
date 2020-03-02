local component = require("component")
local term = require("term")
local red = component.redstone
local reactor = component.nc_fission_reactor
local c = component.computer
local gpu = component.gpu
active = reactor.isProcessing()
onoff = ""
--local list = component.list()
--for address, componentType in list do
--  print("Address: ", address," | component: ", componentType)
--end

function write() -- information display
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
  term.write("Power in RF/t: " .. reactor.getEnergyChange()*-1)
  gpu.setForeground(0xffffff)
  -- power stored
  term.setCursor(1,4)
  term.write("Power stored: " .. reactor.getEnergyStored() .. " (" .. math.floor((reactor.getEnergyStored()/reactor.getMaxEnergyStored())*100) .. "%" .. ")" )
  -- heat
  term.setCursor(1,5)
  if (reactor.getHeatLevel() > 1) then
    gpu.setForeground(0xff0000)
  end
  if(reactor.getHeatLevel() < 0) then
    gpu.setForeground(0x37ff00)
  end
  term.write("Heat: " .. reactor.getHeatLevel() .. " (" .. math.floor((reactor.getHeatLevel()/reactor.getMaxHeatLevel())*100) .. "%" .. ")")
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