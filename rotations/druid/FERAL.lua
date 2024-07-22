local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
    --------------------------------
    {"Mangle", "spell.ready && inmelee", "target"},
}

local outCombat = {}

_A.CR:Add(103, {
    name = "FERAL",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})