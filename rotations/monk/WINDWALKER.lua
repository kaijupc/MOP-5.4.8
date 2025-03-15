local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"!%pause", "dbm(stop cast)<=0.5"},
	{{
    {"%target", "range(2) <= 40", "nearEnemyCb"},
	}, "!target.exists || target.dead"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
	{"/cleartarget [dead][help]", "target.dead"},

	--------------------------------
	{"Legacy of the Emperor", "spell.ready && !buff(Legacy of the Emperor || Blessing of Kings || Mark of the Wild || Embrace of the Shale Spider).any", "player"},
	{"Legacy of the White Tiger", "spell.ready && !buff", "player"},
    --------------------------------
	
	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"Expel Harm", "spell.ready && health <= 80 && {spell.proc || energy >= 40}", "player"},
	{"Chi Wave", "spell.ready && range <=40", "enemiesCombat"},
	
	--BUFFS
	{"Fortifying Brew", "spell.ready && health <= 50", "player"},
	{"Diffuse Magic", "spell.ready && incdmg.magic(2) >= 10000", "player"},
	{"Detox", "spell.ready && player.energy >= 30 && debuff(Disease || Poison).type", "player"},
	{"Nimble Brew", "spell.ready && player.state(root || stun || dazed || fear || horrified)", "player"},
	
	{"Tigereye Brew", "spell.ready && && player.buff(Tigereye Brew).stack >= 10 && boss && health <= 97", "target"},
	
	{"Ring of Peace", "spell.ready && player.area_range(8).combatenemies >= 3", "player"},
	--{"Blood Fury", "spell.ready && target.health <= 97 && target.boss", "player" },
	
	--INTERRUPT/DISPEL
	{{
    {"Paralysis", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "enemiesCombat"},
	}, "spell(Paralysis).ready"},
	{{
    {"Spear Hand Strike", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "nearEnemyCb"},
	}, "spell(Spear Hand Strike).ready"},
	
	--AOE
	{"Fists of Fury", "spell.ready && inmelee && player.chi >= 3 && player.area_range(10).enemies.infront >= 1", "player"},
	{"Spinning Fire Blossom", "spell.ready && range(2) <= 40 && player.chi >= 2 && player.area_range(8).enemies.infront >= 4", "player"},
	{"Spinning Crane Kick", "spell.ready && energy >= 80 && player.area_range(8).combatenemies >= 5", "player"},
	
	
	
	--SPAM
	{"Touch of Death", "spell.ready && inmelee && player.chi >= 3 && player.buff(Death Note) && !ttd <= 5", "target"},
	{"Rising Sun Kick", "spell.ready && inmelee && player.chi >= 2 && !ttd <=1", "target"},
	{"Tiger Palm", "spell.ready && inmelee && player.buff(Tiger Power).duration <= 3", "target"},
	{"Jab", "spell.ready && inmelee && player.energy >= 40 && player.chi <= 5", "target"},
	{"Blackout Kick", "spell.ready && inmelee && {behind || infront} && {spell.proc || player.chi >= 2}", "target"},
	{"Tiger Palm", "spell.ready && inmelee && spell.proc", "target"},
	
	
}

local outCombat = {
	{"Legacy of the Emperor", "spell.ready && !buff(Legacy of the Emperor || Blessing of Kings || Mark of the Wild || Embrace of the Shale Spider).any", "player"},
	{"Stance of the Fierce Tiger", "spell.ready && !buff", "player"},
	{"Legacy of the White Tiger", "spell.ready && !buff", "player"},
	
}

_A.CR:Add(269, {
    name = "WINDWALKAH",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})