local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"!%pause", "dbm(stop cast)<=0.5"},
	{{
    {"%target", "range(2) <= 40", "nearEnemyCb"},
	}, "!target.exists || target.dead"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
	{"/cleartarget [dead][help]", "target.dead"},

	{"Stance of the Sturdy Ox", "spell.ready && !buff", "player"},
	{"Legacy of the Emperor", "spell.ready && !buff(Legacy of the Emperor || Blessing of Kings || Mark of the Wild || Embrace of the Shale Spider).any", "player"},

	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"Expel Harm", "spell.ready && health <= 80 && {spell.proc || energy >= 40}", "player"},
	{"Chi Wave", "spell.ready && range <=40", "enemiesCombat"},
	
	--BUFFS
	{"Fortifying Brew", "spell.ready && health <= 50", "player"},
	{"Diffuse Magic", "spell.ready && incdmg.magic(2) >= 10000", "player"},
	{"Guard", "spell.ready && buff(Power Guard) && !buff(Guard) && health <= 80 && chi >= 2", "player"},
	{"Purifying Brew", "spell.ready && chi >=1 && player.buff(Heavy Stagger)", "player"},
	{"Purifying Brew", "spell.ready && chi >=1 && player.buff(Moderate Stagger) && health <= 75", "player"},
	{"Summon Black Ox Statue", "spell.ready && player.area_range(10).combatenemies >= 2", "player.ground"},
	{"Detox", "spell.ready && player.energy >= 30 && debuff(Disease || Poison).type", "player"},
	{"Nimble Brew", "spell.ready && player.state(root || stun || dazed || fear || horrified)", "player"},
	{"Elusive Brew", "spell.ready && && player.buff(Elusive Brew).stack >= 10 && health <= 80 && !target.ttd <= 1"},
	{"Ring of Peace", "spell.ready && player.area_range(8).combatenemies >= 3", "player"},
	--{"Blood Fury", "spell.ready && target.health <= 97 && target.boss", "player" },
	
	
	--INTERRUPT/DISPEL
	{{
    {"Paralysis", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "enemiesCombat"},
	}, "spell(Paralysis).ready"},
	{{
    {"Spear Hand Strike", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "nearEnemyCb"},
	}, "spell(Spear Hand Strike).ready"},
	
	--TAUNT
	{"Provoke", "spell.ready && range(2) <= 40 && threat <= 80", "bestCandidateForAggro(Provoke)"},

	--AOE
	{"Dizzying Haze", "spell.ready && player.energy >= 30 && player.area_range(10).combatenemies >= 1 && !target.debuff(Dizzying Haze) && !target.boss", "target.ground"},
	{"Breath of Fire", "spell.ready && player.chi >= 2 && player.area_range(10).enemies >= 1 && target.debuff(Dizzying Haze) && !debuff", "nearEnemyCb"},
	{"Keg Smash", "spell.ready && inmelee && player.energy >= 50 && player.chi <= 2 && player.area_range(8).combatenemies.infront >= 3", "nearEnemyCb"},
	{"Spinning Crane Kick", "spell.ready && energy >= 80 && player.area_range(8).combatenemies >= 3", "player"},
	
	--SPAM
	{"Touch of Death", "spell.ready && inmelee && player.chi >= 3 && player.buff(Death Note)", "target"},
	{"Tiger Palm", "spell.ready && inmelee && player.buff(Tiger Power).duration <= 3", "target"},
	{"Tiger Palm", "spell.ready && inmelee && spell.proc", "target"},
	{"Blackout Kick", "spell.ready && inmelee && {spell.proc || player.chi >= 3}", "target"},
	{"Jab", "spell.ready && inmelee && player.energy >= 40 && player.chi <= 3", "target"},
	
	
}


local outCombat = {
	{"Legacy of the Emperor", "spell.ready && !buff(Legacy of the Emperor || Blessing of Kings || Mark of the Wild || Embrace of the Shale Spider).any", "player"},
	{"Stance of the Fierce Tiger", "spell.ready && !buff", "player"},
	
}

_A.CR:Add(268, {
    name = "BREWMASTAH",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})