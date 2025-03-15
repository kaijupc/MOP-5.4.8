local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {






	{"Fists of Fury", "spell.ready && inmelee && player.chi >= 3 && player.area_range(10).enemies.infront >= 1", "player"},


	{"Jab", "spell.ready && inmelee && player.energy >= 40 && player.chi <= 5", "target"},

	
	
}

local outCombat = {

	
}

_A.CR:Add(269, {
    name = "WW SKILL TEST",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})