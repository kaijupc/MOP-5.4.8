local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
    --------------------------------
    {"Mark of the Wild", "spell.ready && !buff", "player"},
	--{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health < 40", "player"},
	{"Healing Touch", "spell.ready && buff(Dream of Cenarius) && player.health <= 100", "player"},
    ---------------
    {"Bear Form", "spell.ready && !buff", "player"},
    --{"Growl", "spell.ready && && range(2) <= 30 && threat < 80", "bestCandidateForAggro(Growl)"},
	{"Berserk", "spell.ready && inmelee && target.boss", "target"},
    ---------------
	{"Savage Defense", "spell.ready && rage >= 60 && !player.buff(Savage Defense)", "player"},
    --{"Savage Defense", "spell.ready && !buff && rage == 60", "player"},--ORIGINAL
    --{"Frenzied Regeneration", "spell.ready && health < 50 && rage == 100 && !buff", "player"},
    {"Barkskin", "spell.ready && health < 80", "player"},
    {"Survival Instincts", "spell.ready && health < 30", "player"},
    {"Might of Ursoc", "spell.ready && health < 50", "player"},
	{"Enrage", "spell.ready && rage < 20", "player"},
    ---------------
    {"Skull Bash", "spell.ready && target.interruptible", "target"},
	{"Mighty Bash", "spell.ready && target.interruptible && spell(Skull Bash).cooldown", "target"},
    ---------------
	{"Faerie Fire", "spell.ready && range(2) <= 35 && !target.debuff(Weakened Armor)", "target"},
	{"Mangle", "spell.ready && range(1)", "target"},
	{"Lacerate", "spell.ready && range(1)", "target"},
    {"Thrash", "spell.ready && range(1) && !debuff", "nearEnemyCb"},
    {"Swipe", "spell.ready && player.area_range(8).enemies >= 1", "target"},
	{"Maul", "spell.ready && range(1) && player.buff(Tooth and Claw)", "target"},
}

local outCombat = {
	{"Mark of the Wild", "spell.ready && !buff", "player"},
}

_A.CR:Add(104, {
    name = "GUARDIAN",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})