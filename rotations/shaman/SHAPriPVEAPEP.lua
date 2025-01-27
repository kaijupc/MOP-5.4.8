local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    {"Angelic Feather", "spell.ready && keybind(F1) && !buff", "player.ground"},
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Silence", "spell.ready && interruptible", "target"},
    {"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health < 30", "player"},
    ---------------
    {"Devouring Plague", "spell.ready && player.shadoworbs == 3", "target"},
    {"Shadow Word: Death", "spell.ready", "target"},
    {"Mind Blast", "spell.ready && !player.moving", "target"},
    {"Shadow Word: Pain", "spell.ready && !debuff || debuff.duration < 3", "target"},
    {"Vampiric Touch", "spell.ready && !player.moving && !debuff", "target"},
    {"Mind Flay", "spell.ready && !player.moving", "target"},
}

local outCombat = {
    {"Angelic Feather", "spell.ready && keybind(F1) && !buff", "player.ground"},
    {"Power Word: Fortitude", "spell.ready && !buff", "player"},
    {"Inner Fire", "spell.ready && !buff", "player"},
    {"Shadowform", "spell.ready && !buff", "player"},
    {"Shadow Word: Pain", "spell.ready && combat", "target"},
	
	
--{"Chain Heal", "exists", "heal_dist_radius_min_avghp(40, 15, 3, 75, 95)"}, "spell(Chain Heal).ready && player.mana >= 50"},
 
-- 40 ----> distance of the spell
-- 15 -----> the radius of the spell
-- 3 ------> min group size
-- 75 -----> Average Health
-- 95 -----> The individual health threshold for players to be considered for healing.
	
}

_A.CR:Add(258, {
	name = "Shadow Priest PVE",
	ic = inCombat,
    ooc = outCombat,
	wow_ver = "5.4.8",
	apep_ver = "1.1",
})