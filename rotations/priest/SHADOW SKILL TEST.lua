local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local player, target
local inCombat = {



	{{
    {"Silence", "iscasting.any.spell && spell.range && infront && los && casting.length>=1 && interruptAt(60)", "enemies"},
	}, "spell(Silence).ready"},

}

_A.CR:Add(258, {
    name = "SHADOW SKILL TEST",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})