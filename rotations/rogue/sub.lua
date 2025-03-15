local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
 
local inCombat = {

	{{
    {"%target", "inmelee", "nearEnemyCb"},
	}, "!target.exists || target.dead"},
	{"/cleartarget [dead][help]", "target.dead"},
	
	------
	{"Premeditation", "spell.ready && range(2) <= 30 && player.buff(Stealth) && boss || classification(worldboss)", "enemies"},

    --POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <40", "player"},
	
	--BUFFS
	{"Feint", "spell.ready && energy >=30 && incdmg(1)>=health.max*0.4", "player"},
	{"Cloak of Shadows", "spell.ready && incdmg.magic(2) >= 1000", "player"},
	--{"Slice and Dice", "spell.ready && inmelee && player.energy >= 25 && combo==5 && player.buff(Slice and Dice).duration <= 4", "nearEnemyCb"},
	{"Slice and Dice", "inmelee && player.buff(Slice and Dice).duration <= 4 && combo==5 && timeout(SandD,0.25)"},
	
	

	--INTERRUPT/DISPEL
	{{
    {"Kick", "iscasting.any.spell && spell.range && infront && interruptible && casting.length>=1 && interruptAt(50) && !ttd <2", "nearEnemyCb"},
	}, "spell(kick).ready"},
	{{
    {"Gouge", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(30) && !ttd <2", "nearEnemyCb"},
	}, "spell(Gouge).ready"},
	{{
    {"Blind", "iscasting.any.spell && range(2) <= 15 && interruptible && casting.length>=1 && interruptAt(70) && !ttd <2", "enemiesCombat"},
	}, "spell(Blind).ready"},
	
	--AOE
	{"Crimson Tempest", "spell.ready && inmelee && player.energy >= 35 && combo >= 4 && !debuff && player.area_range(8).enemies >= 3", "nearEnemyCb"},
	{"Fan of Knives", "spell.ready && player.energy >= 35 && player.area_range(8).enemies >= 4 && !combo==5 && !isStealthed", "nearEnemyCb"},
	
	--SPAM
	{"Ambush", "spell.ready && inmelee && behind && player.buff(Stealth || Shadow Dance) && !combo==5", "target"},
	{"Shiv", "spell.ready && inmelee && target.buff(Enrage)", "nearEnemyCb"},
	{"Rupture", "spell.ready && inmelee && player.energy >= 25 && combo==5 && debuff(Rupture).duration <= 4 && boss", "target"},
	{"Eviscerate", "spell.ready && inmelee && player.energy >= 35 && combo==5", "target"},
	{"Backstab", "spell.ready && behind && inmelee && player.energy >= 40 && !combo==5 && !player.buff(Stealth)", "target"},
	{"Hemorrhage", "spell.ready && inmelee && player.energy >= 35 && infront && !combo==5 && debuff.duration <= 5 && !player.buff(Stealth)", "target"},
	--{"Hemorrhage", "spell.ready && inmelee && player.energy >= 35 && infront && !combo==5 && !boss && !player.buff(Shadow Walk || Stealth)", "target"},

	
}

	
local outCombat = {
	{"Stealth", "spell.ready && !buff", "player"},
	{"Premeditation", "spell.ready && range(2) <= 30 && isStealthed && boss || classification(worldboss)", "enemies"},
	{"Ambush", "spell.ready && behind && spell.range && isStealthed && enemy", "target"},
	{"Deadly Poison", "spell.ready && !buff", "player"},
	{"Recuperate", "spell.ready && !buff && player.area_range(30).combatenemies >= 1 && !isStealthed && health <= 50", "player"},
	--{"Slice and Dice", "spell.ready && inmelee && player.combo <= 5 && player.buff(Slice and Dice).duration <= 30", "nearEnemyCb"},
	{"Slice and Dice", "spell.ready && inmelee && timeout(SandD,0.25)"},
	
}
	
_A.CR:Add(261, {
    name = "SUB",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})