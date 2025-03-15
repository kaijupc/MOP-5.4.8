local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

_A.FakeUnits:Add({'enemyInFrontNotDebuff', 'efndebuff'}, function(num, debuff)
    local tempTable = {}
    for _, Obj in pairs(_A.OM:Get('EnemyCombat')) do
        if not Obj:debuff(debuff) and Obj:infront() then ------>  HERE Obj:infront()
            tempTable[#tempTable+1] = { guid = Obj.guid, distance = Obj:distance() }
        end
    end
    if #tempTable>1 then
        table.sort( tempTable, function(a,b) return a.distance < b.distance end )
    end
    return tempTable[num] and tempTable[num].guid        
end)

local inCombat = {
	{"!%pause", "dbm(stop cast)<=0.5"},
{{
    {"%target", "inmelee", "nearEnemyCb"},
}, "!target.exists || target.dead"},
    {"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
	{"/cleartarget [dead][help]", "target.dead"},
	
	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"Healing Surge", "spell.ready && player.health <= 50", "target"},

    
	--BUFFS
	{"Cleanse Spirit", "spell.ready && range(2) <=40 && delay(Cleanse, 1) && debuff(Curse).type", "player"},
	{"Cleanse Spirit", "spell.ready && range(2) <=40 && delay(Cleanse, 1) && debuff(Curse).type", "tank1"},
	--{"Bloodlust", "spell.ready && !buff(32182 || 90355 || 80353 || 2825 || 146555).any && target.boss && target.health <= 95", "player"},
	{"Spirit Walk", "spell.ready && player.state(snare || root || dazed)", "player"},
	{"Shamanistic Rage", "spell.ready && health <= 60 && !target.ttd <=2", "player"},
	
	--INTERRUPT/DISPEL
	{{
    {"Wind Shear", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "enemiesCombat"},
	}, "spell(Wind Shear).ready"},
	{"Purge", "spell.ready && range(2) <=30 && delay(Purge, 1)", "healthierEnemyBuffType(Magic)"},
	
	
	--AOE
	{"Fire Nova", "spell.ready && player.area_range(15).enemies >= 2 && debuff(Flame Shock)", "nearEnemyCb"},
	{"Chain Lightning", "spell.ready && range(2) <= 30 && player.area_range(10).enemies >= 3 && player.buff(Maelstrom Weapon).count == 5", "nearEnemyCb"},
	
	--TOTEMS
	{{
    {{
        {"Searing Totem", nil, "player"},
    }, "!exists || distance>=25", "totemName(Searing Totem)"},
}, "spell(Searing Totem).ready"}, 
	{"Tremor Totem", "spell.ready && !buff && player.state(fear || charm || sleep)", "player"},
	{"Grounding Totem", "spell.ready && isCastingOnMe && casting.length>=1 && casting.remaining<=0.5", "enemies"},
	{"Stormlash Totem", "spell.ready && boss && player.buff(32182 || 90355 || 80353 || 2825 || 146555).any", "player"},
	{"Magma Totem", "spell.ready && isCastingOnMe && player.area_range(10).enemies >= 4", "nearEnemyCb"},
	{"Windwalk Totem", "spell.ready && !buff && {player.state(root) || dazed}", "player"},
	{"Healing Stream Totem", "spell.ready && !buff && health <= 80", "lowest"},
	{"Healing Tide Totem", "spell.ready && !buff(Mana Spring Totem) && boss && health <= 70", "lowest"},
    --SPAM
	{{
    {"Flame Shock", "spell.range", "enemyInFrontNotDebuff(Flame Shock)"},
}, "spell(Flame Shock).ready && count.enemies(Flame Shock).debuffs<2"},
	{"Lightning Bolt", "spell.ready && range(2) <= 30 && player.buff(Maelstrom Weapon).count == 5", "target"},
	{"Lava Lash", "spell.ready && inmelee", "target"},
	{"Earth Shock", "spell.ready && range(2) <= 25 && debuff(Flame Shock) && !debuff(Weakened Blows) && !ttd <=1", "target"},
	{"17364", "spell.ready && inmelee", "target"},
	
	
}

local outCombat = {
	{"Lightning Shield", "spell.ready && !buff", "player"},
	{"Windfury Weapon", "spell.ready && !enchanted.mainhand(Windfury Weapon)"},
	{"Flametongue Weapon", "spell.ready && !enchanted.offhand(Flametongue Weapon)"},
}


_A.CR:Add(263, {
    name = "ENHANCEMENT",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})
