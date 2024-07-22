local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"Water Shield", "!player.buff", "player"},
	{"Earthliving Weapon", "!hasMainHandEnchant", "player"},
	---------------------------
	{"Mana Tide Totem", "spell.ready && !buff(Mana Spring Totem) && player.mana < 75", "player"},
	{"Stormlash Totem", "spell.ready && spell.range && hashero", "player"},
	{"Healing Tide Totem", "spell.ready && buff(Ascendance)", "player"},
	{"Healing Stream Totem", "spell.ready && health < 95", "lowest"},
	---------------------------
	{"Ascendance", "spell.ready && group.health < 50", "lowest"},
	{"Chain Heal", "spell.ready && range(2) <= 40 && player.buff(Ascendance)", "heal_dist_radius_min_avghp(40, 10, 3, 100)"},
	{"Blood Fury", "spell.ready && group.health < 80", "player"},
	---------------------------
	{"Earth Shield", "spell.ready && range(2) <= 40 && !buff && health < 100", "tank1 || tank2"},
	{{{"Healing Rain", nil, "heal_dist_radius_min_avghp(40, 10, 3, 100).ground"},}, "spell(Healing Rain).ready" },
	{"Chain Heal", "spell.ready && range(2) <= 40 && {!player.ismoving || player.buff(Spiritwalker's Grace)}", "heal_dist_radius_min_avghp(40, 10, 2, 80)"},
	{"Wind Shear", "spell.ready && range(2) <= 40 && target.interruptible", "nearEnemyCb"},
	{"Riptide", "spell.ready && range(2) <= 40 && !buff && health < 100", "tank1 || tank2"},
	{"Riptide", "spell.ready && range(2) <= 40 && !buff && health < 90", "lowest"},
	{"Healing Wave", "spell.ready && range(2) <= 40 && health < 80 && {!player.ismoving || player.buff(Spiritwalker's Grace)} && player.buff(Tidal Waves)", "lowest"},
	{"Greater Healing Wave", "spell.ready && player.lastcast(Ancestral Swiftness)", "lasttarget"},
	{{{"Ancestral Swiftness", "range(2) <= 40 && health < 50", "lowest"},}, "spell(Ancestral Swiftness).ready && spell(Greater Healing Wave).ready"},
	{"Healing Wave", "spell.ready && range(2) <= 40 && health < 80", "lowest"},
	{"Lightning Bolt", "spell.ready && range(2) <= 40", "target"},
}

local outCombat = {
	{"Water Shield", "!player.buff", "player"},
	{"Earthliving Weapon", "!hasMainHandEnchant", "player"},
}

_A.CR:Add(264, {
	name = "Restoration Shaman PVE",
	ic = inCombat,
	ooc = outCombat,
	wow_ver = "5.4.8",
	apep_ver = "1.1",

})