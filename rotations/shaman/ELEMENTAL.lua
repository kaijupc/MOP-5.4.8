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

local function stopcast(nTimes)
    for i=1,nTimes do
        _A.SpellStopCasting()
    end
end

local inCombat = {
	{"%pause", "lost.control"},
	{stopcast(2), "player.iscastingany && {target.dead || !target.exists}"},
	{"!%pause", "dbm(stop cast)<=0.5"},
	
{{
    {"%target", "distance <35", "nearEnemyCb"},
}, "!target.exists || target.dead"},	
	
	{"/cleartarget [dead][help]", "target.dead"},
	
	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"Healing Surge", "spell.ready && player.health <= 50", "target"},
	
	--PRIO
	{"Flame Shock", "spell.ready && spell.range && target.debuff(Flame Shock).duration <= 3", "target"},
	{"Unleash Elements", "spell.ready && range(2) <= 40 && !ttd <= 1", "target"},
	{"Lava Burst", "spell.ready && spell.range && {spell.proc || !player.moving || player.buff(Spiritwalker's Grace)} && !ttd <= 1", "target"},
	{"Earth Shock", "spell.ready && range(2) <= 40 && spell.proc", "target"},
    
	--BUFFS
	{"Lightning Shield", "spell.ready && !buff", "player"},
	{"Flametongue Weapon", "spell.ready && !enchanted.mainhand(Flametongue Weapon)"},
	{"Cleanse Spirit", "spell.ready && range(2) <=40 && delay(Cleanse, 1) && debuff(Curse).type", "player"},
	{"Cleanse Spirit", "spell.ready && range(2) <=40 && delay(Cleanse, 1) && debuff(Curse).type", "tank"},
	--{"Bloodlust", "spell.ready && !buff(32182 || 90355 || 80353 || 2825 || 146555).any && target.boss && target.health <= 95", "player"},
	{"Spirit Walk", "spell.ready && player.state(snare || root || dazed)", "player"},
	{"Shamanistic Rage", "spell.ready && health <= 60 && !target.ttd <=2", "player"},
	
	--INTERRUPT/DISPEL
	{{
    {"Wind Shear", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(20) && !ttd <2", "enemiesCombat"},
	}, "spell(Wind Shear).ready"},
	{"Purge", "spell.ready && range(2) <=30 && delay(Purge, 1)", "healthierEnemyBuffType(Magic)"},
	
	
	--AOE
	{"Lava Beam", "spell.ready && spell.range && player.area_range(35).combatenemies.infront >= 3 && player.buff(Ascendance)", "enemies"},
	{"Earthquake", "spell.ready && range(2) <= 35 && !player.moving && player.area_range(30).combatenemies.infront >= 7 && !target.ttd <= 3", "target.ground"},
	{"Chain Lightning", "spell.ready && range(2) <= 40 && player.area_range(35).combatenemies.infront >= 3 && !ttd <= 1", "enemies"},
	
	--TOTEMS
	{{
    {{
        {"Searing Totem", nil, "player"},
    }, "!exists || distance>=25", "totemName(Searing Totem)"},
	}, "spell(Searing Totem).ready"}, 
	{"Tremor Totem", "spell.ready && !buff && player.state(fear || charm || sleep) && !target.ttd <= 3", "player"},
	{"Grounding Totem", "spell.ready && isCastingOnMe && casting.length>=1 && casting.remaining<=0.5 && !target.ttd <= 3", "enemies"},
	{"Stormlash Totem", "spell.ready && !buff && target.boss && target.health <= 97", "player"},
	--{"Stormlash Totem", "spell.ready && boss && player.buff(32182 || 90355 || 80353 || 2825 || 146555).any", "player"},
	{"Windwalk Totem", "spell.ready && !buff && {player.state(root || dazed)} && !target.ttd <= 3", "player"},
	{"Healing Stream Totem", "spell.ready && !buff && health <= 80", "lowest"},
	{"Healing Tide Totem", "spell.ready && !buff && boss && health <= 70", "lowest"},
	{"Capacitor Totem", "spell.ready player.area_range(8).combatenemies >= 3 && !target.ttd <= 3", "player"},
	
	--{"SKILL HERE", "spell.ready && spell.range && !player.moving && health <= 50", "boss1"},
	
    --SPAM
	{"Flame Shock", "spell.ready && spell.range && count.enemies.debuffs<=3", "enemyInFrontNotDebuff(Flame Shock)"},
	{"Lightning Bolt", "spell.ready range(2) <= 40", "target"},
	
	
}

local outCombat = {
	{"Lightning Shield", "spell.ready && !buff", "player"},
	{"Flametongue Weapon", "spell.ready && !enchanted.mainhand(Flametongue Weapon)"},
}


_A.CR:Add(262, {
    name = "ELEMENTAL",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})
