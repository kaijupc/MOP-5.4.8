local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local player, target
local inCombat = {
{"%target", "!target.exists || target.dead", "nearEnemyCb"},
{"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
--------------------------------
{"Obliterate", "spell.ready", "target"},
{"Soul Reaper", "spell.ready && target.health <= 35", "target"},
{"Horn of Winter", "spell.ready", "player"},
{"Pillar of Frost", "spell.ready && spell.cd <= 10", "player"},
{"Outbreak", "spell.ready", "target"},
{"Plague Leech", "spell.ready && spell.cooldown(Outbreak) < 2", "target"},--OK
{"Howling Blast", "player.buff(Freezing Fog)", "target"},
{"Frost Strike", "spell.ready && player.runicpower>=30 && {!player.buff(Killing Machine) || spell(Obliterate).cd>2}", "target"},
--{"Frost Strike", "spell.ready && player.runicpower>=30 && spell(Obliterate).cd >= 2", "target"},
{"Plague Strike", "spell.ready && 'rune.Death >= 1' && 'runic.power <= 20' ", "target"},
{"Blood Tap", "spell.ready && player.buff(Blood Charge).count >= 5 && spell.cd == 0", "player"},
{"Anti-Magic Shell", "target.casting && target.casting.spell.school == 'magic' && spell.ready", "player"},
}

local outCombat = {}

_A.CR:Add(251, {
    name = "Frost DK 1",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})