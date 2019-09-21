-- mine.lua

-- Settings
local torch_freq = 9 -- How frequently should torches be placed?
local move_finish = 82 -- How many blocks should the turtle go before stopping?  Hint: Make the finish divisible by torch_freq
local coal_name = "minecraft:coal" -- What is the ID string for coal?
local torch_name = "minecraft:torch" -- What is the ID string for torches?

-- Define Variables
local move_step = 1
local torch_step = 1
local torch_count = 1
local selected_space = 1
local sufficient_fuel = false
local found_torches = false
local sufficient_torches = false
local torches_needed = math.floor(move_finish / torch_freq)

-- Set up the terminal
term.clear()
term.setCursorPos(1,1)
print("Executing Program: Mine")
print("move_finish: " .. move_finish)
print("torch_freq: " .. torch_freq)
print("torches_needed: " .. torches_needed)
print("")

-- Pre-Flight Checks
-- Check that there is enough fuel
repeat
    print("Checking fuel level...")
    if turtle.getFuelLevel() > move_finish then
        print("Sufficient fuel loaded")
        sufficient_fuel = true
    else
        print("Insufficient fuel loaded.  Checking for coal in inventory...")
        repeat
            print(selected_space)
            local data = turtle.getItemDetail(selected_space)
            if data ~= nil then
                if data.name == coal_name then
                    print("Coal located.  Refueling...")
                    turtle.select(selected_space)
                    turtle.refuel()
                    break
                elseif selected_space == 16 then
                    print("No coal located.  Please add coal to inventory and execute program again.")
                    exit()
                end
            end
            selected_space = selected_space + 1
        until selected_space == 16
    end
until sufficient_fuel == true

-- Find the torches in the inventory
selected_space = 1
repeat
    print("Finding torches...")
    repeat
        local data = turtle.getItemDetail(selected_space)
        if data.name == torch_name then
            print("Torches located")
            turtle.select(selected_space)
            found_torches = true
            break
        elseif selected_space == 16 then
            print("No torches located.  Please add toreches to inventory and execute program again.")
            exit()
        end
        selected_space = selected_space + 1
    until selected_space == 16
until found_torches == true

-- Check that there are enough torches
repeat
    print("Checking torch count...")
    if turtle.getItemCount() > torches_needed then
        print("Sufficient torches found")
        sufficient_torches = true
    else
        print("Insufficient torches found.  Checking for torches in another inventory slot...")
        repeat
            selected_space = selected_space + 1
            local data = turtle.getItemDetail(selected_space)
            if data.name == torch_name then
                print("Torches located")
                turtle.select(selected_space)
                break
            elseif selected_space == 16 then
                print("No torches located.  Please add toreches to inventory and execute program again.")
                exit()
            end
        until selected_space == 16
    end
until sufficient_torches == true

-- Begin Mining
turtle.select(1)
while turtle.detectDown() == true do
    turtle.digDown()
end
while turtle.detectUp() == true do
    turtle.digUp()
end
while turtle.detect() == true do
    turtle.dig()
end
turtle.turnRight()
while turtle.detect() == true do
    turtle.dig()
end
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
    turtle.turnLeft()
    while turtle.detect() == true do
        turtle.dig()
    end
    if torch_step == torch_freq then
        turtle.place()
        torch_step = 0
    end
    turtle.turnRight()
    turtle.turnRight()
    while turtle.detect() == true do
        turtle.dig()
    end
    turtle.turnLeft()

    step = step + 1
    torch_step = torch_step + 1
until step == finish
