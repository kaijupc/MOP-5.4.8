local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local player, target
local inCombat = {

--{"Angelic Feather", "keybind(F1) && !buff", "player.ground"},
{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && player.health < 40", "player"},
{"%target", "!target.exists || target.dead", "nearEnemyCb"},
{"Silence", "spell.ready && spell.range && interruptible", "nearEnemyCb"},
{"Mindbender", "spell.ready && spell.range && target.combat && player.mana < 50", "target"},
{"Pain Suppression", "spell.ready && spell.range && tank.combat && tank.health < 30", "tank"},
---------------
{"Power Word: Shield", "spell.ready && spell.range && tank.combat && !buff(Weakened Soul).any", "tank"},
{"Renew", "spell.ready && spell.range && !buff && health < 70", "roster"}, 
{"Archangel", "spell.ready && spell.range && buff(Evangelism).stack == 5", "player"},
---------------
{"Purify", "spell.ready && spell.range && debuff(Disease || Magic).type", "roster"},
--{"Penance", "spell.ready && spell.range", "target"},
--{"Holy Fire", "spell.ready && spell.range", "target"},
--{"Smite", "spell.ready && spell.range && !player.moving", "target"},
}

local outCombat = {
   {"%pause", "player.iscastingany" },
   {"Power Word: Fortitude", "!player.buff(Power Word: Fortitude)" },
   {"Inner Fire", "!player.buff(Inner Fire)" },
}


_A.CR:Add(256, {
    name = "DISCO",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})