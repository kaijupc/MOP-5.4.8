local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
	
	------------LIFESTEAL|POTS
	{"Victory Rush", "spell.ready && inmelee", "nearEnemyCb"},
	{"Healthstone", "item.usable && health <30", "player"},
	
    ------------BUFFS
	{"Battle Shout", "spell.ready", "player"},
	{"Blood Fury", "spell.ready && inmelee && target.health <97 && target.boss", "player"},
	{"Enraged Regeneration", "spell.ready && health <=35", "player"},
	{"Rallying Cry", "spell.ready && health <40", "player"},
	{"Shield Wall", "spell.ready && health <30", "player"},
	{"Berserker Rage", "spell.ready && inmelee && player.area_range(8).enemies >=1", "player"},
	{"Recklessness", "spell.ready && inmelee && target.health <97 && target.boss", "player"},
	{"Skull Banner", "spell.ready && target.health <95 && target.boss && !buff(Skull Banner)", "player"},
	
	------------REFLECT
	--{"Spell Reflection", "isCastingOnMe && casting.length>=1 && casting.remaining<=1", "enemies"},
	{"Spell Reflection", "spell.ready && isCastingOnMe && casting.length>=1 && casting.remaining<=0.5", "enemies"},
	
	------------INTERRUPT
	{"Pummel", "spell.ready && range(1) && interruptible", "nearEnemyCb"},
	{"Disrupting Shout", "spell.ready && interruptible && player.area_range(8).enemies >=2", "enemies"},
	
	------------AOE
	{"Sweeping Strikes", "spell.ready && player.rage >30 && player.area_range(3).enemies >=2", "nearEnemyCb"},
	{"Whirlwind", "spell.ready && player.rage >35 && player.area_range(8).enemies >= 4", "nearEnemyCb"},
	{"Thunder Clap", "spell.ready && player.area_range(8).enemies >=2 && player.rage >15", "nearEnemyCb"},
	{"Bladestorm", "spell.ready && inmelee && player.area_range(6).enemies >=10", "nearEnemyCb"},
	
	------------AOE DEBUFF
	--{"Demoralizing Banner", "spell.ready && player.area_range(8).enemies >=7", "cursor.ground"},
	{"Demoralizing Banner", "spell.ready && range(2) <=30 && player.area_range(8).enemies >=7", "target.ground"},
	{"Demoralizing Shout", "spell.ready && player.area_range(8).enemies >=1 && !target.debuff(Demoralizing Shout)", "nearEnemyCb"},
	
	------------SPAM
	{"Colossus Smash", "spell.ready && range(1)", "target"},
	{"Execute", "spell.ready && range(1) && player.rage >30 && health <=20", "target"},
	{"Mortal Strike", "spell.ready && range(1)", "target"},
	{"Slam", "spell.ready && range(1) && player.rage >30", "target"},
	{"Overpower", "spell.ready && inmelee && player.buff(Sudden Execute)", "target"},
	{"Heroic Strike", "spell.ready && inmelee && player.rage >40", "target"},
	{"Overpower", "spell.ready && inmelee && player.rage >20", "target"},
}

local outCombat = {
	--{"Commanding Shout", "spell.ready && !buff", "player"},
}
	

_A.CR:Add(71, {
    name = "ARMS",
    ic = inCombat,
    ooc = outCombat,
	use_lua_engine = false,
    gui = GUI,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
	load = exeOnLoad,
    unload = exeOnUnload
	
})

