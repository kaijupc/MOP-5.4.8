local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local function stopcast(nTimes)
    for i=1,nTimes do
        _A.SpellStopCasting()
    end
end

local inCombat = {
	{"%pause", "lost.control"},
	{"!%pause", "dbm(stop cast)<=0.5"},
	{"%target", "!target.exists || target.dead", "enemiesCombat"},
	{"/cleartarget [dead][help]", "target.dead"},

	--POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	{"Ember Tap", "spell.ready && health <= 30 && player.burningembers >= 1", "player"},
	
	--BUFFS
	{"Soulshatter", "spell.ready && health <= 80 && threat >=100", "player"},
	{"Dark Intent", "spell.ready && !buff", "player"},
	{"Flames of Xoroth", "spell.ready && pet.dead", "player"},
	{"Unending Resolve", "spell.ready && health <= 40", "player"},
	
	--INTERRUPT
	{{
    {"Shadowfury", "iscasting.any.spell && spell.range && infront && casting.length>=1 && interruptAt(60) && !ttd <2", "target.ground"},
	}, "spell(Shadowfury).ready"},

	--AOE
	{"Shadowfury", "spell.ready && player.area_range(30).combatenemies.infront >= 4 && !target.ttd <= 3", "target.ground"},
	{"Rain of Fire", "spell.ready && !player.moving && player.mana >=50 && player.area_range(30).combatenemies.infront >= 1 && !target.debuff", "target.ground"},

	--SPAM
	{"Shadowburn", "spell.ready && range(2) <= 40 && health <= 20% && infront && player.burningembers >= 1", "boss1 || boss2"},
	{"Shadowburn", "spell.ready && target.health <= 20 && !debuff && range(2) <= 40", "enemiesCombat"},
	{"Chaos Bolt", "spell.ready && !player.moving && infront && range(2) <= 40 && health <= 98 && player.burningembers >= 1 && boss", "target"},
	--{"Immolate", "spell.ready && range(2) <= 40 && !player.moving && target.debuff(Immolate).duration <= 4 && infront && !ttd <= 1", "target"},
	{"Immolate", "spell.ready && range(2) <=40 && target.debuff.duration <=4 && !player.moving && infront", "enemiesCombat"},
	{"Fel Flame", "spell.ready && range(2) <= 40 && player.mana >= 50 && infront && player.burningembers <4 && !ttd <= 1", "target"},
	{"Conflagrate", "spell.ready && range(2) <= 40 && infront && !ttd <= 1", "target"},
	{"Incinerate", "spell.ready && !player.moving && infront && range(2) <= 40", "target"},
	{"Drain Life", "spell.ready && !player.moving && infront && range(2) <= 40 && ttd <= 1", "target"},
	{"Curse of the Elements", "spell.ready && spell.range && !debuff", "boss1"},
	
	
	
}

local outCombat = {
	{"%pause", "iscastingany", "player"},
	{"Dark Intent", "spell.ready && !buff", "player"},
	{"Soulstone", "spell.ready && spell.range && !player.moving && hasrole(TANK) && !debuff(Soul Stone).any} && los", "roster"},
	{"Flames of Xoroth", "spell.ready && pet.dead", "player"},
	
}


_A.CR:Add(267, {
    name = "destruction",
    ic = inCombat,
    ooc = outCombat,
    wow_ver = "5.4.8",
    apep_ver = "1.1",
	
})
