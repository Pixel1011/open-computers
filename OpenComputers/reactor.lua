-- Tier 3 computer, attach 3x4 (3 high, 4 along) tier 3 screen, keyboard, attach reactor via cable to the fission controller
-- ^ tier 3 graphics card, internet card, tier 3 cpu, 2 tier 3.5 memory sticks, tier 3 hard disk, lua eeprom
-- install openos by inserting the open os disk and typing install then reboot computer
-- type wget https://raw.githubusercontent.com/Pixel1011/open-computers/master/OpenComputers/reactor.lua && reactor.lua
-- that command will download and start the plugin, make sure the fission reactor is built and connected
-- if you reboot the computer just type: reactor.lua
-- to restart the program and it doesnt matter if its already running or not
-- and once all that is done you have the ability to not care about reactors melting down unless they melt down within 1 second

local component = require("component")
local term = require("term")
local reactor = component.nc_fission_reactor
local c = component.computer
local gpu = component.gpu
local x, y = gpu.maxResolution()
reactorOnline = false;
once = 0;
deactivated = false;

function write()
  gpu.setResolution(45, 15)
  active = reactor.isProcessing()
  onoff = ""
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
  -- debug
  --term.setCursor(1,7)
  --term.write(once)

  --gpu.setResolution(x, y)
  os.sleep(1)
end

function monitor()
  write()
  if (once == 0 and not reactor.isProcessing() or deactivated == true and reactor.getHeatLevel() <= math.floor(reactor.getMaxHeatLevel())*0.4 and reactor.getEnergyStored() <= math.floor(reactor.getMaxEnergyStored())*0.5) then
    reactor.activate()
    once = 1
    deactivated = false
  end
  if (reactor.getHeatLevel() >= math.floor(reactor.getMaxHeatLevel())*0.75 or reactor.getEnergyStored() >= math.floor(reactor.getMaxEnergyStored())*0.8) then -- man i hope reactors dont blow up due to this
    reactor.deactivate()
    deactivated = true
  end
  if (not reactor.isProcessing() and once == 1) then
    once = 0
  end

end

while true do  
  monitor()
  --c.beep()
end