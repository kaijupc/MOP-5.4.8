local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

-- Custom list: enemy infront without debuff
_A.FakeUnits:Add({'enemyInFrontNotDebuff', 'efndebuff'}, function(num, debuff)
    local tempTable = {}
    for _, Obj in pairs(_A.OM:Get('EnemyCombat')) do
        if not Obj:debuff(debuff) and Obj:infront() then
            tempTable[#tempTable+1] = { guid = Obj.guid, distance = Obj:distance() }
        end
    end
    if #tempTable>1 then
        table.sort( tempTable, function(a,b) return a.distance < b.distance end )
    end
    return tempTable[num] and tempTable[num].guid        
end)

local inCombat = {

  --{"Frost Armor", "spell.ready && !buff"},
  
  {"Remove Curse", "spell.ready && debuff(Curse).type", "player"},
  
  -- Targetting
  {"%target", "!target.exists || target.dead", "nearEnemyCb"},
  {"/cleartarget [dead][help]", "target.dead" },
  
  -- Interrupt
  {"Counterspell", "spell.ready && range(2) <= 40 && target.interruptible", "nearEnemyCb"},
  
 -- Consumables
  {"Healthstone", "item.usable && player.hp < 30", "player"},
  
  -- Cooldown
  {"Icy Veins", "spell.ready && !buff && target.boss", "player"},
  {"Invocation", "spell.ready && !buff", "player"},
  
  -- Aoe
  --{"Nether Tempest", "spell.ready && range(2) <= 40 && area_range(8).enemies >= 2", "target"},
  --{"Frost Nova", "spell.ready && range(2) <= 40 && !target.boss", "target"},
  {"Frost Nova", "spell.ready && spell.range && area_range(8).enemies >= 1 && !target.boss", "target"},
  {"Cone of Cold", "spell.ready && range(1) <= 5 && area_range(3).enemies >= 1", "target"},
  --{"Frost Bomb", "spell.ready && range(2) <= 40 && area_range(8).enemies >= 6", "target"},
  --{{{"Living Bomb", "spell.range", "enemyInFrontNotDebuff(Living Bomb)"},}, "spell(Living Bomb).ready && count.enemies(Flame Shock).debuffs <= 3"},
  
  -- Rotation
  {"Ice Barrier", "spell.ready && !buff"},
  {"Ice Lance", "spell.ready && range(2) <= 40 && player.buff(Fingers of Frost)", "target"},
  --{"Living Bomb", "spell.ready && range(2) <= 40 && !debuff", "target"},
  --{"Frozen Orb", "spell.ready && range(2) <= 40", "target"},
  {"Frostfire Bolt", "spell.ready && range(2) <= 40 && player.buff(Brain Freeze)", "target"},
  {"Fire Blast", "spell.ready && range(2) <= 30", "target"},
  {"Frostbolt", "spell.ready && range(2) <= 40", "target"},
}

local outCombat = {
    --{"Frost Armor", "spell.ready && !buff"},
}

_A.CR:Add(64, {
    name = "MAGE TEST - FROST",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})