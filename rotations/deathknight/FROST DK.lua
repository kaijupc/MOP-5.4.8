local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {

	{"%pause", "lost.control"},
	{"!%pause", "dbm(stop cast)<=0.5"},
	
	{{
    {"%target", "inmelee", "nearEnemyCb"},
	}, "!target.exists || target.dead"},
	
	{"/cleartarget [dead][help]", "target.dead"},
	
	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"Death Strike", "spell.ready && inmelee && player.health <= 50", "target"},

    
	--BUFFS
	{"Horn of Winter", "spell.ready && runicpower <=85", "player"},
	{"Pillar of Frost", "spell.ready && target.ttd >= 10 && {player.area(10).combatenemies >= 3 || boss.health <= 97}", "player"},
	{"Blood Fury", "spell.ready && inmelee && target.health <97 && target.boss", "player"},
	{"Icebound Fortitude", "spell.ready && health <= 40", "player"},
	{"Anti-Magic Shell", "spell.ready && incdmg.magic(2) >=2000", "player"},
	{"Raise Dead", "spell.ready && !haveghoul && target.boss && target.health <= 97", "player"},
	{"Death Pact", "spell.ready && haveghoul && health <=50", "player"},
	{"Plague Leech", "spell.ready && spell.range && debuff(Blood Plague) && debuff(Frost Fever) && runes <= 1", "target"},
	{"Empower Rune Weapon", "spell.ready && runes <= 1 && target.ttd >= 20 && target.boss", "player"},
	{"Frost Presence", "spell.ready && !buff", "player"},
	
	
	--INTERRUPT
	{{
    {"Mind Freeze", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "enemiesCombat"},
	}, "spell(Mind Freeze).ready"},
	{{
    {"Strangulate", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "enemiesCombat"},
	}, "spell(Strangulate).ready"},
	
	--AOE
	{"Death and Decay", "spell.ready && range(2) <= 30 && player.area_range(10).combatenemies >= 3 && !target.ttd <= 2 && {rune(Blood).count >= 1 || rune(Death).count > 1}", "target.ground"},
	{"Blood Boil", "spell.ready && player.area_range(10).combatenemies >= 3 && !ttd <= 2 && {rune(Blood).count >= 1 || rune(Death).count > 1}",  "nearEnemyCb"},
	{"Pestilence", "spell.ready && inmelee && player.area_range(10).combatenemies >= 3 && debuff(Frost Fever) && debuff(Blood Plague) && !ttd <=5 && {rune(Blood).count >= 1 || rune(Death).count > 1}",  "target"},
	
    --SPAM
	
	{"Obliterate", "spell.ready && inmelee", "target"},
	{"Soul Reaper", "spell.ready && inmelee && target.health <= 35", "target"},
	{"Outbreak", "spell.ready && spell.range && !debuff(Blood Plague) && !debuff(Frost Fever) && !ttd <= 2", "target"},
	{"Howling Blast", "spell.ready && range(2) <= 30 && spell.proc", "target"},
	{"Plague Strike", "spell.ready && inmelee && debuff(Blood Plague).duration <= 5 && {rune(Unholy).count > 1 || rune(Death).count > 1", "target"},
	{"Howling Blast", "spell.ready && range(2) <= 30 && {rune(Frost).count >1 || rune(Death).count >1}", "target"},
	{"Frost Strike", "spell.ready && inmelee && player.runicpower >=30 && {!player.buff(Killing Machine) || !spell(Obliterate).cd<3}", "target"},
	{"Blood Tap", "spell.ready && player.buff(Blood Charge).count >= 5 && spell.cd == 0 && runes <= 3", "player"},
	
	
	
}

local outCombat = {
	{"Unholy Presence", "spell.ready && !buff", "player"},
	
}


_A.CR:Add(251, {
    name = "FROSTY",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})