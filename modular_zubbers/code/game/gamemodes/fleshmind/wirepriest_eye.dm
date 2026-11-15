/mob/eye/wire_priest
	name = "Wirepriest Eye"
	real_name = "Wirepriest Eye"
	desc = "The eye of a wirepriest, lurking across the station before coming down."
	icon = 'icons/mob/eyemob.dmi'
	icon_state = "marker"
	mouse_opacity = MOUSE_OPACITY_ICON
	move_on_shuttle = TRUE
	invisibility = INVISIBILITY_OBSERVER
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	see_invisible = SEE_INVISIBLE_LIVING
	pass_flags = PASSBLOB
	faction = list(ROLE_WIRE_PRIEST)
	lighting_cutoff_red = 0
	lighting_cutoff_green = 5
	lighting_cutoff_blue = 10
	hud_type = /datum/hud/wire_eye
	// When you get forced to place the core, even when you don't like it.
	var/autoplace_max_time = WIREPRIEST_EYE_FORCE_SPAWN_TIME

/mob/eye/wire_priest/Initialize(mapload)
	. = ..()
	autoplace_max_time += world.time

/mob/eye/wire_priest/process(seconds_per_tick)
	. = ..()
	if(autoplace_max_time && world.time >= autoplace_max_time)
		var/turf/spawn_turf = wireweed_get_valid_loc()
		spawn_core_and_priest(spawn_turf)

/mob/eye/wire_priest/proc/spawn_core_and_priest(turf/spawn_turf)
	if(isnull(spawn_turf))
		spawn_turf = get_turf(src)
		if(!wireweed_is_valid_turf(spawn_turf)) // If we got one passed in, we force
			src.balloon_alert(src, "can't spawn here")
			return
	var/obj/structure/fleshmind/structure/core/new_core = new(spawn_turf)
	if(isnull(mind))
		return
	var/mob/living/carbon/human/priest = new(spawn_turf)
	var/datum/antagonist/wire_priest/priest_datum = mind.has_antag_datum(/datum/antagonist/wire_priest)
	priest_datum.brain_jack = new_core.our_controller
	mind.transfer_to(priest)
	priest_datum.on_gain_physical_state()
	message_admins("[ADMIN_LOOKUPFLW(priest)] has been made into a physical Wire Priest.")
	qdel(src)

/mob/eye/wire_priest/Move(atom/newloc, direct, glide_size_override, update_dir)
	var/area/check_area = get_area(newloc)
	if(isgroundlessturf(newloc) || istype(check_area, /area/shuttle))
		return FALSE
	forceMove(newloc)
	return TRUE

/mob/eye/wire_priest/mind_initialize()
	. = ..()
	if(!mind.has_antag_datum(/datum/antagonist/wire_priest))
		mind.add_antag_datum(/datum/antagonist/wire_priest)

/datum/hud/wire_eye/initialize_screen_objects()
	. = ..()
	add_screen_object(/atom/movable/screen/wire_priest/spawn_core, HUD_BLOB_JUMP_TO_CORE)
