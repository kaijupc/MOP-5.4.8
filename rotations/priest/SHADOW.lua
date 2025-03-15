local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local player, target
local inCombat = {

	{"%pause", "lost.control"},
	--{"/targetenemy [noharm][dead]", "!target.exists"},
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
	{"/cleartarget [dead][help]", "target.dead"},

------------POTS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	--{"Fade", "spell.ready && threat >=100 && (israid || isparty)", "player"},

	------------HEALS
	{"Renew", "spell.ready && spell.range && !buff && health <90", "player"},
	{"Renew", "spell.ready && spell.range && !buff && health <50", "lowest"},
	{"Dispersion", "spell.ready && health <=10", "player"},
	
	------------BUFFS|MANA
	{"Power Word: Shield", "spell.ready && spell.range && health <=90 && !debuff(Weakened Soul)", "lowest"},
	{"Mindbender", "spell.ready && range(2) <=40 && player.mana <=80", "enemiesCombat"},
	
	------------INTERRUPT
	--{"Silence", "spell.ready && iscasting.any.spell && spell.range && infront && los && interruptAt(60)", "enemies"},
	
	{{
    {"Silence", "iscasting.any.spell && spell.range && infront && los && casting.length>=1 && interruptAt(60)", "enemies"},
	}, "spell(Silence).ready"},
	
	------------CLEANSE
	--{"Cleanse", "spell.ready && range(2) <=40 && debuff(Poison || Magic || Disease).type && delay(Cleanse 2)", "roster"},
	--{"Purify", "spell.ready && spell.range && debuff(Disease || Magic).type", "roster"},
	--{"Dispel Magic", "spell.ready && spell.range && dispelType(Magic).atRndTime", "lowestDebuffType(Magic)"},
	
	------------DPS
	{"Shadow Word: Death", "spell.ready && range(2) <=40 && health <=20", "enemiesCombat"},
	{"Devouring Plague", "spell.ready && range(2) <=40 && player.shadoworbs == 3 && !ttd <3", "enemiesCombat"},
	{"Mind Blast", "spell.ready && range(2) <=40 && spell.proc", "enemiesCombat"},
	{"Mind Sear", "spell.ready && range(2) <=40 && !player.moving && area_range(20).combatenemies.infront >= 3", "enemiesCombat"},
	{"Shadow Word: Pain", "spell.ready and range(2) <=40 && debuff(Shadow Word: Pain).duration <=2", "enemiesCombat"},
	--{"Vampiric Touch", "spell.ready and range(2) <=40 && !target.debuff(Vampiric Touch).duration <=3", "target"},
	{"Vampiric Touch", "spell.ready && range(2) <=40 && !player.moving && debuff.duration<2", "enemiesCombat"},
	{"Mind Blast", "spell.ready && range(2) <=40 && !player.moving && infront", "enemiesCombat"},
	{"Mind Flay", "spell.ready && range(2) <=40 && !player.moving && infront", "enemiesCombat"},
	
	
	
	
}

local outCombat = {
	{"%pause", "player.iscastingany" },
	{"Power Word: Fortitude", "!player.buff(Power Word: Fortitude)"},
	{"Inner Fire", "!player.buff(Inner Fire)"},
	{"Shadowform", "!player.buff(Shadowform)"},
}


_A.CR:Add(258, {
    name = "SHADOW",
    ic = inCombat,
    ooc = outCombat,
    gui_st = {title="CR Settings", color="87CEFA", width="315", height="370"},
    wow_ver = "5.4.8",
    apep_ver = "1.1",
})