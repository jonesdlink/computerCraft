-- reset.lua

-- Settings
local move_finish = 82 -- This should match the setting in Mine
local coal_name = "minecraft:coal" -- What is the ID string for coal?
local torch_name = "minecraft:torch" -- What is the ID string for torches?
 
-- Define Variables
local step2_finish = 6
local step = 1
local step2 = 1
local sufficient_fuel = false
local fuel_reqired = move_finish + step2_finish
local found_torches = false

-- Set up the terminal
term.clear()
term.setCursorPos(1,1)
print("Executing Program: Reset")
print("move_finish: " .. move_finish)
print("")

-- Pre-Flight Checks
-- Check that there is enough fuel
while sufficient_fuel == false do
    print("Checking fuel level...")
    if turtle.getFuelLevel() > fuel_reqired then
        print("Sufficient fuel loaded")
        sufficient_fuel = true
    else
        print("Insufficient fuel loaded.  Checking for coal in inventory...")
        while selected_space ~= 17 do
            local data = turtle.getItemDetail(selected_space)
            if data ~= nil then
                if data.name == coal_name then
                    print("Coal located.  Refueling...")
                    turtle.select(selected_space)
                    turtle.refuel()
                    break
                elseif selected_space == 16 then
                    error("No coal located.  Please add coal to inventory and execute program again.")
                end
            elseif selected_space == 16 then
                error("No coal located.  Please add coal to inventory and execute program again.")
            end
            selected_space = selected_space + 1
        end
    end
end

-- Find the torches in the inventory
selected_space = 1
print("Finding torches...")
while selected_space ~= 17 do
    local data = turtle.getItemDetail(selected_space)
    if data ~= nil then
        if data.name == torch_name then
            print("Torches located")
            turtle.select(selected_space)
            found_torches = true
            break
        elseif selected_space == 16 then
            error("No torches located.  Please add torches to inventory and execute program again.")
        end
    elseif selected_space == 16 then
        error("No torches located.  Please add torches to inventory and execute program again.")
    end
    selected_space = selected_space + 1
end

-- Reset the turtle position
move_finish = move_finish + 1
turtle.turnLeft()
turtle.turnLeft()
repeat
    turtle.forward()
    step = step + 1
until step == move_finish
 
turtle.turnLeft()
 
repeat
    turtle.forward()
    while turtle.detectDown() == true do
	    turtle.digDown()
	end
	while turtle.detectUp() == true do
	    turtle.digUp()
	end
	while turtle.detect() == true do
	    turtle.dig()
	end
    step2 = step2 + 1
until step2 == 6
turtle.turnLeft()
while turtle.detect() == true do
    turtle.dig()
end
turtle.forward()
turtle.turnLeft()
while turtle.detect() == true do
    turtle.dig()
end
turtle.place()
turtle.turnRight()