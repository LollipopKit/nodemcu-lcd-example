local i2c_id  = 0
local sda = 1 -- GPIO14
local scl = 2 -- GPIO12
local sla = 0x3c
i2c.setup(i2c_id, sda, scl, i2c.SLOW)
local disp = u8g2.ssd1306_i2c_128x64_noname(i2c_id, sla)
disp:setFont(u8g2.font_6x10_tf)
disp:setDrawColor(1)
disp:setFontPosTop()

local start_x = 0
local start_y = 0
local draw_str = {'','','','','','',''}
local str_width = {0,0,0,0,0,0,0}
local times = 0

function set_str(data)
  if (data ~= '' and data ~= nil) then
    draw_str[7] = data
  end  
  if (draw_str[6] ~= draw_str[7]) then
    if draw_str[3] == '' then 
      for i=1,6 do
        draw_str[i] = draw_str[i+1]
      end
    else 
      for i=2,6 do
        draw_str[i] = draw_str[i+1]
      end 
    end
  end
end

function draw()
  disp:clearBuffer()
  for i=1,6 do
    local offset = 10 * (i - 1) + 1
    str_width[i] = disp:getStrWidth(draw_str[i])
    if (str_width[i] >= 128) then
      if (128 - str_width[i] == times * 3) then
        times = 0
      end
      disp:drawStr(start_x - times*3, start_y + offset, draw_str[i])
      times = times + 1
    else
      disp:drawStr(start_x, start_y + offset, draw_str[i])
    end
  end
  disp:sendBuffer()
end
