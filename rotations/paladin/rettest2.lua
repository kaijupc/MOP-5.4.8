local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"Templar's Verdict", "spell.ready && {player.holy.power >= 3 || spell.proc}", "target"},
	{"Exorcism", "exists && spell.ready", "target"},
	{"Judgment", "spell.cooldown<0.3 && spell.range && exists", "target"}, 
    {"Crusader Strike", "exists && spell.ready && player.area_range(8).enemies <= 2", "target"}, 
}

local outCombat = {}

_A.CR:Add(70, {
    name = "RETPAL SKILL TEST",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})