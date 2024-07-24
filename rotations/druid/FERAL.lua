local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
	
    ------BUFFS & CONSUMABLES
	{"Mark of the Wild", "spell.ready && !buff", "player"},
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health < 40", "player"},
	
    ------STANCE
    {"Cat Form", "spell.ready && !buff", "player"},
	
    ------DEF.
    {"Healing Touch", "spell.ready && buff(Predatory Swiftness) && player.health < 70", "player"},
    {"Barkskin", "spell.ready && health < 60", "player"},
    {"Survival Instincts", "spell.ready && health < 35", "player"},
    {"Might of Ursoc", "spell.ready && health < 30", "player"},
	
	------INTERRUPT
	{"Skull Bash", "spell.ready && target.interruptible", "target"},
	
	------ENHANCEMENTS
	--{"Savage Roar", "spell.ready && target.combo >= 3 && player.buff(Savage Roar).duration < 3", "player"},
	--{"Tiger's Fury", "spell.ready && energy <= 20", "player"},
	{"Berserk", "spell.ready && inmelee && target.boss", "target"},
	
    ------DPS
	--{"Faerie Fire", "spell.ready && range(2) <= 35 && !target.debuff(Weakened Armor)", "target"},
	--{"Swipe", "spell.ready && energy >= 60 && player.area_range(8).enemies >= 3", "player"},
	--{"Rake", "spell.ready && inmelee && target.debuff(Rake).duration < 2", "target"},
	{"Rip", "spell.ready && inmelee && target.combo == 5 && target.debuff(Rip).duration < 3", "target"},
	--{"Ferocious Bite", "spell.ready && inmelee && combo=5", "target"},--ORIGINAL
	{"Ferocious Bite", "spell.ready && energy >= 50 && target.combo == 5 && !target.debuff(Rip).duration < 2", "target"},
	--{"Thrash", "spell.ready && energy >= 70 && !target.debuff(Weakened Blows)", "player"},
    --{"Mangle", "spell.ready && inmelee", "target"},
	--{"Shred", "spell.ready && player.behind && energy >= 60 && player.buff(Berserk)", "target"},
}

local outCombat = {}

_A.CR:Add(103, {
    name = "FERAL",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})