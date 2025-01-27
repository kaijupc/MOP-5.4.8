local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end
local function stopcast(nTimes)
    for i=1,nTimes do
        _A.SpellStopCasting()
    end
end

local inCombat = {
	{"%pause", "lost.control"},
    --{"%target", "!target.exists || target.dead", "nearEnemyCb"},
	
	{stopcast(2), "player.iscastingany && {target.dead || !target.exists}"},
	
	------------POTS/HEALS
	{"#Healthstone", "item(Healthstone).count>0 && item(Healthstone).usable && health <30", "player"},
	
	------------BUFFS
	{"Misdirection", "spell.ready && threat =>70", "tank"},
    {"Fervor", "spell.ready && player.focus <=30", "player"},
    {"A Murder of Crows", "spell.ready && player.focus >=60 && boss && health <97", "target"},
	{"Blood Fury", "spell.ready && target.health <97 && target.boss", "player"},
	{"Rapid Fire", "spell.ready && !hashero && boss && health <98", "target"},
	{"Stampede", "spell.ready && target.health <97 && target.boss", "target"},
    {"Stampede", "spell.ready && range(2) <=40 && boss.health <97", "boss"},
	
	------------PET
	{"Master's Call", "spell.ready && !buff && {player.state(root) || dazed}", "player"},
	{"Heart of the Phoenix", "spell.ready && pet.dead", "player"},
    {"Revive Pet", "spell.ready && pet.dead", "player"},
    {"Mend Pet", "spell.ready && range(2) <= 40 && pet.health <= 90 && buff.duration <=3", "pet"},
	{"Cower", "spell.ready && pet.health <= 60 && target.ttd >6", "pet"},

	------------INTERRUPT
	{{
    {"Counter Shot", "iscasting.any.spell && spell.range && infront && los && casting.length>=1 && interruptAt(60) && !ttd <1", "enemies"},
	}, "spell(Counter Shot).ready"},
	{{
	{"Scatter Shot", "iscasting.any.spell && spell.range && infront && los && casting.length>=1 && interruptAt(60) && !ttd <1", "enemies"},
	}, "spell(Scatter Shot).ready"},
	{{
	{"Intimidation", "iscasting.any.spell && spell.range && infront && los && casting.length>=1 && interruptAt(60) && !ttd <1", "enemies"},
	}, "spell(Intimidation).ready"},

    ------------AOE/TRAPS
	{"Ice Trap", "spell.ready && range(2) <= 40 && area_range(25).combatenemies >= 1 && !player.buff(Lock and Load)", "target.ground"},
	{"Explosive Trap", "spell.ready && range(2) <= 40 && area_range(25).combatenemies >= 3", "target.ground"},
	{"Snake Trap", "spell.ready && range(2) <= 40 && area_range(25).combatenemies >= 3", "target.ground"},
	{"Multi-Shot", "spell.ready && range(2) <=40 && area_range(25).combatenemies >4 && player.focus >=50 && infront", "target"},
	
	------------SPAM
	{"Kill Shot", "spell.ready && range(2) <=45 && health <20", "target"},
	{"Explosive Shot", "spell.ready && range(2) <= 40 && spell.proc && !ttd <3", "target"},
	{"Black Arrow", "spell.ready && range(2) <= 40 && !debuff && player.focus >=35 && ttd >=20", "target"},
	{"Explosive Shot", "spell.ready && range(2) <= 40 && player.focus >=25 && !ttd <2", "target"},
	{"Serpent Sting", "spell.ready && range(2) <=40 && !debuff && player.focus >=20 && !ttd <3", "target"},
	{"Arcane Shot", "spell.ready && spell.range && player.focus >=50 && spell(Explosive Shot).cd>2", "target"},
	{"Concussive Shot", "spell.ready && range(2) <=40 && !debuff && !ttd <1", "target"},
	--{"Arcane Shot", "spell.ready && range(2) <=40 && player.focus >=40 && !ttd <2", "target"},
	{"Cobra Shot", "spell.ready && range(2) <=40 && player.focus <=20 && !ttd <2", "target"},
	
	
}

local outCombat = {
	{stopcast(2), "player.iscastingany && {target.dead || !target.exists}"},
	{"Mend Pet", "spell.ready && range(2) <= 40 && pet.health <= 90 && !buff", "pet"},
	{"Revive Pet", "spell.ready && pet.dead", "player"},

}

_A.CR:Add(255, {
	name = "SURVIVAL",
	ic = inCombat,
    ooc = outCombat,
	wow_ver = "5.4.8",
	apep_ver = "1.1",
})
