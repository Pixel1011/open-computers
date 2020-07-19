local component = require("component")
local term = require("term")
--local reactor = component.nc_fission_reactor
local c = component.computer
local gpu = component.gpu
local x, y = gpu.maxResolution()
local reactor_iter = component.list('nc_fission_reactor')
local reactor, reactor1 = component.proxy(reactor_iter()), component.proxy(reactor_iter())
reactoronce = 0
reactor1once = 0
reactordeactivated = false
reactor1deactivated = false

function write()
  gpu.setResolution(45, 15)
  active = reactor.isProcessing()
  active1 = reactor1.isProcessing()
  onoff = ""
  onoff1 = ""
  -- information display
  term.clear()
  gpu.setForeground(0xffffff)
  term.setCursor(1,0)
  term.write("Nuclearcraft ".. reactor.getLengthX() .. "x" .. reactor.getLengthY() .. "x" .. reactor.getLengthZ() .. " fission reactor")
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
  if (reactor.getEnergyChange() > 1) then
    gpu.setForeground(0x37ff00)
  end
  if (reactor.getEnergyChange() < 1) then
    gpu.setForeground(0xff0000)
  end
  term.write("Power in RF/t: " .. reactor.getEnergyChange()*-1)
  gpu.setForeground(0xffffff)
  -- power stored
  term.setCursor(1,4)
  term.write("Power stored: " .. reactor.getEnergyStored() .. " (" .. math.floor((reactor.getEnergyStored()/reactor.getMaxEnergyStored())*100) .. "%" .. ")" )
  -- heat
  term.setCursor(1,5)
  if (reactor.getHeatLevel() > math.floor(reactor.getMaxHeatLevel())*0.5) then
    gpu.setForeground(0xff0000)
  end
  if(reactor.getHeatLevel() < math.floor(reactor.getMaxHeatLevel())*0.5) then
    gpu.setForeground(0x37ff00)
  end
  term.write("Heat: " .. reactor.getHeatLevel() .. " (" .. math.floor((reactor.getHeatLevel()/reactor.getMaxHeatLevel())*100) .. "%" .. ")")
  gpu.setForeground(0xffffff)
  -- fuel
  term.setCursor(1,6)
  gpu.setForeground(0x0f3800)
  term.write("Fuel: " .. reactor.getFissionFuelName())
  gpu.setForeground(0xffffff)


  -- information display
  gpu.setForeground(0xffffff)
  term.setCursor(1,8)
  term.write("Nuclearcraft ".. reactor1.getLengthX() .. "x" .. reactor1.getLengthY() .. "x" .. reactor1.getLengthZ() .. " fission reactor")
  -- on/offline 
  term.setCursor(1,9)
  if (active1 == true) then
    onoff1 = "Online" 
    gpu.setForeground(0x37ff00)
  end
  if (active1 == false) then
    onoff1 = "Offline" 
    gpu.setForeground(0xff0000)
  end
  term.write("Reactor: " .. onoff1)
  gpu.setForeground(0xffffff)
  -- power production
  term.setCursor(1,10)
  if (reactor1.getEnergyChange() > 1) then
    gpu.setForeground(0x37ff00)
  end
  if (reactor1.getEnergyChange() < 1) then
    gpu.setForeground(0xff0000)
  end
  term.write("Power in RF/t: " .. reactor1.getEnergyChange()*-1)
  gpu.setForeground(0xffffff)
  -- power stored
  term.setCursor(1,11)
  term.write("Power stored: " .. reactor1.getEnergyStored() .. " (" .. math.floor((reactor1.getEnergyStored()/reactor1.getMaxEnergyStored())*100) .. "%" .. ")" )
  -- heat
  term.setCursor(1,12)
  if (reactor1.getHeatLevel() > math.floor(reactor1.getMaxHeatLevel())*0.5) then
    gpu.setForeground(0xff0000)
  end
  if(reactor1.getHeatLevel() < math.floor(reactor1.getMaxHeatLevel())*0.5) then
    gpu.setForeground(0x37ff00)
  end
  term.write("Heat: " .. reactor1.getHeatLevel() .. " (" .. math.floor((reactor1.getHeatLevel()/reactor1.getMaxHeatLevel())*100) .. "%" .. ")")
  gpu.setForeground(0xffffff)
  -- fuel
  term.setCursor(1,13)
  gpu.setForeground(0x0f3800)
  term.write("Fuel: " .. reactor1.getFissionFuelName())
  gpu.setForeground(0xffffff)

  os.sleep(0.1)
end

function monitor()
  write()
  if (once == 0 and not reactor.isProcessing() or reactordeactivated == true and reactor.getHeatLevel() <= math.floor(reactor.getMaxHeatLevel())*0.4 and reactor.getEnergyStored() <= math.floor(reactor.getMaxEnergyStored())*0.5) then
    reactor.activate()
    reactoronce = 1
    reactordeactivated = false
  end
  if (reactor.getHeatLevel() >= math.floor(reactor.getMaxHeatLevel())*0.75 or reactor.getEnergyStored() >= math.floor(reactor.getMaxEnergyStored())*0.8) then -- man i hope reactors dont blow up due to this
    reactor.deactivate()
    reactordeactivated = true
  end
  if (not reactor.isProcessing() and once == 1) then
    reactoronce = 0
  end

  if (reactor1once == 0 and not reactor1.isProcessing() or reactor1deactivated == true and reactor1.getHeatLevel() <= math.floor(reactor1.getMaxHeatLevel())*0.4 and reactor1.getEnergyStored() <= math.floor(reactor1.getMaxEnergyStored())*0.5) then
    reactor1.activate()
    reactor1once = 1
    reactor1deactivated = false
  end
  if (reactor1.getHeatLevel() >= math.floor(reactor1.getMaxHeatLevel())*0.75 or reactor1.getEnergyStored() >= math.floor(reactor1.getMaxEnergyStored())*0.8) then
    reactor1.deactivate()
    reactor1deactivated = true
  end
  if (not reactor1.isProcessing() and reactor1once == 1) then
    reactor1once = 0
  end

end

while true do  
  monitor()
  --c.beep()
end