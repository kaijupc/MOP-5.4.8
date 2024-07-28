local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
    --------------------------------
    {"Lay on Hands", "spell.ready && player.health <= 20", "player"},
    {"Word of Glory", "exists && spell.ready && player.health <= 50 && holy.power >= 2 && holy.power <= 3", "target"},
    {"Flash of Light", "spell.ready && player.buff(Selfless Healer).stack >= 3 && player.health <= 70", "player"},
    --------------------------------
    {"Seal of Truth", "exists && spell.ready && stance != 1 && player.area_range(8).enemies <= 3", "target"},
    {"Seal of Righteousness", "exists && spell.ready && stance != 2 && player.area_range(8).enemies >= 4", "target"},
	--------------------------------
	{"Rebuke", "spell.ready && inmelee && target.interruptible", "target"},
	{"Fist of Justice", "spell.ready && spell.range && target.interruptible && spell(Rebuke).cooldown", "target"},
    --------------------------------
	{"Divine Storm", "exists && spell.ready && player.area_range(8).enemies >= 3", "target"}, -- 3 or more
	{"Templar's Verdict", "spell.ready && {player.holy.power >= 3 || spell.proc}", "target"},
    {"Inquisition", "spell.ready && player.holy.power >= 3 && !buff || buff.duration <=5", "player"},
	{"Exorcism", "spell.ready && spell.range", "target"},
    {"Execution Sentence", "exists && spell.ready", "target"},
    {"Hammer of Wrath", "exists && spell.ready", "target"},
    {"Hammer of the Righteous", "exists && spell.ready && player.area_range(8).enemies >= 3", "target"}, -- 3 or more
	{"Judgment", "spell.cooldown<0.3 && spell.range && exists", "target"}, 
    {"Crusader Strike", "exists && spell.ready && player.area_range(8).enemies <= 2", "target"}, -- 2 or less
	{"Divine Protection", "exists && spell.ready", "target"},
}

local outCombat = {
	--{"Blessing of Kings", "spell.ready && !buff", "player"},
}
	

_A.CR:Add(70, {
    name = "Retribution Paladin",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})