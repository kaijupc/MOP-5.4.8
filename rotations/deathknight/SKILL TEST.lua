local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {

	
	
}

local outCombat = {}

_A.CR:Add(251, {
    name = "FROSTY - SKILL TEST",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})