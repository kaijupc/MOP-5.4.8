local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local addonName, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local function stopcast(nTimes)
    for i=1,nTimes do
        _A.SpellStopCasting()
    end
end

local inCombat = {

	{"Master's Call", "spell.ready && !buff && player.state(root || dazed)", "player"},
	
	
}

local outCombat = {
	
	
	
}



_A.CR:Add(253, {
	name = "BEASTMASTER SKILL TEST",
	ic = inCombat,
    ooc = outCombat,
	wow_ver = "5.4.8",
	apep_ver = "1.1",
})
