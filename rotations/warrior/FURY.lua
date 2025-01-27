local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
    --------------------------------
	{"Battle Stance", "exists && spell.ready && stance != 1 && health >= 30", "player"},
    {"Defensive Stance", "exists && spell.ready && stance != 2 && health <= 29", "player"},
	 --------------------------------
	{"Healthstone", "item.usable && health <30", "player"},
	{"Battle Shout", "spell.ready", "player"},
	{"Rallying Cry", "spell.ready && roster.health <40", "player"},
	--{"Shield Barrier", "spell.ready && health <20 && !player.buff(Shield Barrier)", "player"},
	{"Shield Wall", "spell.ready && health <50", "player"},
	--------------------------------
	{"Spell Reflection", "isCastingOnMe && casting.length>=1 && casting.remaining<=1", "enemies"},
	--------------------------------
	{"Pummel", "spell.ready && range(1) && interruptible", "nearEnemyCb"},
	--------------------------------
	{"Berserker Rage", "spell.ready && !buff && rage <30", "player"},
	{"Blood Fury", "spell.ready && target.health < 98 && target.boss", "player" },
	{"Recklessness", "spell.ready && target.health <98 && target.boss", "player"},
	{"Skull Banner", "spell.ready && target.health <98 && target.boss && !buff(Skull Banner)", "player"},
	--------------------------------
	{"Whirlwind", "spell.ready && player.rage >25 && player.area_range(8).enemies >= 3", "target"},
	{"Demoralizing Banner", "spell.ready && range(2) <=30 && player.area_range(8).enemies >=7", "target.ground"},
	{"Thunder Clap", "spell.ready && player.rage >10 && player.area_range(8).enemies >= 3", "target"},
	--------------------------------
	{"Storm Bolt", "spell.ready && range(2) <=30", "target"},
	{"Colossus Smash", "spell.ready && range(1)", "target"},
	{"Execute", "spell.ready && range(1) && player.rage >30 && target.health <=20", "target"},
	{"Raging Blow", "spell.ready && range(1)", "target"},
	{"Bloodthirst", "spell.ready && range(1)", "target"},
	{"Wild Strike", "spell.ready && range(1) && player.buff(Bloodsurge)", "target"},
	{"Impending Victory", "spell.ready && range(1)", "target"},
	{"Heroic Strike", "spell.ready && range(1) && player.rage >=40", "target"},
}

local outCombat = {
	--{"Commanding Shout", "spell.ready && !buff", "player"},
}
	

_A.CR:Add(72, {
    name = "FURY",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})