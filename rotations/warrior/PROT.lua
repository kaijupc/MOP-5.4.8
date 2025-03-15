local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
    ------------LIFESTEAL|POTS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"Victory Rush", "spell.ready && inmelee", "nearEnemyCb"},
    ------------BUFFS
	{"Commanding Shout", "spell.ready && !buff", "player"},
	{"Shield Block", "spell.ready && health <70 && rage >=60 && !(Shield Block)", "player"},
	{"Enraged Regeneration", "spell.ready && health <=35", "player"},
	{"Blood Fury", "spell.ready && inmelee && target.health <97 && target.boss", "player"},
	{"Rallying Cry", "spell.ready && health <40", "player"},
	{"Last Stand", "spell.ready && health <30", "player"},
	{"Shield Barrier", "spell.ready && health <30 && rage>70 !buff(Shield Barrier)", "player"},
	{"Shield Wall", "spell.ready && health <30", "player"},
	{"Berserker Rage", "spell.ready && inmelee && player.area_range(8).enemies >=1", "player"},
	{"Recklessness", "spell.ready && target.health <97 && target.boss", "player"},
	{"Skull Banner", "spell.ready && target.health <97 && target.boss", "player"},
	------------REFLECT
	{"Spell Reflection", "spell.ready && isCastingOnMe && casting.length>=1 && casting.remaining<=1", "enemies"},
	------------TAUNT
	{"Taunt", "spell.ready && range(2) <=30 && threat<80", "bestCandidateForAggro(Taunt)"},
	------------INTERRUPT
	{"Pummel", "spell.ready && range(1) && interruptible", "nearEnemyCb"},
	{"Disrupting Shout", "spell.ready && interruptible && player.area_range(8).enemies >=2", "enemies"},
	------------AOE
	{"Cleave", "spell.ready && inmelee && player.area_range(3).enemies >=3 && player.buff(Ultimatum)", "nearEnemyCb"},
	{"Cleave", "spell.ready && inmelee && player.area_range(3).enemies >=3 && player.rage >=31", "nearEnemyCb"},
	{"Thunder Clap", "spell.ready && player.area_range(8).enemies >=2", "nearEnemyCb"},
	{"Bladestorm", "spell.ready && inmelee && player.area_range(6).enemies >=10", "nearEnemyCb"},
	------------AOE DEBUFF
	{"Mocking Banner", "spell.ready && player.area_range(30).enemies >=8", "cursor.ground"},
	{"Demoralizing Banner", "spell.ready && player.area_range(8).enemies >=7", "cursor.ground"},
	{"Demoralizing Shout", "spell.ready && player.area_range(8).enemies >=1 && !target.debuff(Demoralizing Shout)", "nearEnemyCb"},
	------------SPAM
	{"Execute", "spell.ready && range(1) && player.rage >30 && health <=20", "target"},
	{"Revenge", "spell.ready && inmelee", "target"},
	{"Shield Slam", "spell.ready && inmelee", "target"},
	{"Disarm", "spell.ready && inmelee", "target"},
	{"Heroic Strike", "spell.ready && range(1) && player.buff(Ultimatum)", "target"},
	{"Heroic Strike", "spell.ready && inmelee && player.rage >= 90", "target"},
	{"Devastate", "spell.ready && inmelee", "target"},
}

local outCombat = {
	--{"Commanding Shout", "spell.ready && !buff", "player"},
}
	

_A.CR:Add(73, {
    name = "PROT",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})