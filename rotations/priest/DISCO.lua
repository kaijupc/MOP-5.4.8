local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local player, target
local inCombat = {

	{"%pause", "lost.control"},
	{"/cleartarget [dead][help]", "target.dead"},

	------------POTS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	--{"Fade", "spell.ready && threat >=100 && (israid || isparty)", "player"},

	------------HEALS
	--{"Prayer of Healing", "spell.ready && spell.range && roster.health <=70", "roster"},
	{"Flash Heal", "spell.ready && spell.range && spell.proc && health <=80", "lowest"},
	--{"Binding Heal", "spell.ready && spell.range && tank.health <=70 && player.health <=70", "roster"},
	{"Penance", "spell.ready && spell.range && health <=80", "lowest"},
	{"Renew", "spell.ready && spell.range && !buff && health <=90", "lowest"},
	{"Flash Heal", "spell.ready && spell.range && health <=60", "lowest"},
	
	------------BUFFS
	{"Power Word: Shield", "spell.ready && spell.range && health <=80 && spell.proc", "lowest"},
	{"Power Word: Shield", "spell.ready && spell.range && health <=95 && !debuff(Weakened Soul)", "tank"},
	{"Power Word: Shield", "spell.ready && spell.range && health <=80 && !debuff(Weakened Soul)", "lowest"},
	{"Prayer of Mending", "spell.ready && spell.range && {!buff || buff(Prayer of Mending).duration <3}", "tank"},
	{"Archangel", "spell.ready && spell.range && buff(Evangelism).stack == 5 && !buff", "player"},
	{"Pain Suppression", "spell.ready && spell.range && health <=40", "tank"},
	--{"Hymn of Hope", "spell.ready && player.mana <=40", "player"},
	{"Mindbender", "spell.ready && range(2) <=40 && player.mana <=80", "enemiesCombat"},
	
	------------PURIFY/DISPEL
	{"Purify", "spell.ready && range(2) <=40 && delay(Purify, 1) && debuff(Disease || Magic).type", "roster"},
	{"Dispel Magic", "spell.ready && range(2) <=30 && delay(DispelMagic, 1)", "healthierEnemyBuffType(Magic)"},
	
	------------SPAM
	{"Holy Fire", "spell.ready && range(2) <=30 && infront && health <=95", "enemiesCombat"},
	--{"Smite", "spell.ready && range(2) <=30 && !player.moving && delay(Smite, 3) && infront && health <=95", "enemiesCombat"},
	--{"Holy Fire", "spell.ready && spell.range && health <=95 && {player.buff(Evangelism).stack <5 || player.buff(Evangelism).duration <3}", "boss"},
	--{"Smite", "spell.ready && spell.range && !player.moving && health <=95 && {player.buff(Evangelism).stack <5 || player.buff(Evangelism).duration <3}", "target"},


}

local outCombat = {
   {"%pause", "player.iscastingany" },
   {"Power Word: Fortitude", "!player.buff(Power Word: Fortitude)"},
   {"Inner Fire", "!player.buff(Inner Fire)"},
   {"Power Word: Shield", "spell.ready && spell.range && health <=98 && !debuff(Weakened Soul)", "tank"},
   {"Renew", "spell.ready && spell.range && !buff && health <95", "tank"},
   {"Power Word: Shield", "spell.ready && spell.range && health <=70 && !debuff(Weakened Soul)", "lowest"},
   {"Renew", "spell.ready && spell.range && !buff && health <50", "lowest"},
   
}


_A.CR:Add(256, {
    name = "DISCO",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})