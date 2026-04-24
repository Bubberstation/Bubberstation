#define NUM_WAYS_PER_HERETIC 5
#define OPENING_DURATION 60 SECONDS

// ideas
//1. spawn heretic mobs around that are friendly 2 u
//2. convert the area's atmos to bz/n2o/freon and a random temp
// 3. mass hallucinations?
// 4. ionspheric?
// 5. temporary spatial distortion?

/datum/reality_smash_tracker
	var/ways_opened = 0
	var/list/obj/effect/unopened_way/ways = list()

/datum/reality_smash_tracker/add_tracked_mind(datum/mind/heretic)
	. = ..()

	// If our heretic's on station, generate some new ways
	var/area/heretic_area = get_area(heretic.current)
	if(ishuman(heretic.current) && (!(is_centcom_level(heretic.current.z)) || istype(heretic_area, /area/centcom/interlink)) || istype(heretic_area, /area/shuttle/arrival))
		generate_new_ways()

///Returns a random list of important/well-travelled turfs (Armory, bridge, etc)
/proc/get_safe_random_important_station_turf_equal_weight()
	// Big list of departments, each with lists of each area subtype.
	var/static/list/important_areas
	if(isnull(important_areas))
		important_areas = list(
				/area/station/cargo/lobby,
				/area/station/cargo,
				/area/station/service/bar,
				/area/station/comms,
				/area/station/security/armory,
				/area/station/engineering/atmos/pumproom,
				/area/station/medical/medbay/lobby,
				/area/station/medical/medbay/central,
				/area/station/science/robotics,
				/area/station/hallway/secondary/command,
				/area/station/science/lobby,
				/area/station/science/lab,
				/area/station/service/kitchen,
			)
		important_areas |= typesof(/area/station/security/brig)
		important_areas |= subtypesof(/area/station/ai)
		important_areas |= subtypesof(/area/station/command)

	return get_safe_random_station_turf(important_areas)

/**
 * Generates a set amount of ways
 * based on the number of already existing ways
 * and the number of minds we're tracking.
 */
/datum/reality_smash_tracker/proc/generate_new_ways()
	var/how_many_can_we_make = 0
	for(var/heretic_number in 1 to length(tracked_heretics))
		how_many_can_we_make += max(NUM_WAYS_PER_HERETIC - heretic_number + 1, 1)

	var/location_sanity = 0
	while((length(ways) + ways_opened) < how_many_can_we_make && location_sanity < 500)
		var/turf/chosen_location = get_safe_random_important_station_turf_equal_weight()
		if (isnull(chosen_location))
			continue // sometimes we get a null bc of unit tests... just ignore it

		for(var/turf/nearby_turf as anything in RANGE_TURFS(1, chosen_location))
			if(!isopenturf(nearby_turf) || is_type_in_typecache(nearby_turf, /datum/antagonist/heretic::blacklisted_rune_turfs))
				location_sanity++
				continue

		// We don't want them close to each other - at least 1 tile of separation
		var/list/nearby_things = range(1, chosen_location)
		var/obj/effect/unopened_way/what_if_i_have_one = locate() in nearby_things
		if(what_if_i_have_one)
			location_sanity++
			continue

		new /obj/effect/unopened_way(chosen_location)

/datum/objective/open_ways
	name = "open ways"

/datum/objective/open_ways/New(text)
	. = ..()
	target_amount = 3
	update_explanation_text()

/datum/objective/open_ways/update_explanation_text()
	. = ..()
	explanation_text = "Open [target_amount] ways. Ways require a full ritual to open, and generally manifest in important station-bound areas."

// x ways will spawn per heretic
// heretics can use their heart (Right click?) to sense the nearest way and its requirements
// heretics then have to draw a rune and use a ritual to open it with the reqs
// after opening it, ~y time later a event will happen
/obj/effect/unopened_way
	name = "unopened way"
	desc = "An unopened door, tangling through reality towards the mansus. Light peaks through the crack - if only you would knock and bask in it."
	icon = 'icons/effects/eldritch.dmi'
	/// The icon state applied to the image created for this way.
	var/real_icon_state = "emark7"
	anchored = TRUE
	interaction_flags_atom = INTERACT_ATOM_NO_FINGERPRINT_ATTACK_HAND|INTERACT_ATOM_NO_FINGERPRINT_INTERACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF
	invisibility = INVISIBILITY_OBSERVER
	var/opening = FALSE
	// typepaths
	var/list/atom/movable/open_requirements = list()
	var/list/atom/movable/banned_atom_types = list()
	var/datum/way_destination/destination
	var/static/list/datum/way_destination/event_weights = list(
		// beneficial
		/datum/way_destination/atmosphere = 30,
		/datum/way_destination/flesh_organs = 30,
		///datum/way_destination/chemical_spill = 30, // TODO - fix liquid SS
		///datum/way_destination/dimension_shift = 20, // dimension shifts nearby walls and floors into a valuable mineral
		/datum/way_destination/anomalies = 30,
		/datum/way_destination/knowledgebooks = 30, // spawns crafting books, maids in the mirror, and flash freezes the nearby area
		/datum/way_destination/clown_planet = 5, // honk (bananium, clown mobs)
		// bad
		/datum/way_destination/heretic_mobs = 20,
		/datum/way_destination/emp = 15,
	)

/obj/effect/unopened_way/Initialize(mapload)
	. = ..()
	GLOB.reality_smash_track.ways += src

	var/datum/way_destination/picked_type = pick_weight(event_weights)
	destination = new picked_type()
	initialize_requirements()

	var/image/heretic_image = image(icon, src, real_icon_state, OBJ_LAYER)
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/has_antagonist/heretic, "emark7", heretic_image)

	AddElement(/datum/element/block_turf_fingerprints)
	AddComponent(/datum/component/redirect_attack_hand_from_turf, interact_check = CALLBACK(src, PROC_REF(verify_user_can_see)))

/obj/effect/unopened_way/Destroy(force)
	. = ..()

	GLOB.reality_smash_track.ways -= src
	destination = null

/obj/effect/unopened_way/examine(mob/user)
	. = ..()

	if (opening)
		if (IS_HERETIC(user) || isobserver(user))
			. += span_boldnotice("This way seems to be connected to [destination.name] - [destination.desc]")
			. += span_hypnophrase(destination.glimpse_heretic)
		else
			. += span_hypnophrase("YOU CATCH A GLIMPSE: [destination.glimpse]---!!")
			if (isliving(user))
				var/mob/living/living_user = user
				living_user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 50, 150)
				living_user.add_mood_event("gates_of_mansus", /datum/mood_event/gates_of_mansus)

// arg one is nullable
/obj/effect/unopened_way/proc/open(mob/living/opener)
	if (opening)
		return
	opening = TRUE
	if (isliving(opener))
		var/datum/antagonist/heretic/antag_datum = GET_HERETIC(opener)
		if (isnull(antag_datum))
			stack_trace("way [src] opened by nonheretic, [opener]")
		else
			antag_datum.adjust_ways_opened(1)
			to_chat(opener, span_boldnotice("The way revealed, you identify the way as a passage to [destination.name] - [destination.glimpse_heretic]"))

	GLOB.reality_smash_track.ways_opened++

	var/area/our_area = get_area(src)
	visible_message(span_warning("The air shimmers as a gate to the mansus becomes clear!"))
	priority_announce(
		"Reality-shearing cross-dimensional anomaly detected in [our_area.name]. Expected excursion in [OPENING_DURATION / 10] seconds.",
		"CentCom Thaumatergy Monitor",
		ANNOUNCER_ANOMALIES,
		has_important_message = TRUE
	)
	notify_ghosts(
		"[opener] just opened a way towards [destination.name] in [our_area.name]!",
		opener,
		"The Gate Is Open",
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
	)

	remove_alt_appearance(/datum/atom_hud/alternate_appearance/basic/has_antagonist/heretic)

	icon_state = real_icon_state
	apply_wibbly_filters(src)
	update_appearance(UPDATE_ICON)

	invisibility = INVISIBILITY_NONE

	START_PROCESSING(SSobj, src)

	name = "opened way"
	desc = "A gate towards the Mansus, now yawning open. Too thin to pass through, but just wide enough to catch a *glimpse*."

	addtimer(CALLBACK(src, PROC_REF(finish_opening), opener), OPENING_DURATION)

/obj/effect/unopened_way/proc/finish_opening(mob/living/opener)
	playsound(src, 'sound/effects/magic/repulse.ogg', 100, FALSE)
	visible_message(span_boldwarning("The way collapses, [destination.spawn_text]"))

	destination.open(src, opener)

	qdel(src)

/obj/effect/unopened_way/process(seconds_per_tick)
	if (opening)
		new /obj/effect/temp_visual/circle_wave/opened_way(get_turf(src))

/obj/effect/temp_visual/circle_wave/opened_way
	color = COLOR_VIVID_YELLOW
	duration = 3 SECONDS
	amount_to_scale = 6

/obj/effect/unopened_way/proc/verify_user_can_see(mob/user)
	return (user.mind in GLOB.reality_smash_track.tracked_heretics)

/obj/effect/unopened_way/attackby(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	return FALSE

/obj/effect/unopened_way/attackby_secondary(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	return FALSE

/obj/effect/unopened_way/proc/initialize_requirements()
	// ripped from knowledge rituals
	var/static/list/potential_organs = list(
		/obj/item/organ/appendix,
		/obj/item/organ/tail,
		/obj/item/organ/eyes,
		/obj/item/organ/tongue,
		/obj/item/organ/ears,
		/obj/item/organ/heart,
		/obj/item/organ/liver,
		/obj/item/organ/stomach,
		/obj/item/organ/lungs,
	)

	var/static/list/potential_easy_items = list(
		/obj/item/shard,
		/obj/item/flashlight/flare/candle,
		/obj/item/book,
		/obj/item/pen,
		/obj/item/paper,
		/obj/item/toy/crayon,
		/obj/item/flashlight,
		/obj/item/clipboard,
	)

	var/static/list/potential_uncommoner_items = list(
		/obj/item/melee/baton/security,
		/obj/item/circular_saw,
		/obj/item/scalpel,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/gun/energy/laser/practice,
	)

	// harder items
	var/static/list/potential_secondary_items = list(
		/obj/item/assembly/flash,
		/mob/living/carbon/human,
		/obj/item/flashlight/seclite,
		/obj/item/stock_parts/subspace/crystal,
		/obj/item/clothing/gloves/color/yellow,
	)

	// harder items
	var/static/list/potential_tertiary_items = list(
		/obj/item/stack/sheet/bone,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/construction/rcd,
		/obj/item/transfer_valve,
	)

	open_requirements[pick(potential_organs)] += 1
	open_requirements[pick(potential_organs)] += 1
	open_requirements[pick(potential_easy_items)] += 1
	open_requirements[pick(potential_uncommoner_items)] += 1
	open_requirements[pick(potential_secondary_items)] += 1
	open_requirements[pick(potential_tertiary_items)] += 1

#undef NUM_WAYS_PER_HERETIC
#undef OPENING_DURATION
