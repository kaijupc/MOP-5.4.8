local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local function stopcast(nTimes)
    for i=1,nTimes do
        _A.SpellStopCasting()
    end
end

local inCombat = {
	{"!%pause", "dbm(stop cast)<=0.5"},
	{"/cleartarget [dead][help]", "target.dead"},
	
	{"%pause", "lost.control"},
	{stopcast(2), "player.iscastingany && {target.dead || !target.exists}"},
	
	--POTS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	
	--BUFFS
	{"Cleanse Spirit", "spell.ready && range(2) <=40 && delay(Cleanse, 1) && debuff(Curse || Magic).type", "player"},
	{"Cleanse Spirit", "spell.ready && range(2) <=40 && delay(Cleanse, 1) && debuff(Curse || Magic).type", "tank1"},
	--{"Bloodlust", "spell.ready && !buff(32182 || 90355 || 80353 || 2825 || 146555).any && target.boss && target.health <= 95", "player"},
	{"Earth Shield", "spell.ready && exists && spell.range && !buff", "TANK"},
	{"Ascendance", "spell.ready && boss && player.health <= 60 && ", "TANK"},
	
	--INTERRUPT/DISPEL
	{{
    {"Wind Shear", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(20) && !ttd <2", "enemiesCombat"},
	}, "spell(Wind Shear).ready"},
	{"Purge", "spell.ready && range(2) <=30 && delay(Purge, 1)", "healthierEnemyBuffType(Magic)"},
	
	--TOTEMS
	{"Tremor Totem", "spell.ready && !buff && player.state(fear || charm || sleep)", "player"},
	{"Grounding Totem", "spell.ready && isCastingOnMe && casting.length>=1 && casting.remaining<=0.5", "enemies"},
	{"Stormlash Totem", "spell.ready && !buff && boss && boss.health <= 97", "player"},
	--{"Stormlash Totem", "spell.ready && boss && player.buff(32182 || 90355 || 80353 || 2825 || 146555).any", "player"},
	{"Windwalk Totem", "spell.ready && !buff && {player.state(root) || dazed}", "player"},
	{"Mana Tide Totem", "spell.ready && !buff && boss && player.mana <= 75", "player"},
	{"Healing Tide Totem", "spell.ready && !buff && boss && health <= 70", "lowest"},
	{"Capacitor Totem", "spell.ready player.area_range(8).combatenemies >= 3", "player"},
	{"Healing Stream Totem", "spell.ready && !buff && health <= 90", "lowest"},
	
	--HEALS
	{"Healing Surge", "spell.ready && range(2) <= 40 && health <= 40", "lowest"},
	{"Riptide", "spell.ready && range(2) <= 40 && !buff && health <= 90", "TANK"},
	{"Riptide", "spell.ready && range(2) <= 40 && !buff && health <= 90", "lowest"},
	{"Healing Wave", "spell.ready && range(2) <= 40 && health <= 85", "lowest"},
	
	
}

local outCombat = {
	{"Water Shield", "spell.ready && !buff", "player"},
	{"Earthliving Weapon", "spell.ready && !enchanted.mainhand"},
	{"Earth Shield", "spell.ready && exists && spell.range && !buff", "TANK"},
	{"Riptide", "spell.ready && range(2) <= 40 && health <95", "TANK"},
	
}	


_A.CR:Add(264, {
    name = "RESTO",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})
