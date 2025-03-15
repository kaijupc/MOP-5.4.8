local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
	
    ------------POTS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	
	------------HEALS
	{"Lay on Hands", "spell.ready && health <=20 && !debuff(Forbearance)", "player"},
    {"Word of Glory", "spell.ready && health <=60 && holy.power >=3", "lowest"},
	{"Flash of Light", "spell.ready && buff(Selfless Healer).stack >=3 && health <=60", "lowest"},
	
	------------BUFFS
	{"Inquisition", "spell.ready && player.holy.power >= 3 && !buff || buff.duration <=5", "player"},
	{"Divine Protection", "spell.ready && incdmg.magic(1) >=2000", "player"},
	{"Hand of Freedom", "spell.ready && !player.buff(Hand of Freedom) && player.state(root || snare)", "player"},
	{"Emancipate", "spell.ready && !player.buff(Hand of Freedom) && player.state(root || snare)", "player"},
	
	------------INTERRUPT
	{"Rebuke", "spell.ready && inmelee && target.interruptible", "target"},
	{"Fist of Justice", "spell.ready && range(2) && target.interruptible", "enemies"},
	{"Arcane Torrent", "spell.ready && interruptible && player.area_range(8).enemies >=4", "enemies"},
	
    ------------SEALS
	{"Seal of Truth", "spell.ready && stance != 1 && area_range(8).enemies <=2", "target"},
    {"Seal of Righteousness", "spell.ready && stance != 2 && area_range(8).enemies >=3", "target"},
	
	------------AOE
	{"Divine Storm", "spell.ready && player.holy.power >=3 && player.area_range(8).enemies >=3", "target"},
	{"Hammer of the Righteous", "spell.ready && player.area_range(8).enemies >= 2", "target"},
	
	------------SPAM
	{"Hammer of Wrath", "spell.ready && spell.range && health <=20", "target"},
	{"Templar's Verdict", "spell.ready && inmelee && {player.holy.power >= 3 || spell.proc}", "target"},
	{"Exorcism", "spell.ready && range(2)", "target"},
	{"Execution Sentence", "exists && spell.ready", "target"},
	{"Judgment", "spell.ready && spell.range", "target"}, 
    {"Crusader Strike", "spell.ready && inmelee", "target"},
}

local outCombat = {
	{"Blessing of Kings", "spell.ready && !buff", "player"},
}
	

_A.CR:Add(70, {
    name = "RET",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})