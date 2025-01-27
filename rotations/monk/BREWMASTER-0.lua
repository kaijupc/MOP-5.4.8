local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"Legacy of the Emperor", "spell.ready && !buff", "player"},
	--------------------------------
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
	{"/startattack", "inmelee && !auto.attack", "target"},
    --------------------------------
	{"Healthstone", "item.usable && player.hp < 30", "player"},
	{"Diffuse Magic", "spell.ready && incdmg.magic(2) > 1000", "player" },
	{"Guard", "spell.ready && health <= 80 && chi >= 2 && health < 85", "player"},
	--{"Fortifying Brew", "spell.ready && player.area_range(8).enemies >= 1", "player"},
	{"&Fortifying Brew", "spell.ready && stance == 1 && spell.cooldown<=gcd && health <= 50 && player.area_range(8).enemies >= 1", "player"},
	{"Purifying Brew", "spell.ready && health < 50 && chi >= 1", "player"},
	{"Summon Black Ox Statue", "spell.ready && range(2) && isparty && target.health < 90", "target.ground"},
	--------------------------------
	--{"Storm, Earth, and Fire", "spell.ready && range(2) <= 40 && player.area_range(8).enemies >= 5", "target"}, --WW
	--------------------------------
	{"Spear Hand Strike", "spell.ready && range(1) && interruptible", "nearEnemyCb"},
	--------------------------------
	{"Provoke", "spell.ready && range(2) <= 40 && threat < 80", "bestCandidateForAggro(Provoke)"},
	--------------------------------
	{"Nimble Brew", "spell.ready && lost.control", "player"},
	--------------------------------
	{"Elusive Brew", "spell.ready && variables.ElusiveBrewStacks >= 10 && player.area_range(2).enemies >= 2", "player"},
	{"Blood Fury", "spell.ready && target.health < 98 && target.boss", "player" },
	--------------------------------
	{"Touch of Death", "spell.ready && range(1) && player.chi >= 3 && player.buff(Death Note)", "target"},
	{"Expel Harm", "spell.ready && range(1) && health <= 80 && energy > 40", "player"},
	{"Chi Wave", "spell.ready && range(2) <= 40", "nearEnemyCb"},
	{"Ring of Peace", "spell.ready && energy <= 90", "player"},
	{"Tiger Palm", "spell.ready && range(1) && player.buff(Tiger Power).duration < 4", "target"},
	{"Breath of Fire", "spell.ready range(1) && player.chi >= 3 && player.area_range(5).enemies >= 3", "target"},
	{"Blackout Kick", "spell.ready && range(1) && player.chi >= 3", "target"},
	{"Rushing Jade Wind", "spell.ready && range(1) && energy > 60 && player.area_range(5).enemies >= 3", "player"},
	{"Keg Smash", "spell.ready && range(1) && player.energy > 50 && !player.chi == 4", "target"},
	{"Jab", "spell.ready && range(1) && player.energy > 50 && !player.chi == 5", "target"},
	{"Detox", "spell.ready && player.energy > 30 && debuff(Disease).type", "player"},
	{"Detox", "spell.ready && player.energy > 30 && debuff(Poison).type", "player"},
	
	--{"Tiger Palm", "spell.ready && range(1) && player.buff(Tiger Power).duration < 4 && player.chi >= 1", "target"},--WW
	--{"Blackout Kick", "spell.ready && range(1) && player.buff(Combo Breaker)", "target"}, --WW
	--{"Tiger Palm", "spell.ready && range(1) && player.buff(Tiger Power).duration < 3 && player.buff(Combo Breaker)", "target"},--WW
	--{"Rising Sun Kick", "spell.ready && range(1) && player.chi >= 2", "target"}, --WW
	--{"Touch of Death", "spell.ready && range(1) && player.chi >= 3", "target"},
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

_A.CR:Add(268, {
    name = "BREWMASTER",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})