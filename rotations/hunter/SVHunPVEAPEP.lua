local mediaPath, _A = ...
local DSL = function(api) return _A.DSL:Get(api) end

local inCombat = {
    -- Initial
    {"%target", "!target.exists || target.dead", "nearEnemyCb"},
    {"Counter Shot", "spell.ready && range(2) <= 40 && interruptible", {"target, nearEnemyCb"}},
    {"Healthstone", "item.usable && player.health < 30", "player"},
    -- Pet
    {"Heart of the Phoenix", "spell.ready && pet.dead", "player"},
    {"Revive Pet", "spell.ready && pet.dead", "player"},
    {"Spirit Mend", "spell.ready && range(2) <= 25 && player.health < 80 && !buff", "player"},
    {"Mend Pet", "spell.ready && range(2) <= 40 && pet.health < 80 && !buff", "pet"},
    -- Cooldown
    {"Misdirection", "spell.ready && threat => 80", "tank"},
    {"Explosive Trap", "spell.ready && range(2) <= 40 && area_range(8).enemies > 1", "target.ground"},
    {"Fervor", "spell.ready && player.focus 3= 50", "player"},
    {"A Murder of Crows", "spell.ready && !debuff(A Murder of Crows) && target.boss", "target"},
    {"Rapid Fire", "spell.ready && !hashero && !player.buff(Rapid Fire) && boss && health <99", "target"},
    {"Stampede", "spell.ready && range(2) <= 40 && boss && health <99", "target"},
    -- Rotation
    {"Explosive Shot", "spell.ready && range(2) <= 40 && player.buff(Lock and Load)", "target"},
    {"Glaive Toss", "spell.ready && range(2) <= 40", "target"},
    {"Serpent Sting", "spell.ready && range(2) <= 40 && !debuff && ttd > 10", "target"},
    {"Explosive Shot", "spell.ready && range(2) <= 40", "target"},
    {"Kill Shot", "spell.ready && range(2) <= 45 && health < 20", {"target, nearEnemyCb"}},
    {"Black Arrow", "spell.ready && range(2) <= 40 && !debuff && ttd > 8", "target"},
    {"Multi-Shot", "spell.ready && range(2) <= 40 && area_range(8).enemies > 3", "target"},
    {"Multi-Shot", "spell.ready && range(2) <= 40 && player.buff(Thrill of the Hunt) && debuff(Serpent Sting).duration < 2", "target"},
    {"Arcane Shot", "spell.ready && range(2) <= 40 && player.buff(Thrill of the Hunt)", "target"},
    {"Cobra Shot", "spell.ready && range(2) <= 40 && debuff(Serpent Sting).duration < 6", "target"},
    {"Arcane Shot", "spell.ready && range(2) <= 40 && player.focus >= 67 && area_range(8).enemies < 2", "target"},
    {"Multi-Shot", "spell.ready && range(2) <= 40 && player.focus >= 67 && area_range(8).enemies > 1", "target"},
    {"Cobra Shot", "spell.ready && range(2) <= 40", "target"},
}
local outCombat = {}

_A.CR:Add(255, {
	name = "Survival Hunter PVE",
	ic = inCombat,
    ooc = outCombat,
	wow_ver = "5.4.8",
	apep_ver = "1.1",
})

    -- #auto_shot
	-- #explosive_shot,if=buff.lock_and_load.react	if BuffPresent(lock_and_load_buff) Spell(explosive_shot)
	-- #glaive_toss,if=enabled	if Talent(glaive_toss_talent) Spell(glaive_toss)
	-- #serpent_sting,if=!ticking&ttd>=10	if not target.DebuffPresent(serpent_sting_debuff) and target.TimeToDie() >= 10 Spell(Serpent Sting)
	-- #explosive_shot,if=cooldown_react	if not SpellCooldown(explosive_shot) > 0 Spell(explosive_shot)
	-- #kill_shot	if target.HealthPercent() < 20 Spell(kill_shot)	
    -- #Black Arrow,if=!ticking&ttd>=8	if not target.DebuffPresent(Black Arrow_debuff) and target.TimeToDie() >= 8 Spell(Black Arrow)
	-- #multi_shot,if=active_enemies>3	if Enemies() > 3 Spell(multi_shot)
	-- #multi_shot,if=buff.Thrill of the Hunt.react&dot.serpent_sting.remains<2	if BuffPresent(Thrill of the Hunt_buff) and target.DebuffRemaining(serpent_sting_debuff) < 2 Spell(multi_shot)
	-- #arcane_shot,if=buff.Thrill of the Hunt.react	if BuffPresent(Thrill of the Hunt_buff) Spell(arcane_shot)
	-- #cobra_shot,if=dot.serpent_sting.remains<6	if target.DebuffRemaining(serpent_sting_debuff) < 6 Spell(cobra_shot)
	-- #arcane_shot,if=focus>=67&active_enemies<2	if Focus() >= 67 and Enemies() < 2 Spell(arcane_shot)
	-- #multi_shot,if=focus>=67&active_enemies>1	if Focus() >= 67 and Enemies() > 1 Spell(multi_shot)
	-- #cobra_shot	Spell(cobra_shot)