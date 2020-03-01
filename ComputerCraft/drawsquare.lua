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
--drawSquare(colours.lime, colours.lightBlue, colours.red, 10,30,2, "Warning", "It works!", "lssssssssssssstol", "Line 3", "Line 4")


mon = peripheral.wrap("left")
function drawSquare( borderCol, boxCol, textCol, xStart, xEnd, yStart, ... )

  --[[ Defines the max amount of characters that can be printed within
           the box. If exceeded, it will error.
  --]]
  local maxLength = xEnd - xStart - 2
  --[[ This part does the border of the box ]]--
  mon.setBackgroundColour(borderCol)
  for x = xStart, xEnd do
          mon.setCursorPos(x, yStart)
          mon.write(" ")
          mon.setCursorPos(x, yStart+#arg+2)
          mon.write(" ")
  end
  for y = yStart + 1, yStart + #arg + 1 do
          mon.setCursorPos(xStart, y)
          mon.write(" ")
          mon.setCursorPos(xEnd, y)
          mon.write(" ")
  end
  
  --[[ This writes the title, which is the first string within
           the '...'
  --]]
  mon.setTextColour(textCol)
  mon.setCursorPos((xEnd - xStart - #arg[1])/2 + xStart + 1, yStart)
  mon.write(arg[1])

  --[[ This part fills the insides of the box with the desired
           colour
  --]]
  mon.setBackgroundColour(boxCol)
  for x = xStart + 1, xEnd - 1 do
          for y = yStart + 1, yStart + #arg + 1 do
                  mon.setCursorPos(x, y)
                  mon.write(" ")
          end
  end
  
  --[[ arg is '...' and accepts as many as you want, but of course - having
           more than 16? would be silly.
           It centeres each text within the box
  --]]
  for i = 2, #arg do
          if #arg[i] > maxLength then error("Length of arg #" .. i .. " exceeds max limit of " .. maxLength .. " characters.") end
          mon.setCursorPos((xEnd - xStart - #arg[i])/2 + xStart + 1, yStart + i)
          mon.write(arg[i])
  end
  
  --[[ Resets the variables and sets the cursorpos to be after the box. --]]
  mon.setBackgroundColour(colours.black)
  mon.setTextColour(colours.white)
  mon.setCursorPos(1, yStart + #arg + 4)
end

mon.clear()

drawSquare(colours.lime, colours.lightBlue, colours.red, 10,30,2, "Warning", "It works!", "lssssssssssssstol", "Line 3", "Line 4")