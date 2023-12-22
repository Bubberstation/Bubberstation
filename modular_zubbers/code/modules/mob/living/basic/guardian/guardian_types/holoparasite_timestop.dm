#define BLOODSUCKER_GUARDIAN_PATH /mob/living/basic/guardian/standard/timestop
///Bloodsuckers spawning a Guardian will get the Bloodsucker one instead.
/obj/item/guardian_creator/spawn_guardian(mob/living/user, mob/dead/candidate, guardian_path)
	if(IS_BLOODSUCKER(user) && guardian_path != BLOODSUCKER_GUARDIAN_PATH)
		theme = GLOB.guardian_themes[GUARDIAN_THEME_MAGIC]
		spawn_guardian(user, candidate, BLOODSUCKER_GUARDIAN_PATH)
		return
	// Call parent to deal with everyone else
	return ..()
#undef BLOODSUCKER_GUARDIAN_PATH
/**
 * The Guardian itself
 */
/mob/living/basic/guardian/standard/timestop
	// Like Bloodsuckers do, you will take more damage to Burn and less to Brute
	damage_coeff = list(BRUTE = 0.5, BURN = 2.5, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	playstyle_string = span_holoparasite("As a <b>timestop</b> type you have the ability to stop time, allowing you to move freely while your enemies and even projectiles are frozen. You are also resistant to brute damage, but weak to burn damage.")
	creator_name = "Timestop"
	creator_desc = "Devastating close combat attacks and high physical damage resistance, but weak to burns. Can smash through weak walls and stop time."
	creator_icon = "standard"

/mob/living/basic/guardian/standard/timestop/set_summoner(mob/living/to_who, different_person = FALSE)
	. = ..()
	var/datum/action/cooldown/spell/timestop/guardian/timestop_ability = new()
	timestop_ability.Grant(src)
	ADD_TRAIT(to_who, TRAIT_TIME_STOP_IMMUNE, REF(src))

///Guardian Timestop ability
/datum/action/cooldown/spell/timestop/guardian
	name = "Guardian Timestop"
	desc = "This spell stops time for everyone except for you and your master, \
		allowing you to move freely while your enemies and even projectiles are frozen."
	cooldown_time = 60 SECONDS
	spell_requirements = NONE
	invocation_type = INVOCATION_NONE

/datum/guardian_fluff/tech
	guardian_fluff = list(
		GUARDIAN_ASSASSIN = "Boot sequence complete. Stealth modules loaded. Holoparasite swarm online.",
		GUARDIAN_CHARGER = "Boot sequence complete. Overclocking motive engines. Holoparasite swarm online.",
		GUARDIAN_DEXTROUS = "Boot sequence complete. Armed combat routines loaded. Holoparasite swarm online.",
		GUARDIAN_EXPLOSIVE = "Boot sequence complete. Payload generator online. Holoparasite swarm online.",
		GUARDIAN_GASEOUS = "Boot sequence complete. Atmospheric projectors operational. Holoparasite swarm online.",
		GUARDIAN_GRAVITOKINETIC = "Boot sequence complete. Gravitic engine spinning up. Holoparasite swarm online.",
		GUARDIAN_LIGHTNING = "Boot sequence complete. Tesla projectors charged. Holoparasite swarm online.",
		GUARDIAN_PROTECTOR = "Boot sequence complete. Bodyguard routines loaded. Holoparasite swarm online.",
		GUARDIAN_RANGED = "Boot sequence complete. Flechette launchers operational. Holoparasite swarm online.",
		GUARDIAN_STANDARD = "Boot sequence complete. CQC suite engaged. Holoparasite swarm online.",
		GUARDIAN_SUPPORT = "Boot sequence complete. Medical suite active. Holoparasite swarm online.",
		GUARDIAN_TIMESTOP = "ERROR... T$M3 M4N!PULA%I0N modules loaded. Holoparasite swarm online.",
	)

/datum/guardian_fluff/miner
	guardian_fluff = list(
		GUARDIAN_ASSASSIN = "The shard reveals... Glass, a sharp but fragile ambusher.",
		GUARDIAN_CHARGER = "The shard reveals... Titanium, a lightweight, agile fighter.",
		GUARDIAN_DEXTROUS = "The shard reveals... Gold, a malleable hoarder of treasure.",
		GUARDIAN_EXPLOSIVE = "The shard reveals... Gibtonite, volatile and surprising.",
		GUARDIAN_GASEOUS = "The shard reveals... Plasma, the bringer of flame.",
		GUARDIAN_GRAVITOKINETIC = "The shard reveals... Bananium, a manipulator of motive forces.",
		GUARDIAN_LIGHTNING = "The shard reveals... Iron, a conductive font of lightning.",
		GUARDIAN_PROTECTOR = "The shard reveals... Uranium, dense and resistant.",
		GUARDIAN_RANGED = "The shard reveals... Diamond, projecting a million sharp edges.",
		GUARDIAN_STANDARD = "The shard reveals... Plastitanium, a powerful fighter.",
		GUARDIAN_SUPPORT = "The shard reveals... Bluespace, master of relocation.",
		GUARDIAN_TIMESTOP = "You encounter... The World, the controller of time and space."
	)

/datum/guardian_fluff/carp
	guardian_fluff = list(
		GUARDIAN_ASSASSIN = "CARP CARP CARP! Caught one! It's an assassin carp! Just when you thought it was safe to go back to the water... which is unhelpful, because we're in space.",
		GUARDIAN_CHARGER = "CARP CARP CARP! Caught one! It's a charger carp which likes running at people. But it doesn't have any legs...",
		GUARDIAN_DEXTROUS = "CARP CARP CARP! You caught one! It's a dextrous carp ready to slap people with a fish, once it picks one up.",
		GUARDIAN_EXPLOSIVE = "CARP CARP CARP! Caught one! It's an explosive carp! You two are going to have a blast.",
		GUARDIAN_GASEOUS = "CARP CARP CARP! You caught one! It's a gaseous carp, but don't worry it actually smells pretty good!",
		GUARDIAN_GRAVITOKINETIC = "CARP CARP CARP! Caught one! It's a gravitokinetic carp! Now do you understand the gravity of the situation?",
		GUARDIAN_LIGHTNING = "CARP CARP CARP! Caught one! It's a lightning carp! What a shocking result!",
		GUARDIAN_PROTECTOR = "CARP CARP CARP! You caught one! Wait, no... it caught you! The fisher has become the fishy...",
		GUARDIAN_RANGED = "CARP CARP CARP! You caught one! It's a ranged carp! It has been collecting glass shards in preparation for this moment.",
		GUARDIAN_STANDARD = "CARP CARP CARP! You caught one! This one is a little generic and disappointing... Better punch through some walls to ease the tension.",
		GUARDIAN_SUPPORT = "CARP CARP CARP! You caught a support carp! Now it's here, now you're over there!",
		GUARDIAN_TIMESTOP = "CARP CARP CARP! You caught one! It's imbued with the power of Carp'Sie herself. Time to rule THE WORLD!."
	)
