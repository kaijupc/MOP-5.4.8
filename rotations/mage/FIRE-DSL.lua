local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local function stopcast(nTimes)
    for i=1,nTimes do
        _A.SpellStopCasting()
    end
end


local inCombat = {

	{"%pause", "lost.control"},
	{stopcast(2), "player.iscastingany && {target.dead || !target.exists}"},
{{
    {"%target", "distance <40", "enemiesCombat"},
}, "!target.exists || target.dead"},
	{"/cleartarget [dead][help]", "target.dead"},
	
	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"#Mana Gem", "item(Mana Gem).count>0 && item(Mana Gem).usable && mana <50", "player"},
	
	--BUFFS
	{"Blood Fury", "spell.ready && target.boss && target.health <= 97", "player"},
	{"Remove Curse", "spell.ready && spell.range && delay(Remove Curse, 1) && debuff(Curse)", "player"},
	{"Remove Curse", "spell.ready && spell.range && delay(Remove Curse, 1) && debuff(Curse)", "tank"},
	{"Invisibility", "spell.ready && health <= 80 && threat >=100 && (israid || isparty)", "player"},
	{"Ice Barrier", "spell.ready && !buff", "player"},

	------------INTERRUPT
	{{
    {"Counterspell", "iscasting.any.spell && spell.range && infront && los && casting.length>=1 && interruptAt(60) && !ttd <1", "enemiesCombat"},
	}, "spell(Counterspell).ready"},
	
    --AOE
	{"Flamestrike", "spell.ready && player.area_range(40).combatenemies.infront >= 3 && !ttd<2", "target.ground"},
	{"Ring of Frost", "spell.ready && player.area_range(30).combatenemies.infront >= 3 && !ttd<2", "target.ground"},
	{"Blizzard", "spell.ready && player.area_range(35).combatenemies.infront >= 3", "target.ground"},
	{"Frost Nova", "spell.ready && player.area_range(10).combatenemies >= 3", "nearEnemyCb"},
	{"Cone of Cold", "spell.ready && player.area_range(5).combatenemies.infront >= 3", "nearEnemyCb"},
	{"Arcane Explosion", "spell.ready && player.area_range(10).enemies >= 3", "nearEnemyCb"},
	
	
	--SPAM
	{"Pyroblast", "spell.ready && range(2) <= 40 && spell.proc && !ttd<2", "target"},
	{"Pyroblast", "spell.ready && range(2) <= 40 && !debuff && boss", "target"},
	{"Fire Blast", "spell.ready && range(2) <= 30", "target"},
	{"Fireball", "spell.ready && range(2) <= 40", "target"},
	{"Scorch", "spell.ready && range(2) <= 40 && player.moving", "target"},
	{"Ice Lance", "spell.ready && range(2) <= 40 && player.moving && ttd <= 2", "target"},
	
	
} 

local outCombat = {
    {"Molten Armor", "spell.ready && !buff", "player"},
	{"Arcane Brilliance", "spell.ready && !buff", "player"},
	{"Ice Barrier", "spell.ready && !buff", "player"},
	
}

_A.CR:Add(63, {
	name = "FAIYAH",
	ic = inCombat,
    ooc = outCombat,
	wow_ver = "5.4.8",
	apep_ver = "1.1",
	
	
})
