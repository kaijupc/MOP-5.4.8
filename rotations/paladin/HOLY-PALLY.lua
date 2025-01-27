local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    --{"%target", "!target.exists || target.dead", "nearEnemyCb"},
    --{"Auto Attack", "target.exists && !auto.attack && target.enemy", "target"},
	
    ------------POTS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	
	------------HEALS
	{"Holy Shock", "spell.ready && range(2) <=40 && player.moving && health <=90", "lowest"},
	{"Holy Prism", "spell.ready && range(2) <=40 && health <=95", "tank"},
	{"Eternal Flame", "spell.ready && range(2) <=40 && health <=90 && spell.proc", "lowest"},
	{"Holy Radiance", "spell.ready && range(2) <=40 && player.buff(Infusion of Light) && health <= 85", "lowest"},
	{"Holy Shock", "spell.ready && range(2) <=40 && health <=90 && player.buff(Daybreak)", "lowest"},
	{"Holy Shock", "spell.ready && range(2) <=40 && health <=90", "lowest"},
	{"Divine Light", "spell.ready && range(2) <=40 && player.buff(Infusion of Light) && health <=70", "tank"},
	{"Holy Light", "spell.ready && range(2) <=40 && player.buff(Infusion of Light) && health <=80", "lowest"},
	{"Eternal Flame", "spell.ready && range(2) <=40 && health <=85 && player.holy.power >=2 && target.buff(Eternal Flame).duration <5", "lowest"},
	{"Lay on Hands", "spell.ready && health <=20 && range(2) <=40 && !debuff(Forbearance)", "lowest"},
	{"Flash of Light", "spell.ready && range(2) <=40 && health <60", "lowest"},
	
	------------BUFFS
	{"Hand of Freedom", "spell.ready && !buff && state(root || dazed)", "player"},
	{"Hand of Freedom", "spell.ready && !buff && state(root || dazed)", "roster"},
	{"Divine Protection", "spell.ready && incdmg.magic(2) >=20000", "player"},
	--{"Hand of Freedom", "spell.ready && !player.buff(Hand of Freedom) && player.state(root || snare)", "player"},
	--{"Hand of Freedom", "spell.ready && player.state(root) || player.state(snare)", "player"},
	
	------------INTERRUPT
	{"Rebuke", "spell.ready && range(1) && interruptible && player.area_range(8).enemies >=1", "nearEnemyCb"},
	{"Fist of Justice", "spell.ready && range(2) <=20 && interruptible", "target"},
	{"Arcane Torrent", "spell.ready && interruptible && player.area_range(8).enemies >=2", "enemies"},
	
	------------CLEANSE
	{"Cleanse", "spell.ready && range(2) <=40 && debuff(Poison || Magic || Disease).type", "roster"},
	--{"Cleanse", "spell.ready && range(2) <=40 && debuff(Magic).type", "roster"},
	--{"Cleanse", "spell.ready && range(2) <=40 && debuff(Disease).type", "roster"},
	
	------------SPAM
	--{"Denounce", "spell.ready && range(2) <=30", "nearEnemy"},
	--{"Hammer of Wrath", "spell.ready && spell.range && health <=20", "nearEnemy"},
	

}

local outCombat = {
	--{"Blessing of Might", "spell.ready && !buff", "player"},
	--{"Holy Shock", "spell.ready && range(2) <= 40 && health <= 90", "lowest"},
	{"Beacon of Light", "spell.ready && spell.range && !buff(53563).any && {debuff(50688).any || hasrole(TANK) && !debuff(50688).any}", "roster"},
}
	

_A.CR:Add(65, {
    name = "HOLY",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})