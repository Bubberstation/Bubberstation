/obj/effect/decal/cleanable/blood
	var/poolsize = 0

/obj/effect/decal/cleanable/blood/Initialize(mapload)
	. = ..()
	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(blood_check))
	blood_effect()

/obj/effect/decal/cleanable/blood/Destroy()
	. = ..()
	UnregisterSignal(loc, COMSIG_ATOM_ENTERED)

/obj/effect/decal/cleanable/blood/proc/blood_check()
	SIGNAL_HANDLER
	message_admins("entered blood")
	for(var/mob/living/carbon/human/entered_mob in loc)
		if(entered_mob.is_bleeding())
			blood_effect()
			break

/obj/effect/decal/cleanable/blood/proc/blood_effect()
	var/list/filters_adding =  list(
		filter(
				type = "drop_shadow",
				size = 4,
				color = "#ff0000",
			),
		filter(
				type = "outline",
				size = initial(poolsize),
				color = "#570000",
				flags = OUTLINE_SHARP,
			)
	)

	if(!length(filters))
		filters = filters_adding
	animate(
		filters[2],
		time = 6 SECONDS,
		size = clamp(poolsize, 0, 8),
	)
	for(var/mob/living/carbon/human/entered_mob in loc)
		if(!addtimer(CALLBACK(src, PROC_REF(blood_check)), 1 SECONDS, TIMER_UNIQUE))
			world << "looping!"
			break
