# nodemcu-lcd-sample
A lua sample script for NodeMCU with lcd mod.  

# feature
auto scroll, like a terminal.  
自动滚动显示（当文字长度过长，无法同时显示时），逐行输出. 

# usage
call `set_str` method to set str, and set timer to refresh buffer by calling `draw` method.  
调用set_str来设置需要输出的文本，同时设置一个timer来刷新显示内容。  

`
set_str('hello world.')
tmr.create():alarm(300, tmr.ALARM_AUTO, draw) 
`

or

`
tmr.create():alarm(3000, tmr.ALARM_AUTO, function()
  http.get('', nil, function(code, data)
    set_str(data)
  end)
end)
tmr.create():alarm(300, tmr.ALARM_AUTO, draw) 
`

# thanks
u8g2,i2c lib
