local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
    --------------------------------
	{"Commanding Shout", "spell.ready && !buff", "player"},
	{"Shield Block", "spell.ready && health < 70 && !player.buff(Shield Block)", "player"},
	{"Enraged Regeneration", "spell.ready && health < 50", "player"},
	{"Rallying Cry", "spell.ready && health < 40", "player"},
	{"Last Stand", "spell.ready && health < 30", "player"},
	{"Shield Barrier", "spell.ready && health < 20 && !player.buff(Shield Barrier)", "player"},
	{"Shield Wall", "spell.ready && health < 50 && target.boss", "player"},
	--------------------------------
	--{"Taunt", "spell.ready && && range(2) <= 30 && threat < 80", "bestCandidateForAggro(Taunt)"},
	{"Pummel", "spell.ready && range(1) && target.interruptible", "target"},
	--------------------------------
	{"Berserker Rage", "spell.ready && !buff && rage < 30", "player"},
	{"Recklessness", "spell.ready && target.health <98 && target.boss", "player"},
	{"Skull Banner", "spell.ready && target.health <98 && target.boss", "player"},
	--------------------------------
	{"Cleave", "spell.ready && player.rage => 40 && player.area_range(1).enemies >= 3", "target"},
	{"Execute", "spell.ready && range(1) && player.rage >30 && target.health <= 20", "target"},
	{"Mocking Banner", "spell.ready && player.area_range(8).enemies >= 8", "cursor.ground"},
	{"Demoralizing Banner", "spell.ready && player.area_range(8).enemies >= 7", "cursor.ground"},
	{"Thunder Clap", "spell.ready && player.area_range(8).enemies >= 1", "target"},
	{"Demoralizing Shout", "spell.ready && player.area_range(8).enemies >= 1 && !target.debuff(Demoralizing Shout)", "target"},
	--------------------------------
	{"Spell Reflection", "isCastingOnMe && casting.length>=1 && casting.remaining<=0.5", "enemies"},
	--------------------------------
	{"Victory Rush", "spell.ready && inmelee", "target"},
	{"Heroic Strike", "spell.ready && range(1) && player.buff(Ultimatum)", "target"},
	{"Revenge", "spell.ready && inmelee", "target"},
	{"Shield Slam", "spell.ready && inmelee", "target"},
	{"Heroic Strike", "spell.ready && inmelee && player.rage >= 40", "target"},
	{"Devastate", "spell.ready && inmelee", "target"},
}

local outCombat = {
	{"Commanding Shout", "spell.ready && !buff", "player"},
}
	

_A.CR:Add(73, {
    name = "PROT",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})