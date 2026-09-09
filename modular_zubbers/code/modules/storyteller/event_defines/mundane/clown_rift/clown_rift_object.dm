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
	icon = 'modular_zubbers/icons/effects/clown_rift.dmi' // Testing until I make icons
	icon_state = "rift_forming"
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
		/obj/item/clothing/shoes/clown_shoes/pink,
		/obj/item/clothing/shoes/clown_shoes/banana_shoes,
		/obj/item/clothing/under/rank/civilian/clown,
		/obj/item/clothing/under/rank/civilian/clown/blue,
		/obj/item/clothing/under/rank/civilian/clown/green,
		/obj/item/clothing/under/rank/civilian/clown/rainbow,
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
	icon_state = "rift_formed"
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
