// This is a modular override of a global proc.
/get_airlock_overlay(icon_state, icon_file, em_block, state_color, dir)
	var/static/list/airlock_overlays = list()

	var/base_icon_key = "[icon_state][icon_file][state_color]"
	if(!(. = airlock_overlays[base_icon_key]))
		var/mutable_appearance/airlock_overlay = mutable_appearance(icon_file, icon_state)
		if(state_color)
			airlock_overlay.color = state_color
		. = airlock_overlays[base_icon_key] = airlock_overlay
	if(isnull(em_block))
		return

	var/em_block_key = "[base_icon_key][em_block]"
	var/mutable_appearance/em_blocker = airlock_overlays[em_block_key]
	if(!em_blocker)
		em_blocker = airlock_overlays[em_block_key] = mutable_appearance(icon_file, icon_state, plane = EMISSIVE_PLANE, appearance_flags = EMISSIVE_APPEARANCE_FLAGS)
		em_blocker.color = em_block ? GLOB.em_block_color : GLOB.emissive_color

	return list(., em_blocker)

/obj/machinery/door/airlock
	icon = 'modular_zubbers/icons/obj/doors/airlocks/station/airlock.dmi'
	overlays_file = 'modular_zubbers/icons/obj/doors/airlocks/station/overlays.dmi'

	align_to_windows = TRUE
	door_align_type = /obj/machinery/door/airlock

	var/stripe_overlays
	var/color_overlays
	var/glass_fill_overlays = 'modular_zubbers/icons/obj/doors/airlocks/station/glass_overlays.dmi'
	note_overlay_file = 'modular_zubbers/icons/obj/doors/airlocks/station/note_overlays.dmi' //Used for papers and photos pinned to the airlock

	var/has_fill_overlays = TRUE

	var/airlock_paint
	var/stripe_paint
