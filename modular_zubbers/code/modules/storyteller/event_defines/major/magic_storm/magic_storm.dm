/// Like a meteor wave except with spells that are launched against the
/// station, prioritizing people unfortunate enough to be in space.
/// Nowhere near as destructive but small damage is to be expected
/datum/round_event_control/magic_storm
	name = "Magic Storm"
	typepath = /datum/round_event/magic_storm
	description = "Pummels the station in spell projectiles, targeting \
	those unlucky enough to be in space."
	weight = 6 // Not as destructive as meteors but still plenty dangerous
	min_players = 20
	max_occurrences = 3
	earliest_start = 15 MINUTES
	category = EVENT_CATEGORY_SPACE
	map_flags = EVENT_SPACE_ONLY
	track = EVENT_TRACK_MAJOR // Consider this for moderate instead
	tags = list(TAG_SPACE, TAG_DESTRUCTIVE, TAG_CHAOTIC, TAG_MAGIC)

	// Commonly summoned by wizards
	min_wizard_trigger_potency = 1
	max_wizard_trigger_potency = 2

/datum/round_event_control/magic_storm/can_spawn_event(players_amt, allow_magic)
	. = ..()
	if(!.)
		return FALSE
	return TRUE

/datum/round_event/magic_storm
	start_when = 30 EVENT_SECONDS
	end_when = 240 EVENT_SECONDS // Takes a while to finish
	announce_when = 1

	/// List of spells we're gonna be spawning, with weights
	var/list/spell_list = list(
		/obj/projectile/magic/nothing = 20, // We're in an unstable magic cloud. Sometimes the potency aint there.
		/obj/projectile/magic/arcane_barrage = 20,
		/obj/projectile/magic/spellcard = 20,
		/obj/projectile/magic/flying = 15, // Yeet
		/obj/projectile/temp/chill = 15,
		// The delimbing brothers
		/obj/projectile/magic/spellblade = 10,
		/obj/projectile/magic/fireball = 10,
		// Rare funny things
		/obj/projectile/magic/aoe/lightning = 5,
		/obj/projectile/magic/safety = 5,
		/obj/projectile/magic/resurrection = 3, // Please don't put dead bodies out during the storm to gamble.
		/obj/projectile/magic/death = 3, // Also don't put yourself out there
		/obj/projectile/magic/antimagic = 3, // Antimagic is a kind of magic.. just evil
		/obj/projectile/magic/teleport = 2,
		/obj/projectile/magic/locker = 2,
		/obj/projectile/magic/animate = 2, // My solar panel just got up and walked away!
	)

/datum/round_event/magic_storm/setup()
	// The TG parallax system is not in the place to allow event-only parallax layers
	// I just spent 12 hours trying to hack it in to look good, with no success

/datum/round_event/magic_storm/announce(fake)
	priority_announce("The station is entering a magical dust cloud. Crew are advised to stay inside the station until the storm passes.")

/datum/round_event/magic_storm/tick()
	var/list/potential_victims = list()
	for(var/mob/living/player in GLOB.alive_mob_list)
		var/turf/victim_turf = get_turf(player)
		if(victim_turf && is_station_level(victim_turf.z) && istype(victim_turf, /turf/open/space))
			potential_victims += player
		continue
	if(!length(potential_victims))
		potential_victims = null
	spawn_space_spells(4, spell_list, null, pick(potential_victims))

/datum/round_event/magic_storm/end()
	priority_announce("The magical dust cloud has passed the station.")
