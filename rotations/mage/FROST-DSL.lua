local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local function stopcast(nTimes)
    for i=1,nTimes do
        _A.SpellStopCasting()
    end
end

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

	{"%pause", "lost.control"},
	{stopcast(2), "player.iscastingany && {target.dead || !target.exists}"},
	{"%target", "!target.exists || target.dead || !boss", "enemiesCombat"},
	{"/cleartarget [dead][help]", "target.dead"},
	
	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	
	--BUFFS
	
	--PET

	--INTERRUPT
	{{
    {"Counterspell", "iscasting.any.spell && spell.range && infront && los && casting.length>=1 && interruptAt(60) && !ttd <1", "enemiesCombat"},
	}, "spell(Counterspell).ready"},
	
    --AOE
	
	
	--SPAM
	{"Ice Lance", "spell.ready && range(2) <= 40 && spell.proc", "target"},
	{"Fire Blast", "spell.ready && range(2) <= 30", "target"},
	{"Frostbolt", "spell.ready && range(2) <= 40", "target"},
	
} 

local outCombat = {
    --{"Frost Armor", "spell.ready && !buff"},
	{"%pause", "lost.control"},
	
}

_A.CR:Add(64, {
	name = "FROSTY",
	ic = inCombat,
    ooc = outCombat,
	wow_ver = "5.4.8",
	apep_ver = "1.1",
})
