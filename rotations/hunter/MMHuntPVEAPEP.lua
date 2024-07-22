local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Silencing Shot", "spell.ready && spell.range && interruptible", "nearEnemyCb"},
    {"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health < 40", "player"},
    ---------------
    {"Heart of the Phoenix", "spell.ready && pet.dead", "pet"},
    {"Revive Pet", "spell.ready && pet.dead", "pet"},
    {"Mend Pet", "spell.ready && spell.range && pet.health < 80 && !pet.buff", "pet"},
    ---------------
    {"Rapid Fire", "spell.ready && spell.range && target.boss", "target"},
    {"Stampede", "spell.ready && spell.range && target.boss", "target"},
    {"Fervor", "spell.ready && spell.range && target.boss", "target"},
    {"A Murder of Crows", "spell.ready && spell.range && target.boss", "target"},
    {"Glaive Toss", "spell.ready && spell.range && target.boss", "target"},
    ---------------
    {"Serpent Sting", "spell.ready && spell.range && !debuff && area_range(8).enemies <= 2", "target"},
    {"Steady Shot", "spell.ready && spell.range && !player.buff(Steady Focus)", "target"},
    {"Chimera Shot", "spell.ready && spell.range && area_range(8).enemies <= 2", "target"},
    {"Aimed Shot", "player.buff(Fire!)", "target"},
    {"Kill Shot", "spell.ready && spell.range", "nearEnemyCb"},
    {"Multi-Shot", "spell.ready && spell.range && area_range(8).enemies >= 3", "target"},
    {"Steady Shot", "spell.ready && spell.range &&player.focus < 70", "target"},
    {"Arcane Shot", "spell.ready && spell.range", "target"},
}

_A.CR:Add(254, {
	name = "Marksmanship Hunter PVE",
	ic = inCombat,
	wow_ver = "5.4.8",
	apep_ver = "1.1",
})