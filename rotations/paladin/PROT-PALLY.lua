local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
	
    ------------POTS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	
	------------HEALS
	{"Eternal Flame", "spell.ready && health <=80 && player.holy.power >=3", "player"},
	{"Lay on Hands", "spell.ready && health <=20 && !debuff(Forbearance)", "player"},
    {"Word of Glory", "spell.ready && health <=60 && holy.power >=3", "lowest"},
	{"Flash of Light", "spell.ready && buff(Selfless Healer).stack >=3 && health <=60", "lowest"},
	
	------------BUFFS
	{"Divine Protection", "spell.ready && incdmg.magic(2) >=2000", "player"},
	{"Hand of Freedom", "spell.ready && !buff && player.state(root || dazed)", "player"},
	{"Emancipate", "spell.ready && !player.buff(Hand of Freedom) && player.state(root || snare)", "player"},
	
	------------INTERRUPT
	{"Rebuke", "spell.ready && range(1) && interruptible && player.area_range(8).enemies >=1", "nearEnemyCb"},
	{"Fist of Justice", "spell.ready && spell.range && interruptible", "target"},
	{"Arcane Torrent", "spell.ready && interruptible && player.area_range(8).enemies >=2", "enemies"},
	
	------------CLEANSE
	--{"Cleanse", "spell.ready && spell.range && to(Cleanse, 0.2)", "lowestDebuffType2(Magic)"},
	
	------------TAUNT
	{"Reckoning", "spell.ready && range(2) <=30 && threat<80", "bestCandidateForAggro(Reckoning)"},
	
	------------SEALS
	{"Seal of Truth", "spell.ready && stance != 1 && area_range(8).enemies <=2", "target"},
    {"Seal of Righteousness", "spell.ready && stance != 2 && area_range(8).enemies >=3", "target"},
	
	------------AOE
	{"Consecration", "spell.ready && player.area_range(8).enemies >=1", "target"},
	{"Avenger's Shield", "spell.ready && spell.range", "target"},
	{"Holy Wrath", "spell.ready && player.area_range(3).enemies >=1", "nearEnemyCb"},
	{"Hammer of the Righteous", "spell.ready && player.area_range(8).enemies >= 2", "nearEnemyCb"},
	
	------------SPAM
	{"Shield of the Righteous", "spell.ready && inmelee && player.health <=80 && player.holy.power >=3", "target"},
	{"Hammer of Wrath", "spell.ready && spell.range && health <=20", "target"},
	{"Judgment", "spell.ready && spell.range", "target"}, 
    {"Crusader Strike", "spell.ready && inmelee", "target"},

}

local outCombat = {
	{"Blessing of Kings", "spell.ready && !buff", "player"},
}
	

_A.CR:Add(66, {
    name = "PROT-PAL",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})