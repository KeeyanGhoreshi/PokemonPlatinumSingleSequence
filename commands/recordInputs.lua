package.path = "./commands/?.lua;"
movement = loadfile('movement.lua')
m = movement()

function consolidate(giLog)
    newGiLog = {}
    lastCommand = ""
    value = 0
    for i,v in ipairs(giLog) do

        if v[1] == lastCommand then
            value = value + v[2]
        else
            if lastCommand ~= "" then
                table.insert(newGiLog, {lastCommand, value})
            end
            lastCommand = v[1]
            value = v[2]
        end
    end
    if lastCommand ~= "" then
        table.insert(newGiLog, {lastCommand, value})
    end
    return newGiLog
end
function flushInputs(giLog)

    cgiLog = consolidate(giLog)
    for i,v in ipairs(cgiLog) do
        console.log("{'" .. v[1] .. "', " .. v[2] .. "}," )
    end
    client.pause()
    savestate.saveslot(5)
    return {}
end
function dumpInputs(giLog)
    return {}
end
function addWait(giLog)
    table.insert(giLog, {"w", 180})
    return giLog
end
function addShortWait(giLog)
    table.insert(giLog, {"w", 60})
    return giLog
end
function toggleAv(giLog)
    client.pause_av()
    return giLog
end
local inputMap = {
    ["Down"]={"d",1},
    ["Up"]={"u",1},
    ["Left"]={"l",1},
    ["Right"]={"r",1},
    ["X"] = {"press_a", 1},
    ["Z"] = {"press_b", 1},
    ["S"] = {"x", 15},
    ["A"] = {"y", 30},
    ["C"] = {"grass_cycle", 1},
    ["U"] = {"use_move", 1},
    ["P"] = {"pokecenter_heal", 1},
    ["R"] = {"reset_start", 1},
    ["Y"] = {"use_repel", 1},
    ["B"] = {"uf", 360},
}
local hotkeyMap = {
    ["Alt"] = flushInputs,
    ["LeftCtrl"] = dumpInputs,
    ["Ctrl"] = addWait,
    ["Shift"] = addShortWait,
    ["V"] = toggleAv

}
local inputLog = {}

console.clear()
latch = true
savestate.saveslot(6)

for i=1,100000 do
    inputs = input.get()
    if next(inputs) == nil then 
        latch = true
    end

    for k, v in pairs(inputs) do
        -- input keys are only in the table if they are pressed
        -- no need to check their value
        if inputMap[k] then
            m.executeOrders({
                inputMap[k]
            })
            table.insert(inputLog, inputMap[k])
        end
        if hotkeyMap[k] and latch then
            latch = false
            inputLog = hotkeyMap[k](inputLog)
        end
    end
    emu.frameadvance()
end

