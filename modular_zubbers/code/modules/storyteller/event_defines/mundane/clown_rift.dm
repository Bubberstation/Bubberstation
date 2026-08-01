/datum/round_event_control/clown_rift
	name = "Clown rift"
	category = EVENT_CATEGORY_JANITORIAL
	description = "Opens up a rift and throws a mess of clown items out of it"
	typepath = /datum/round_event/clown_rift
	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_CLOWN)

	weight = 50
	max_occurrences = 5

/datum/round_event/clown_rift
	announce_when = 20 EVENT_SECONDS
	start_when = 2 EVENT_SECONDS
	var/area/impact_area
	var/obj/effect/clown_rift/rift
	/// Admin selected location
	var/turf/impact_turf

/datum/round_event/clown_rift/setup()
	if(impact_turf)
		impact_area = get_area(impact_turf)
	else
		impact_area = find_area()
		impact_turf = get_valid_turf(impact_area)

/datum/round_event/clown_rift/start()
	rift = new /obj/effect/clown_rift(impact_turf)
	announce_to_ghosts(rift)

/datum/round_event/clown_rift/announce(fake)
	priority_announce("Clowning energy impact detected at [impact_area.name]")

/datum/round_event/clown_rift/proc/find_area()
	var/static/list/allowed_areas
	if(isnull(allowed_areas))
		var/static/list/safe_area_types = typecacheof(list(
			/area/station/ai/satellite/chamber,
			/area/station/ai/upload/chamber,
			/area/station/science/ordnance/bomb,
			/area/station/solars,
			/area/station/maintenance,
		))
		allowed_areas = make_associative(GLOB.the_station_areas) - safe_area_types
	var/list/possible_areas = typecache_filter_list(GLOB.areas, allowed_areas)
	if (length(possible_areas))
		return pick(possible_areas)

/datum/round_event/clown_rift/proc/get_valid_turf(target_area)
	var/list/possible_turfs = list()
	for(var/turf/possible_turf as anything in get_area_turfs(target_area))
		if (isspaceturf(possible_turf))
			continue
		if (possible_turf.is_blocked_turf(exclude_mobs = TRUE))
			continue
		if (islava(possible_turf))
			continue
		if (ischasm(possible_turf))
			continue
		possible_turfs += possible_turf

	return pick(possible_turfs)

/obj/effect/countdown/clown_rift
	name = "Clown rift countdown"

/obj/effect/countdown/clown_rift/get_value()
	var/obj/effect/clown_rift/rift = attached_to
	if(!istype(rift))
		return
	var/seconds_left = max(0, (rift.death_time - world.time) / 10)
	return "[round(seconds_left)]"

/obj/effect/clown_rift
	name = "clown rift"
	desc = "A tear in the fabric of reality, leading to a dimension overflowing with fun and pranks."
	icon = 'modular_zubbers/icons/mob/simple/animals.dmi' // Testing until I make icons
	icon_state = "clowngoblin"
	color = "#777700"
	density = FALSE
	anchored = TRUE
	/// Time it takes for the clown rift to fully form
	var/formation_time = 10 SECONDS
	/// Is the clown rift fully formed and active?
	var/formed = FALSE
	/// Time it takes for the rift to explode and despawn
	var/lifespan = 70 SECONDS
	var/form_time
	var/death_time
	/// countdown of the rift's inevitable doom
	var/obj/effect/countdown/clown_rift/countdown
	/// List of types we can throw out
	var/list/typelist = list(
		/obj/item/clothing/shoes/clown_shoes,
		/obj/item/clothing/under/rank/civilian/clown,
		/obj/item/clothing/mask/gas/clown_hat,
		/obj/item/storage/backpack/clown,
		/obj/item/grown/bananapeel,
		/obj/item/bikehorn/golden,
		/obj/item/bikehorn/rubberducky,
		/obj/item/bikehorn,
		/obj/item/reagent_containers/cup/soda_cans/canned_laughter,
		/obj/item/flashlight/flashdark,
		/obj/item/megaphone/clown,
		/obj/item/food/donkpocket/warm/honk,
		/obj/item/food/donut/laugh,
		/obj/item/food/donut/jelly/laugh,
		/obj/item/food/canned,
		/obj/item/food/pie/cream,
		/obj/item/grenade/chem_grenade/colorful,
		/obj/item/grenade/chem_grenade/glitter,
		/obj/item/implanter/sad_trombone,
		/obj/item/borg/upgrade/transform/clown,
		/obj/item/airlock_painter/decal,
		/obj/item/toy/crayon,
		/obj/item/toy/crayon/rainbow,
		/obj/item/dyespray,
		/obj/item/toy/mecha/honk,
		/obj/item/toy/waterballoon,
		/obj/item/toy/balloon,
		/obj/item/toy/balloon/long,
		/obj/item/balloon_mallet,
		/obj/item/banhammer
	)

/obj/effect/clown_rift/Initialize(mapload)
	. = ..()
	if(!mapload)
		SSpoints_of_interest.make_point_of_interest(src)

	START_PROCESSING(SSobj, src)
	death_time = world.time + lifespan
	form_time = world.time + formation_time
	countdown = new(src)
	countdown.start()

/// Processes the clown rift fully activating
/obj/effect/clown_rift/proc/form()
	formed = TRUE
	color = "#ffff00"
	playsound(src, 'modular_zubbers/sound/effects/clown/clown_rift_high.ogg', 100, TRUE)

/obj/effect/clown_rift/process(seconds_per_tick)
	if(formed)
		pick_and_throw(seconds_per_tick)
		if(death_time < world.time)
			explode()
	else if(form_time < world.time)
		form()

/obj/effect/clown_rift/proc/pick_and_throw()
	var/typepath = pick(typelist)
	var/obj/to_throw = new typepath(src.loc)
	if(istype(to_throw, /obj/item/grenade))
		var/obj/item/grenade/nade = to_throw
		if(prob(5))
			nade.arm_grenade() // I am an evil girl
	var/list/victims = list()
	for(var/mob/living/carbon/human/potential_victim in viewers(5, src))
		victims += (potential_victim)
	var/mob/living/carbon/human/victim = null
	if(victims.len >= 3)
		victim = pick(victims)
	if(isnull(victim))
		var/list/turf_targets = list()
		for(var/turf/target in oview(5, src))
			turf_targets += target
		to_throw.throw_at(pick(turf_targets), 5, 2)
		return
	to_throw.throw_at(victim, 7, 5)

/// create a last hail mary of clown items and qdel self
/obj/effect/clown_rift/proc/explode()
	playsound(src, 'modular_zubbers/sound/effects/clown/clown_rift_fade.ogg', 60, TRUE)
	for(var/i=0, i<5, i++)
		pick_and_throw()
	sleep(10)
	qdel(src)

/obj/effect/clown_rift/Destroy(force)
	. = ..()
	if(!isnull(countdown))
		qdel(countdown)
