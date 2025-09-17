/obj/machinery/power/rbmk2/proc/trigger_voidout()

	var/turf/origin_turf = get_turf(src)

	log_game("[src] triggered a voidout at [AREACOORD(origin_turf)]")
	investigate_log("triggered a voidout at [AREACOORD(origin_turf)]", INVESTIGATE_ENGINE)

	for(var/obj/machinery/power/rbmk2/found_engine in range(8,src))
		found_engine.on_voidout()

	var/obj/voidout/voidout_effect = locate() in range(8,src)
	if(!voidout_effect)
		voidout_effect = new(origin_turf)

	return voidout_effect


/obj/machinery/power/rbmk2/proc/on_voidout()

	if(!stored_rod)
		return FALSE

	qdel(stored_rod)
	stored_rod = null
	active = FALSE

	update_appearance(UPDATE_ICON)

	return TRUE

/obj/voidout
	name = "???"
	desc = "We've been burying them wrong."

	icon = 'modular_zubbers/icons/obj/voidout.dmi'
	icon_state = "voidout"

	var/mob/living/kill_target

	var/current_power = 0

	COOLDOWN_DECLARE(search_cooldown)

	pixel_x = -16
	pixel_y = -16

	plane = MASSIVE_OBJ_PLANE
	layer = ABOVE_ALL_MOB_LAYER

	anchored = FALSE
	density = FALSE
	move_resist = INFINITY

	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSDOORS
	flags_1 = SUPERMATTER_IGNORES_1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF | SHUTTLE_CRUSH_PROOF
	obj_flags = CAN_BE_HIT | DANGEROUS_POSSESSION


/obj/voidout/Initialize(mapload)
	. = ..()
	if(!kill_target)
		var/mob/living/found_target = find_target()
		if(found_target)
			set_target(found_target)
	playsound(src, 'modular_zubbers/sound/machines/rbmk2/voidout.ogg', 50, FALSE, extrarange = 16, pressure_affected = FALSE, use_reverb = FALSE)
	addtimer(CALLBACK(src, PROC_REF(begin_hunt)), rand(10,20) SECONDS)

/obj/voidout/proc/begin_hunt()
	START_PROCESSING(SSfastprocess, src)

/obj/voidout/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	set_target(null)
	. = ..()

/obj/voidout/process(seconds_per_tick)

	if(!kill_target)
		if(COOLDOWN_FINISHED(src, search_cooldown))
			var/mob/living/found_target = find_target()
			if(found_target)
				set_target(found_target)
		return

	if(QDELETED(kill_target) || kill_target.stat == DEAD)
		set_target(null)
		return

	var/turf/our_turf = get_turf(src)
	var/turf/their_turf = get_turf(kill_target)

	if(!their_turf || our_turf.z != their_turf.z)
		set_target(null)
		return

	if(our_turf && our_turf == their_turf)
		kill_target.visible_message(
			span_danger("Something terrible violently phases right into [kill_target]!"),
			span_userdanger("Something terrible violently phases right into you, stealing something precious!"),
		)
		var/obj/item/organ/heart/target_heart = kill_target.get_organ_slot(ORGAN_SLOT_HEART)
		kill_target.add_splatter_floor(their_turf)
		if(target_heart)
			kill_target.investigate_log("had their heart exploded by a voidout.", INVESTIGATE_DEATHS)
			qdel(target_heart)
		else if(kill_target.blood_volume > 0)
			kill_target.investigate_log("had their blood drained by a voidout.", INVESTIGATE_DEATHS)
			kill_target.blood_volume = 0
		playsound(our_turf, 'modular_zubbers/sound/machines/rbmk2/voidout_end.ogg', 50, FALSE, extrarange = 16, pressure_affected = FALSE, use_reverb = FALSE)
		qdel(src) //Satisfied

		return

	if(their_turf && step_towards(src,their_turf))
		var/turf/new_turf = get_turf(src)
		var/our_distance = get_dist(their_turf,new_turf)
		if(our_distance  <= 12 && !((x+y) % 4))
			kill_target.playsound_local(new_turf, 'modular_zubbers/sound/machines/rbmk2/voidout_step.ogg', 50, FALSE)
		if(our_turf.loc != new_turf.loc)
			var/area/our_area = new_turf.loc
			our_area.apc?.overload_lighting()

/obj/voidout/proc/set_target(mob/living/desired_target)

	if(desired_target)
		desired_target.ominous_nosebleed()
		to_chat(desired_target, span_hear("You hear a voice in your head... [span_big("\'Run.\'")]"))
		desired_target.playsound_local(get_turf(desired_target), 'modular_zubbers/sound/machines/rbmk2/voidout_run.ogg', 50, FALSE)

	kill_target = desired_target

/obj/voidout/proc/find_target()

	var/mob/living/carbon/human/best_target
	var/best_distance

	for(var/mob/living/carbon/human/potential_target in viewers(8,src))
		if(!potential_target.client)
			continue
		if(potential_target.stat == DEAD)
			continue
		if(!potential_target.get_organ_slot(ORGAN_SLOT_HEART))
			continue
		var/found_distance = get_dist(src,best_target)
		if(best_target && found_distance > best_distance) //If we have a best target and our distance is greater than the existing one, ignore it.
			continue
		best_target = potential_target
		best_distance = found_distance

	return best_target
