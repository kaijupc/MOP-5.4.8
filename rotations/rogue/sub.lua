local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy && !boss", "target"},
    -----
	{"#5512", "item(5512).usable && health<=30", "player"},
	{"Feint", "spell.ready && energy>30 && incdmg(1)>=health.max*0.4", "player"},
	{"Cloak of Shadows", "spell.ready && incdmg.magic(1)", "player"},
	--{"Cloak of Shadows", "spell.ready && incdmg.magic", "player"},
	{"Kick", "spell.ready && inmelee && interruptible", "nearEnemyCb"},
	{"Gouge", "spell.ready && inmelee && infront && interruptible", "nearEnemyCb"},
	-----
	{"Shiv", "spell.ready && inmelee && target.buff(Enrage)", "nearEnemyCb"},
	-----
	{"Crimson Tempest", "spell.ready && inmelee && player.energy>35 && combo>=4 && !debuff && player.area_range(8).enemies>=3", "nearEnemyCb"},
	{"Fan of Knives", "spell.ready && player.energy>35 && player.area_range(8).enemies>=4 && !combo==5", "target"},
	-----
	{"Rupture", "spell.ready && inmelee && player.energy>35 && combo>=5 && !debuff && boss", "target"},
	{"Slice and Dice", "spell.ready && inmelee && player.energy>35 && combo>=5 && !player.buff", "target"},
	{"Eviscerate", "spell.ready && inmelee && player.energy>35 && combo==5", "target"},
	{"Backstab", "spell.ready && behind && inmelee && player.energy>40 && !combo==5", "target"},
	{"Hemorrhage", "spell.ready && inmelee && player.energy>35 && !combo==5 && !boss && !player.buff(Shadow Walk)", "target"},
	{"Hemorrhage", "spell.ready && inmelee && player.energy>35 && !combo==5 && !debuff", "target"},
	
	
}

	
local outCombat = {
	{"Deadly Poison", "spell.ready && !buff", "player"},
	{"Recuperate", "!buff && !buff(Stealth)", "player"},
	{"Slice and Dice", "!buff && !buff(Stealth) && buff(Recuperate)", "player"},
}
	
_A.CR:Add(261, {
    name = "SUB",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})