local movement = {}
alterMemory = loadfile('alterMemory.lua')
p = alterMemory()
scriptName = "None"

press_a = {
    {'a', 60},
    {'w', 5},
}
press_b = {
    {'b', 30},
    {'w', 5}
}

spin = {
    {'u', 1},
    {'l', 1},
    {'d', 1},
    {'r', 1},
}

spin_fast = {
    {'uf', 4},
    {'w', 2},
    {'lf', 4},
    {'w', 2},
    {'df', 4},
    {'w', 2},
    {'rf', 4},
    {'w', 2},
}
reset_start = {
    {'w', 60},
    {'x', 15},
    {'w', 60},
    {'df', 20},
    {'a', 120},
    {'b', 200},
    {'df', 20},
    {'a', 120},
    {'b', 200},
    {'df', 20},
    {'a', 120},
    {'b', 200},
    {'df', 20},
    {'a', 120},
    {'b', 200},
    {'df', 20},
    {'a', 120},
    {'b', 200},
    {'df', 20},
    {'a', 120},
    {'b', 200},
    {'df', 20},
    {'a', 120},
    {'b', 200},
}
grass_cycle = { 
    {'w', 990}, -- begin grass run cycle
    {'press_b', 4},
    {'w', 120},
    {'x', 15},
    {'d', 2},
    {'rf', 10},
    {'x', 15},
    {'a', 60},
    {'a', 60},
    {'a', 60},
    {'w', 180}, -- end grass run cycle
}
wild_train_cycle = {
    {'spin', 64}, -- guarentee wild encounter
    {'w', 600},
    {'l', 4}, -- recenter on fight
    {'u', 2},
    {'press_a', 1},
    {'use_move', 2}, -- use return twice
    {'press_b', 10}, -- finish off any level up text
    {'r', 1},
    {'grass_cycle', 1}, -- leave the grass
    {'r', 4}, -- realign against sign post
    {'w', 60},
    {'d', 2},
    {'r', 28},
    {'u', 3}, -- into pokecenter
    {'w', 540},
    {'u', 6},
    {'press_a', 9}, -- heal
    {'press_b', 10},
    {'d', 8},
    {'w', 360},
    {'d', 1},
    {'l', 29},
    {'u', 2},
    {'l', 2},
    {'w', 30},
}
use_repel = {
    {'w', 60},
    {'x', 15},
    {'w', 60},
    {'press_a', 1},
    {'w', 360},
    {'press_a', 1},
    {'w', 60},
    {'press_a', 1},
    {'w', 60},
    {'press_b', 8},

}
wild_train_cycle_2 = {
    {'spin', 64},
    {'w', 600},
    {'l', 4}, -- recenter on fight
    {'u', 2},
    {'press_a', 1}, -- use move first time
    {'w', 180},
    {'press_a', 1},
    {'w', 1200},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'press_a', 1}, -- use move second time
    {'w', 360},
    {'press_a', 1},
    {'w', 1200},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'r', 1},
    {'w', 990}, -- begin grass run cycle
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'x', 15},
    {'d', 2},
    {'rf', 10},
    {'x', 15},
    {'a', 60},
    {'w', 360},
    {'press_b', 1},
    {'w', 360}, -- end grass run cycle
    {'r', 4}, -- realign against sign post
    {'w', 60}, -- allow wall bump state to settle
    {'d', 2},
    {'r', 28},
    {'u', 3}, -- into pokecenter
    {'w', 540},
    {'u', 6},
    {'w', 60},
    {'a', 60},
    {'w', 360},
    {'a', 60},
    {'w', 360},
    {'a', 60},
    {'w', 360},
    {'r', 1},
    {'a', 60},
    {'w', 550},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'press_b', 1},
    {'w', 360},
    {'d', 8},
    {'w', 360},
    {'d', 1},
    {'l', 28},
    {'u', 2},
    {'l', 3},
    {'w', 30},
}
battle_setup = {
    {'w',500},
    {'a',5},
    {'w',240},
    {'a',60},
    {'w',240},
    {'a', 15},
    {'df', 15},
    {'rf', 15},
}

use_move = {
    {'a', 30},
    {'w', 30},
    {'a', 30},
    {'w', 1260},
}
pokecenter_heal = {
    {'u', 8},
    {'w', 60},
    {'press_a', 8},
    {'press_b', 10},
}
bike_slide = {
    {'df', 8},
    {'lf', 20},
}
local function setJoypad(direction)
    joypad.set(direction)
end

local function advance()

    emu.frameadvance()
end

lastDirection = "d"
function movement.waitFrames(frames, _callback, param)
    for i = 1,frames do
        if _callback then
            if param then
                _callback(param)
            else
                _callback()
            end
        elseif frames > 30 then

            -- gui.text(50, 50, i .. '/' .. frames)
        end
        advance()

    end

end

function movement.set_mem(seed)
    p.setMemory(seed)
end

function movement.a(frames)
    press = frames or 1
    movement.waitFrames(press, setJoypad, {A=true})
    joypad.set({A=false})
    advance()
end
function movement.b(frames)
    press = frames or 1

    movement.waitFrames(press, setJoypad, {B=true})
    joypad.set({B=false})
    advance()
end
function movement.s(frames)
    press = frames or 3

    movement.waitFrames(press, setJoypad, {Start=true})
    joypad.set({Start=false})
    advance()
end
function movement.y(frames)
    press = frames or 1
    movement.waitFrames(press, setJoypad, {Y=true})
    joypad.set({Y=false})
    advance()
end
function movement.x(frames)
    movement.waitFrames(16) -- let actions settle before trying to open menu
    press = frames or 1
    movement.waitFrames(press, setJoypad, {X=true})
    joypad.set({X=false})
    advance()
end

function movement.w(frames)
    press = frames or 1
    movement.waitFrames(press)
end



function movement.r(frames)
    press = frames or 1
    movement.waitFrames(press, setJoypad, {Right=true})
    joypad.set({Right=false})
    advance()
end

function movement.u(frames)
    press = frames or 1

    movement.waitFrames(press, setJoypad, {Up=true})
    joypad.set({Up=false})
    advance()
end

function movement.l(frames)
    press = frames or 1

    movement.waitFrames(press, setJoypad, {Left=true})
    joypad.set({Left=false})
    advance()
end

function movement.d(frames)
    press = frames or 1

    movement.waitFrames(press, setJoypad, {Down=true})
    joypad.set({Down=false})
    advance()
end

function movement.rf(frames)
    press = frames or 1

    movement.waitFrames(press, setJoypad, {Right=true})
    joypad.set({Right=false})
    advance()
end

function movement.uf(frames)
    press = frames or 1

    movement.waitFrames(press, setJoypad, {Up=true})
    joypad.set({Up=false})
    advance()
end

function movement.lf(frames)
    press = frames or 1

    movement.waitFrames(press, setJoypad, {Left=true})
    joypad.set({Left=false})
    advance()
end

function movement.df(frames)
    press = frames or 1

    movement.waitFrames(press, setJoypad, {Down=true})
    joypad.set({Down=false})
    advance()
end

function movement.runU(frames)
    press = frames or 1
    movement.waitFrames(press, setJoypad, {Up=true, B=true})
    joypad.set({Up=false, B=false})
    advance()
end
function movement.runD(frames)
    press = frames or 1
    movement.waitFrames(press, setJoypad, {Down=true, B=true})
    joypad.set({Down=false, B=false})
    advance()
end

function movement.runR(frames)
    press = frames or 1
    movement.waitFrames(press, setJoypad, {Right=true, B=true})
    joypad.set({Right=false, B=false})
    advance()
end

function movement.runL(frames)
    press = frames or 1
    movement.waitFrames(press, setJoypad, {Left=true, B=true})
    joypad.set({Left=false, B=false})
    advance()
end
function movement.bike_slide(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](bike_slide)
    end
end

function movement.moveTiles(direction, tiles)
    if tiles then
        for j=1, tiles do
            movement['waitFrames'](16)
            movement[direction](5)
        end
    else
        movement[direction](2)
    end
end
function movement.custom1(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom1)
    end
end
function movement.custom2(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom2)
    end
end
function movement.custom3(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom3)
    end
end
function movement.custom4(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom4)
    end
end
function movement.custom5(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom5)
    end
end
function movement.custom6(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom6)
    end
end
function movement.custom7(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom7)
    end
end
function movement.custom8(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom8)
    end
end
function movement.custom9(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom9)
    end
end
function movement.custom10(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom10)
    end
end
function movement.custom11(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom11)
    end
end
function movement.custom12(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](custom12)
    end
end
function movement.spin(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](spin)
    end
end
function movement.spin_fast(frames)
    press = frames or 1;
    for j=1, press do
        movement['executeOrders'](spin_fast)
    end
end
function movement.grass_cycle(frames)
    press = frames or 1;
    movement['executeOrders'](grass_cycle);
end

function movement.attack_down_ember(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](attack_down_ember);
    end
end
function movement.wild_train_cycle(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](wild_train_cycle);
    end
end
function movement.wild_train_cycle_2(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](wild_train_cycle_2);
    end
end
function movement.press_b(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](press_b);
    end
end

function movement.kickR(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](kickR);
    end
end
function movement.kickL(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](kickL);
    end
end
function movement.kickU(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](kickU);
    end
end
function movement.kickD(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](kickD);
    end
end

function movement.press_a(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](press_a);
    end
end
function movement.touch_middle(frames)
    press = frames or 1;
    joypad.setanalog({["Touch X"] = 128, ["Touch Y"] = 96})
    movement.waitFrames(press, setJoypad,{ Touch=true})
    joypad.set({Touch=false})
    joypad.setanalog({TouchX=false,TouchY=false})
end
function movement.flip_coin(frames)
    press = frames or 1;
    joypad.setanalog({TouchX=112,TouchY=140})
    movement.waitFrames(press, setJoypad,{ Touch=true})
    joypad.set({Touch=false})
    joypad.setanalog({TouchX=false,TouchY=false})
end
function movement.gym_loop(frames)
    press = frames or 1;
    for j=1, frames do
        movement['executeOrders'](gym_loop);
    end
end
function movement.use_growl(frames)
    press = frames or 1
    for j=1, frames do
        movement['executeOrders'](use_growl)
    end
end

function movement.doug_cycle_1(frames)
    press = frames or 1
    for j=1, frames do 
        movement['executeOrders'](doug_cycle_1)
    end
end

function movement.doug_cycle_2(frames)
    press = frames or 1
    for j=1, frames do 
        movement['executeOrders'](doug_cycle_2)
    end
end

function movement.doug_cycle_3(frames)
    press = frames or 1
    for j=1, frames do 
        movement['executeOrders'](doug_cycle_3)
    end
end

function movement.doug_cycle_4(frames)
    press = frames or 1
    for j=1, frames do 
        movement['executeOrders'](doug_cycle_4)
    end
end

function movement.doug_cycle_5(frames)
    press = frames or 1
    for j=1, frames do 
        movement['executeOrders'](doug_cycle_5)
    end
end

function movement.bridge_cycle(frames)
    press = frames or 1
    for j=1, frames do 
        movement['executeOrders'](bridge_cycle)
    end
end

function movement.battle_setup(frames) 
    movement['executeOrders'](battle_setup)
end

function movement.switch_jolt(frames) 
    movement['executeOrders'](switch_jolt)
end


function movement.battle_setup_ember(frames) 
    movement['executeOrders'](battle_setup_ember)
end

function movement.reset_start(frames) 
    movement['executeOrders'](reset_start)
end

function movement.use_move(frames)
    press = frames or 1
    for j=1, frames do 
        movement['executeOrders'](use_move)
    end
end

function movement.run_daycare(frames)
    press = frames or 1
    for j=1, frames do 
        movement['executeOrders'](run_daycare)
    end
end

function movement.pokecenter_heal(frames) 
    movement['executeOrders'](pokecenter_heal)
end

function movement.swap_pokemon(frames) 
    movement['executeOrders'](swap_pokemon)
end

function movement.poison_kill(frames)
    press = frames or 1
    for j=1, frames do 
        movement['executeOrders'](poison_kill)
    end
end

function movement.use_repel(frames)
    movement['executeOrders'](use_repel)
end

function movement.save(fileName)
    id = client.xpos()
    seed = p.getLCRNG()
    savestate.save('../autosaves/'.. scriptName .. '/' .. id .. '_' .. '_' .. fileName .. "_" .. seed .. '.State')
end

function movement.executeOrders(list, startFrom)
    locked = true
    if startFrom == nil then
        locked = false
    end

    for i,v in ipairs(list) do
        if locked then
            if v[2] == startFrom then
                locked = false
            end
        else
            if v[1] == 'r' or v[1] == 'l' or v[1] == 'd' or v[1] == 'u' then 
                movement.moveTiles(v[1],v[2])
            else
                movement[v[1]](v[2])
            end
        end
    end
end


return movement