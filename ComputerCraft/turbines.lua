-- 4x3 monitor, left side
-- 2 turbines
-- hopefully cant explode :)
-- and an advanced computer would help
-- name Drawsquare drawsquare and touchpoint touchpoint

turbine1 = peripheral.wrap("BigReactors-Turbine_9")
turbine2 = peripheral.wrap("BigReactors-Turbine_8")
--os.loadAPI("turbine/touchpoint")
--[[ Simple function to draw a square with desired colours, x and y co-ordinates,
         and text within the function.
         
         borderCol = colour of the outside border
         boxCol    = colour of the inside of the box
         textCol   = colour of the text that appears within the box
         xStart    = starting X position of the box (top left hand corner of the box)
         xEnd      = ending X position of the box (top right hand corner of the box)
         yStart    = starting Y positon of the box
         ...       = arguments, accepts as many as you want. First one is the title.
--]]

os.loadAPI("turbine/drawsquare")
t = touchpoint.new("left")

mon = peripheral.wrap("left")
monX,monY = mon.getSize() -- 39, 19

local turbinendis = false
local turbinendis2 = false
local turbine1power = 0
local turbine2power = 0
local turbine1inductor = false
local turbine2inductor = false
local manual = false

t:add(" Manual Control", nil, 12, 15, 28, 18, colors.red, colors.lime)
t:draw()
function checkPower()
  turbine1power = turbine1.getEnergyProducedLastTick()
  turbine2power = turbine2.getEnergyProducedLastTick()
  turbine1inductor = turbine1.getInductorEngaged()
  turbine2inductor = turbine2.getInductorEngaged()
end

function writeMon()
  mon.clear()
  mon.setBackgroundColor(colors.black)
  if turbine1inductor == false then
    drawsquare.drawSquare(colors.red, colors.red, colors.orange, 3,15,2, "off")
  end
  if turbine1inductor == true then
    drawsquare.drawSquare(colors.lime, colors.lime, colors.green, 3,15,2, "on")
  end
  if turbine2inductor == false then
    drawsquare.drawSquare(colors.red, colors.red, colors.orange, 25,37,2, "off")
  end
  if turbine2inductor == true then
    drawsquare.drawSquare(colors.lime, colors.lime, colors.green, 25,37,2, "on")
  end

  mon.setCursorPos(2,1)
  mon.write("Turbine 1 Inductor")

  mon.setCursorPos(22,1)
  mon.write("Turbine 2 Inductor")
  
  mon.setCursorPos(2,7)
  mon.write("Rotor speed: " .. math.floor(turbine1.getRotorSpeed()))

  mon.setCursorPos(22,7)
  mon.write("Rotor speed: " .. math.floor(turbine2.getRotorSpeed()))

  mon.setCursorPos(2,8)
  mon.write("Power " .. math.floor(turbine1power) .. "RF/t")

  mon.setCursorPos(22,8)
  mon.write("Power " .. math.floor(turbine2power) .. "RF/T")

  mon.setCursorPos(9,10)
  mon.write("Total Power:" .. math.floor(turbine1power + turbine2power) .. "RF/T")
end

while true do
  checkPower()
  writeMon()
  local event, button = t:handleEvents(os.pullEvent())
  if event == "button_click" then
    t:toggleButton(button)
    if manual == false then
      manual = true
    end
    
    if manual == true then 
      manual = false
    end

  end

  if manual == false then
    turbine1.setActive(true)
    turbine2.setActive(true)

    turbine1.setVentOverflow(true)
    turbine2.setVentOverflow(true)

    turbine1.setFluidFlowRateMax(2000)
    turbine2.setFluidFlowRateMax(2000)

    if turbine1.getRotorSpeed() >= 20000 then
      if turbine1inductor == false then

        turbine1.setInductorEngaged(true)
        print("Turbine 1 Inductor Engaged")
        sleep(1)
        print("Turbine 1 Generating " .. turbine1.getEnergyProducedLastTick() .. "RF/T")
      end
    end

    if turbine1.getRotorSpeed() < 10000 then
      if turbine1inductor == true then
  
        turbine1.setInductorEngaged(false)
        print("Turbine 1 Inductor Disengaged")
      end
    end

    if turbine2.getRotorSpeed() >= 20000 then
      if turbine2inductor == false then

        turbine2.setInductorEngaged(true)
        print("Turbine 2 Inductor Engaged")
        sleep(1)
        print("Turbine 2 Generating " .. turbine2.getEnergyProducedLastTick() .. "RF/T")
      end
    end

    if turbine2.getRotorSpeed() < 10000 then
      if turbine2inductor == true then

        turbine2.setInductorEngaged(false)
        print("Turbine 2 Inductor Disengaged")
      end
    end
  end
  sleep(0.2)
end