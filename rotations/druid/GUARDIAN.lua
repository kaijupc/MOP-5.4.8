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

	{"!%pause", "dbm(stop cast)<=0.5"},
	{"%pause", "lost.control"},
	{"%target", "!target.exists || target.dead", "nearEnemyCb"},
	{"/cleartarget [dead][help]", "target.dead"},
	
	{"Bear Form", "spell.ready && !buff", "player"},
	
	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"Healing Touch", "spell.ready && buff(Dream of Cenarius) && player.health <= 100", "player"},
    
	--BUFFS
    {"Mark of the Wild", "spell.ready && !buff(Mark of the Wild || Blessing of Kings || Legacy of the Emperor || Embrace of the Shale Spider).any", "player"},
	{"Savage Defense", "spell.ready && rage >= 60 && health <= 70 && !buff", "player"},
    {"Barkskin", "spell.ready && health <= 80", "player"},
    {"Survival Instincts", "spell.ready && health <= 40", "player"},
    {"Might of Ursoc", "spell.ready && health <= 40", "player"},
	{"Enrage", "spell.ready && rage <= 20", "player"},
	{"Berserk", "spell.ready && player.area_range(8).enemies >= 5 && !target.ttd <5", "player"},
	
	--INTERRUPT
	{{
    {"Skull Bash", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "enemiesCombat"},
	}, "spell(Skull Bash).ready"},
	{{
    {"Mighty Bash", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "enemiesCombat"},
	}, "spell(Mighty Bash).ready"},
	
    --TAUNT
    {"Growl", "spell.ready && range(2) <=30 && threat <=80", "bestCandidateForAggro(Growl)"},

    --SPAM
	{"Mangle", "spell.ready && inmelee && player.buff(Berserk)", "target"},
	{"Faerie Fire", "spell.ready && range(2) <= 35 && !target.debuff(Weakened Armor)", "enemiesCombat"},
	{"Mangle", "inmelee && {spell.ready || spell.proc}", "target"},
	{"Lacerate", "spell.ready && inmelee && infront && !debuff(Lacerate).stack == 3", "nearEnemyCb"},
	{"Swipe", "spell.ready && range(2) <= 8 && player.area_range(10).enemies >= 1", "nearEnemyCb"},
    {"Thrash", "spell.ready && range(2) <= 8 && player.area_range(10).enemies >= 1", "nearEnemyCb"},
	{"Maul", "spell.ready && inmelee && {player.rage >= 70 || spell.proc}", "target"},


}

local outCombat = {
	{"Mark of the Wild", "spell.ready && !buff(Mark of the Wild || Blessing of Kings || Legacy of the Emperor || Embrace of the Shale Spider).any", "player"},
}

_A.CR:Add(104, {
    name = "GUARDIAN",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})