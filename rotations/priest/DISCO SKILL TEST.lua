local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local player, target
local inCombat = {
-- Pause
    --{"%pause", "lost.control" },
    --{"%target", "!target.exists || target.dead", "nearEnemyCb"},
  
  -- Heals
	--{"/use Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health < 20", "player"},
	--{"Renew", "spell.ready && player.health <= 70 && !player.buff(Renew)", "lowest"},
	--{"Power Word: Shield", "spell.ready && player.health <= 30", "lowest"},
	--{"Prayer of Healing", "spell.ready && exists && !player.moving", "heal_dist_radius_min_avghp(40, 30, 4, 70, 95)"}

    {"Renew", "spell.ready && spell.range && health < 90 && !player.buff(Renew)", "roster"}, 
	{"Penance", "exists && spell.ready && spell.range && health<50", "roster"},
	{"Healthstone", "player.health < 20 && item.usable", "player"},
    --{"Mindbender", "spell.ready && spell.range && target.combat && player.mana < 80", "target"},
    {"Pain Suppression", "spell.ready && spell.range && tank.combat && tank.health < 30", "tank"},
    {"Power Word: Shield", "spell.ready && spell.range && tank.combat && !buff(Weakened Soul).any", "tank"},
    {"Archangel", "spell.ready && spell.range && buff(Evangelism).stack == 5", "player"},
    {"Purify", "spell.ready && spell.range && debuff(Disease || Magic).type", "roster"},
    --{"Penance", "spell.ready && spell.range", "target"},
    --{"Holy Fire", "spell.ready && spell.range", "target"},
    --{"Smite", "spell.ready && spell.range && !player.moving", "target"},
	
  -- Dps    
    --{"Smite", "spell.ready && spell.range", "nearEnemyCb"},
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