local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local function stopcast(nTimes)
    for i=1,nTimes do
        _A.SpellStopCasting()
    end
end

local buffsTable = {}
buffsTable["PhysImmune"] = {
    642, -- Divine Shield
    63710, -- Void Barrier
    ...
}
local tempMagicImmune = {
    7121, -- Anti-Magic Shield
    60158, -- Magic Reflection
    ...
}
buffsTable["MagicImmune"] = _A.TableMerge(buffsTable["PhysImmune"], tempMagicImmune)
tempMagicImmune = nil    


_A.DSL:Register('debuffs.specific', function(target, spell)
    -- All buffs/debuffs are cached per unit, so this iteration is not a problem
    for _, id in ipairs(debuffsTable[spell]) do
        if DSL("debuff.any")(target, id) then
            return true
        end
    end
    return false
end)

_A.DSL:Register('buffs.specific', function(target, spell)
    -- All buffs/debuffs are cached per unit, so this iteration is not a problem
    for _, id in ipairs(buffsTable[spell]) do
        if DSL("buff.any")(target, id) then
            return true
        end
    end
    return false
end)


_A.DSL:Register('fakeNotNil', function(target)    
    return target~=nil
end)   




-- your code here