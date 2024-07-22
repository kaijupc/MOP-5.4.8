local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local player, target
local inCombat = {

  -- Pause
  { "%pause", "lost.control" },
  
  -- Targetting
  --{ "/cleartarget [dead][help]", "target.dead" },
  --{ "/targetenemy [noharm][dead]", "!target.exists" },
  
  -- If Moving
  --{ "Shadow Word: Pain", "player.moving" },
  --{ "Cascade", "player.moving" },
  --{ "Halo", "player.moving" },
  --{ "Shadow Word: Death", "player.moving" },
  
  -- Heals
  {"/use Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health < 20", "player"},
  { "Renew", "spell.ready && player.health <= 70 && !player.buff(Renew)", "player"},
  { "Power Word: Shield", "spell.ready && player.health <= 70", "player"},
  
  -- Rotation
  { "Shadow Word: Death", "target.debuff(Shadow Word: Death).duration < 1" },
  { "Mind Blast", "player.buff(Divine Insight)" },
  { "Devouring Plague", "player.shadoworbs = 3" },
  { "Mind Flay", "target.debuff(Devouring Plague)" }, 
  { "Mind Blast" }, 
  { "Shadow Word: Pain", "target.debuff(Shadow Word: Pain).duration < 3" },
  --{ "Halo", },
  --{ "Mind Spike", "player.buff(Surge of Darkness)" },
  { "Vampiric Touch", "target.debuff(Vampiric Touch).duration < 3" },
  { "Mind Flay" },
  { "Shadow Word: Death" },
}

local outCombat = {
  { "%pause", "player.iscastingany" },
  { "Power Word: Fortitude", "!player.buff(Power Word: Fortitude)" },
  { "Inner Fire", "!player.buff(Inner Fire)" },
  { "Shadowform", "!player.buff(Shadowform)" },
}


_A.CR:Add(258, {
    name = "SHADOW",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})