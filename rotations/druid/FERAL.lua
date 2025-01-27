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
	--{"/cleartarget [dead][help]", "target.dead"},
	
	{"Cat Form", "spell.ready && !buff", "player"},
	
	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"Healing Touch", "spell.ready && buff(Predatory Swiftness) && player.health <= 100", "player"},
	
	--B.RES
	{"Rebirth", "spell.ready && spell.range && dead && hasRole(TANK)", "roster"},
	{"Rebirth", "spell.ready && spell.range && dead && hasRole(HEALER)", "roster"},
	
	
	--PRIO
	{"Savage Roar", "spell.ready && target.combo >= 5 && {player.buff(Savage Roar).duration <= 3 || !target.debuff(Rip).duration <=5} && !ttd <=1", "player"},
	{"Rip", "spell.ready && inmelee && target.combo == 5 && player.energy >= 30 && target.debuff(Rip).duration <= 4 && ttd >= 15", "target"},
	{"Ferocious Bite", "spell.ready && inmelee && target.combo == 5 && player.energy >= 30 && {target.debuff(Rip).duration >= 10 || !ttd <= 1}", "target"},
	
    --BUFFS
	{"Mark of the Wild", "spell.ready && !buff(Mark of the Wild || Blessing of Kings || Legacy of the Emperor || Embrace of the Shale Spider).any", "player"},
    {"Barkskin", "spell.ready && health <= 50", "player"},
    {"Survival Instincts", "spell.ready && health <= 45", "player"},
    {"Might of Ursoc", "spell.ready && health <= 40", "player"},
	{"Stampeding Roar", "spell.ready && !buff && {player.state(root) || dazed}", "player"},
	
	--INTERRUPT
	{{
    {"Skull Bash", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(50) && !ttd <2", "enemiesCombat"},
	}, "spell(Skull Bash).ready"},
	{{
    {"Mighty Bash", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(50) && !ttd <2", "enemiesCombat"},
	}, "spell(Mighty Bash).ready"},
	
	--ENHANCEMENTS
	{"Tiger's Fury", "spell.ready && energy <= 35 && !hashero && !target.ttd <=2", "player"},
	{"Berserk", "spell.ready && inmelee && boss && health <= 98 && !hashero", "target"},
	
	
	--AOE
	{"Thrash", "spell.ready && range(2) <= 8 && player.area_range(5).enemies >= 1 && debuff(Thrash).duration <= 2 && {player.buff(Clearcasting) || player.energy >= 60} && !ttd <= 1", "nearEnemyCb"},
	{"Swipe", "spell.ready && range(2) <= 8 && player.area_range(5).enemies >= 2 && debuff(Thrash).duration >= 3 && {player.buff(Clearcasting) || player.energy >= 50} && !ttd <= 1", "nearEnemyCb"},
	
    --SPAM
	{"Shred", "spell.ready && inmelee && behind && !target.combo == 5 && {player.buff(Clearcasting) || player.energy >= 50} && !ttd <= 1", "target"},
	{"Shred", "spell.ready && inmelee && behind && player.energy >= 25 && !target.combo == 5 && player.buff(Berserk) && !ttd <= 1", "target"},
	{"Rake", "spell.ready && inmelee && player.energy >= 35 && !target.combo == 5 && debuff(Rake).duration <= 5 && !ttd <=2", "target"},
	{"Faerie Fire", "spell.ready && range(2) <= 35 && !target.debuff(Weakened Armor) && target.boss && health <= 95 && !ttd <=1", "target"},
	{"Mangle", "spell.ready && inmelee && !target.combo == 5 && player.energy >= 40 && player.area_range(3).enemies == 1 && !ttd <=1", "target"},
	
}
	--
	--WORKING SPELLS (BACK UP)
	--{"Ferocious Bite", "spell.ready && inmelee && combo=5 && !target.debuff(Rip).duration <3", "target"},--ORIGINAL
    --{"Thrash", "spell.ready && player.buff(Clearcasting) || energy > 70 && !target.debuff(Thrash)", "player"}, --FOR OBSERVATION
	--{"Rejuvenation", "spell.ready && spell.range && !buff && health<=80", "lowest"},
    --{"Regrowth", "spell.ready && spell.range && {!buff && health<=70 || health<=50}", "lowest"},
	
local outCombat = {
	{"Savage Roar", "spell.ready && target.combo >= 3 &&", "player"},
	{"Ravage", "spell.ready && range(1) && target.behind && player.buff(Prowl)", "target"},
	{"Mark of the Wild", "spell.ready && !buff(Mark of the Wild || Blessing of Kings || Legacy of the Emperor || Embrace of the Shale Spider).any", "player"},
	
}
	
_A.CR:Add(103, {
    name = "FERAL",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})