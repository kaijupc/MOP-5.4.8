local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"!%pause", "dbm(stop cast)<=0.5"},
	{{
    {"%target", "range(2) <= 40", "nearEnemyCb"},
	}, "!target.exists || target.dead"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
	{"/cleartarget [dead][help]", "target.dead"},

	{"Legacy of the Emperor", "spell.ready && !buff(Legacy of the Emperor || Blessing of Kings || Mark of the Wild || Embrace of the Shale Spider).any", "player"},
    --------------------------------
	{"Healthstone", "item.usable && player.hp < 30", "player"},
	{"Diffuse Magic", "spell.ready && incdmg.magic(2) > 20000", "player" },
	{"Fortifying Brew", "spell.ready && health <= 50", "player"},
	{"Energizing Brew", "spell.ready && energy < 30", "player"},
	{"Invoke Xuen, the White Tiger", "spell.ready && target.health < 98 && target.boss", "target"},
	--------------------------------
	{"Spear Hand Strike", "spell.ready && range(1) && interruptible", "nearEnemyCb"},
	--------------------------------
	--{"Nimble Brew", "spell.ready && lost.control", "player" },
	{"Nimble Brew", "spell.ready && player.state(root || stun || dazed || fear || horrified)", "player"},
	--------------------------------
	{"Tigereye Brew", "spell.ready && variables.TigerBrewStacks >= 10 && target.health < 98 && target.boss", "player"},
	{"Blood Fury", "spell.ready && target.health < 98 && target.boss", "player" },
	--------------------------------
	{"Tiger Palm", "spell.ready && range(1) && player.buff(Combo Breaker)", "target"},
	{"Tiger Palm", "spell.ready && range(1) && player.buff(Tiger Power).duration < 3 && player.chi >= 1", "target"},
	{"Blackout Kick", "spell.ready && range(1) && player.buff(Combo Breaker)", "target"},
	{"Chi Wave", "spell.ready && range(2) <= 40", "enemiesCombat"},
	{"Spinning Crane Kick", "spell.ready && range(1) && energy > 60 && player.area_range(2).enemies >= 3", "player"},
	{"Spinning Fire Blossom", "spell.ready range(2) <= 40 && player.chi >= 2 && player.area_range(40).enemies >= 5", "target"},
	{"Touch of Death", "spell.ready && range(1) && player.chi >= 3 && player.buff(Death Note)", "target"},
	{"Rising Sun Kick", "spell.ready && range(1) && player.chi >= 2", "target"},
	{"Expel Harm", "spell.ready && range(1) && health < 90 && energy > 40", "player"},
	--{"Storm, Earth, and Fire", "spell.ready && range(2) <= 40 && player.energy > 20 && player.area_range(20).enemies >= 5", "target"},
	{"Blackout Kick", "spell.ready && range(1) && player.chi >= 3", "target"},
	{"Ring of Peace", "spell.ready && player.area_range(8).enemies >= 5", "player"},
	{"Jab", "spell.ready && range(1) && player.energy > 50 && !player.chi == 5", "target"},
	--{"Detox", "spell.ready && player.energy > 30 && debuff(Disease).type", "player"},
	--{"Detox", "spell.ready && player.energy > 30 && debuff(Poison).type", "player"},
	{"Detox", "spell.ready && player.energy >= 30 && debuff(Disease || Poison).type", "player"},
	

	
}

local outCombat = {
	{"Legacy of the Emperor", "spell.ready && !buff(Legacy of the Emperor || Blessing of Kings || Mark of the Wild || Embrace of the Shale Spider).any", "player"},
	{"Stance of the Fierce Tiger", "spell.ready && !buff", "player"},
	
}

_A.CR:Add(269, {
    name = "WINDWALKAH",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})