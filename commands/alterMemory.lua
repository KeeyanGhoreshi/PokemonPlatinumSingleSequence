local alterMemory = {}
pointerAddress = 0x02101D2C
battleRngAlter = 330788
pointer = memory.read_u32_le(pointerAddress)
lcRng = 0x021BFB14

function alterMemory.getBattleRng()
    return pointer + battleRngAlter
end

function alterMemory.setMemory(value)
    memory.write_u32_le(lcRng, value)
end

function alterMemory.getLCRNG()
    seed = memory.read_u32_le(lcRng)
    return seed
end
function alterMemory.getBRNG()
    seed = memory.read_u32_le(alterMemory.getBattleRng())
    return seed
end

return alterMemory