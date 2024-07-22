local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local player, target
local inCombat = {
{"%target", "!target.exists || target.dead", "nearEnemyCb"},
{"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
--------------------------------
{"Howling Blast", "spell.ready && spell.proc && spell(Obliterate).cd<2", "target"},
{"Plague Strike", "spell.ready && spell(Obliterate).cd>3}", "target"},
--{"Plague Strike", "spell.ready && player.runicpower>=30 && {!player.buff(Killing Machine) || spell(Obliterate).cd>2}", "target"},
}

local outCombat = {}

_A.CR:Add(251, {
    name = "DK SKILL TEST",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})