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
    {"Lightning Shield", "spell.ready && !buff", "player"},
	{"Flametongue Weapon", "spell.ready && !hasEnchant", "player"},
    ----------------
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Blood Fury", "spell.ready && exists", "target"},
    {"Shamatic Rage", "spell.ready && player.health < 30", "player"},
    {"Healing Surge", "spell.ready && player.health < 50", "player"},
    {"Wind Shear", "spell.ready && exists && interruptible", "nearEnemyCb"},
    {"Purge", "spell.ready && exists && state.purge", "nearEnemyCb"},
    {"Stormlash Totem", "spell.ready && hashero", "player"},
	----------------
    {"Lava Beam", "spell.ready && spell.range && area_range(8).enemies >= 5", "target"},
    {"Chain Lightning", "spell.ready && spell.range && area_range(8).enemies >= 5", "target"},
    {{{"Flame Shock", "spell.range", "enemyInFrontNotDebuff(Flame Shock)"},}, "spell(Flame Shock).ready && count.enemies(Flame Shock).debuffs<2"},
    {"Lava Burst", "spell.ready && spell.range && !player.moving || player.buff(Spiritwalker's Grace) || player.buff(Lava Surge)", "target"},
    {"Elemental Blast", "spell.ready && spell.range && !player.moving || player.buff(Spiritwalker's Grace)", "target"},
    {"Earth Shock", "spell.ready && exists && player.buff(Lightning Shield).stack >= 6", "target"},
    {{{{{"Searing Totem", nil, "player"},}, "!exists || distance>=25", "totemName(Searing Totem)"},}, "spell(Searing Totem).ready"},
    {"Lava Beam", "spell.ready && exists && area_range(8).enemies >= 2", "target"},
    {"Chain Lightning", "spell.ready && exists && area_range(8).enemies >= 2", "target"},
    {"Lightning Bolt", "spell.ready && exists", "target"},
}

_A.CR:Add(262, {
	name = "Elemental Shaman",
	ic = inCombat,
	gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
	wow_ver = "5.4.8",
	apep_ver = "1.1",
})