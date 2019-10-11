local sensorFace = 'bottom'
local doorFace = 'back'
local controlChannel = 50
 
-- Open the modem for listening
local modem = peripheral.wrap("left")
modem.open(controlChannel)
 
-- Set the initial states
local oldstate = false
local locked = false
rs.setOutput(doorFace,true)
 
while true do
  -- Grab the current event
  local event, param1, param2, param3, param4, param5 = os.pullEvent()
 
  -- Handle redstone events
  if (event == 'redstone' and locked == false) then
    local state = rs.getInput(sensorFace)
    if oldState ~= state then
      if state == true then
        rs.setOutput(doorFace,false)
      else
        rs.setOutput(doorFace,true)
      end
    end
    oldstate = state
  end
 
  -- Handle modem events
  if event == 'modem_message' then
    if param4 == 'unlock' then
      locked = false
    end
 
    if param4 == 'lock' then
      rs.setOutput(doorFace,true)
      oldstate = false
      locked = true
    end
  end
end
