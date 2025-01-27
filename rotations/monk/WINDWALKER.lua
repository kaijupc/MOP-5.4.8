local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"Legacy of the Emperor", "spell.ready && !buff", "player"},
	--------------------------------
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
	{"/startattack", "inmelee && !auto.attack", "target"},
    --------------------------------
	{"Healthstone", "item.usable && player.hp < 30", "player"},
	{"Diffuse Magic", "spell.ready && incdmg.magic(2) > 20000", "player" },
	{"Fortifying Brew", "spell.ready && health <= 50", "player"},
	{"Energizing Brew", "spell.ready && energy < 30", "player"},
	{"Invoke Xuen, the White Tiger", "spell.ready && target.health < 98 && target.boss", "target"},
	--------------------------------
	{"Spear Hand Strike", "spell.ready && range(1) && interruptible", "nearEnemyCb"},
	--------------------------------
	{"Nimble Brew", "spell.ready && lost.control", "player" },
	--------------------------------
	{"Tigereye Brew", "spell.ready && variables.TigerBrewStacks >= 10 && target.health < 98 && target.boss", "player"},
	{"Blood Fury", "spell.ready && target.health < 98 && target.boss", "player" },
	--------------------------------
	{"Tiger Palm", "spell.ready && range(1) && player.buff(Combo Breaker)", "target"},
	{"Tiger Palm", "spell.ready && range(1) && player.buff(Tiger Power).duration < 3 && player.chi >= 1", "target"},
	{"Blackout Kick", "spell.ready && range(1) && player.buff(Combo Breaker)", "target"},
	{"Chi Wave", "spell.ready && range(2) <= 40", "nearEnemyCb"},
	{"Spinning Crane Kick", "spell.ready && range(1) && energy > 60 && player.area_range(2).enemies >= 3", "player"},
	{"Spinning Fire Blossom", "spell.ready range(2) <= 40 && player.chi >= 2 && player.area_range(40).enemies >= 5", "target"},
	{"Touch of Death", "spell.ready && range(1) && player.chi >= 3 && player.buff(Death Note)", "target"},
	{"Rising Sun Kick", "spell.ready && range(1) && player.chi >= 2", "target"},
	{"Expel Harm", "spell.ready && range(1) && health < 90 && energy > 40", "player"},
	{"Storm, Earth, and Fire", "spell.ready && range(2) <= 40 && player.energy > 20 && player.area_range(20).enemies >= 5", "target"},
	{"Blackout Kick", "spell.ready && range(1) && player.chi >= 3", "target"},
	{"Ring of Peace", "spell.ready && player.area_range(8).enemies >= 5", "player"},
	{"Jab", "spell.ready && range(1) && player.energy > 50 && !player.chi == 5", "target"},
	{"Detox", "spell.ready && player.energy > 30 && debuff(Disease).type", "player"},
	{"Detox", "spell.ready && player.energy > 30 && debuff(Poison).type", "player"},
	

	
}

local outCombat = {
	{"Legacy of the Emperor", "spell.ready && !buff", "player"},
}

--{"Chi Burst", "spell.ready && area(40, 80).heal.infront > 2 && inConeOf(player, 90)", "roster"},
--{"Summon Jade Serpent Statue", "stance == 1", "player.ground"}
--{"Tiger Palm", "stance == 1 && enemy && infront && range < 4 && los && !player.buff(Thunder Focus Tea) && !player.buff(Tiger Power)", "target"},
--{"Blackout Kick", "player.chi >= 2 && stance == 1 && enemy && infront && range < 4 && los && !player.buff(Thunder Focus Tea)", "target"}

--268 Brewmaster
--269 Windwalker
--270 Mistweaver

_A.CR:Add(269, {
    name = "WINDWALKER",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})