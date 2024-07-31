local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	--------------------------------
	{"Legacy of the Emperor", "spell.ready && !buff", "player"},
	--------------------------------
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
    --------------------------------
	{"Guard", "spell.ready && health <= 80 && chi >= 2 && health < 85", "player"},
	{"Fortifying Brew", "spell.ready && player.area_range(8).enemies >= 1", "player"},
	--------------------------------
	--{"Storm, Earth, and Fire", "spell.ready && range(2) <= 40 && player.area_range(8).enemies >= 5", "target"}, --WW
	--------------------------------
	{"Chi Wave", "spell.ready && range(2) <= 40", "nearEnemyCb"},
	{"Tiger Palm", "spell.ready && range(1) && player.buff(Tiger Power).duration < 3 && player.buff(Combo Breaker)", "target"},
	{"Blackout Kick", "spell.ready && range(1) && player.buff(Combo Breaker)", "target"},
	{"Expel Harm", "spell.ready && range(1) && health <= 70 && energy > 50", "player"},
	{"Rising Sun Kick", "spell.ready && range(1) && player.chi >= 2", "target"},
	{"Keg Smash", "spell.ready && range(1) && player.energy > 50 && !player.chi == 4", "target"},
	{"Breath of Fire", "spell.ready range(1) && player.chi >= 2 && target.debuff(Dizzying Haze)", "target"},
	{"Tiger Palm", "spell.ready && range(1) && player.buff(Tiger Power).duration < 3 && player.chi >= 1", "target"},
	{"Jab", "spell.ready && range(1) && player.energy > 50 && !player.chi == 4", "target"},
	{"Blackout Kick", "spell.ready && range(1) && player.chi >= 2", "target"},
	{"Remove Curse", "spell.ready && player.energy > 30 && debuff(Disease).type", "player"},
	{"Remove Curse", "spell.ready && player.energy > 30 && debuff(Poison).type", "player"},
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