local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local player, target
local inCombat = {

    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    ---------------
    {"Water Shield", "spell.ready && !buff", "player"},
    {"Earthliving Weapon", "spell.ready && !hasEnchant", "player"},
    ------------
    {"Healthstone", "item.usable && player.hp < 40", "player"},
    {"Mana Tide Totem", "spell.ready && mana < 75", "player"},
    {"Stormlash Totem", "spell.ready && hashero", "player"},
    {"Healing Tide Totem", "spell.ready && player.buff(Ascendance)", "player"},
    {"Healing Stream Totem", "spell.ready && group.health <= 95", "roster"},
    ------------
    {"Ascendance", "spell.ready && group.health <= 70", "roster"},
    {"Blood Fury", "spell.ready && exists", "target"},
    ------------
    {"Earth Shield", "spell.ready && spell.range && exists && !buff", "tank"},
    {{{"Healing Rain", nil, "heal_dist_radius_min_avghp(40, 10, 3, 100).ground"},}, "spell(Healing Rain).ready"},
    {"Chain Heal", "spell.ready && spell.range && area(40, 80).heal >= 4}", "lowest"},
    {"Riptide", "spell.ready && spell.range && exists && !buff.any && health < 100", "tank"},
    {"Healing Surge", "spell.ready && spell.range && health < 30", "lowest"},
    {{"Greater Healing Wave"}, "spell.ready && spell(Ancestral Swiftness).ready && spell.range && health < 50", "lowest"},
    {"Healing Wave", "spell.ready && spell.range && player.buff(Tidal Waves) && health < 90", "lowest"},
    {"Lightning Bolt", "spell.ready && spell.range", "nearEnemyCb"},
}

_A.CR:Add(264, {
    name = "RESTO",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})