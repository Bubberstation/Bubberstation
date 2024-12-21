/obj/machinery/door/airlock
	doorOpen = 'modular_skyrat/modules/aesthetics/airlock/sound/open.ogg'
	doorClose = 'modular_skyrat/modules/aesthetics/airlock/sound/close.ogg'
	boltUp = 'modular_skyrat/modules/aesthetics/airlock/sound/bolts_up.ogg'
	boltDown = 'modular_skyrat/modules/aesthetics/airlock/sound/bolts_down.ogg'
	var/forcedOpen = 'modular_skyrat/modules/aesthetics/airlock/sound/open_force.ogg' //Come on guys, why aren't all the sound files like this.
	var/forcedClosed = 'modular_skyrat/modules/aesthetics/airlock/sound/close_force.ogg'

	/// For those airlocks you might want to have varying "fillings" for, without having to
	/// have an icon file per door with a different filling.
	var/fill_state_suffix = null
	/// For the airlocks that use a greyscale accent door color, set this color to the accent color you want it to be.
	var/greyscale_accent_color = null
	/// Does this airlock emit a light?
	var/has_environment_lights = TRUE
	/// Is this door external? E.g. does it lead to space? Shuttle docking systems bolt doors with this flag.
	var/external = FALSE

/obj/machinery/door/airlock/external
	external = TRUE

/obj/machinery/door/airlock/shuttle
	external = TRUE

/obj/machinery/door/airlock/power_change()
	..()
	update_icon()

/obj/machinery/door/airlock/update_overlays()
	. = ..()
	var/frame_state
	var/light_state = AIRLOCK_LIGHT_POWERON
	var/pre_light_color
	switch(airlock_state)
		if(AIRLOCK_CLOSED)
			frame_state = AIRLOCK_FRAME_CLOSED
			if(locked)
				light_state = AIRLOCK_LIGHT_BOLTS
				pre_light_color = AIRLOCK_BOLTS_LIGHT_COLOR
			else if(emergency)
				light_state = AIRLOCK_LIGHT_EMERGENCY
				pre_light_color = AIRLOCK_EMERGENCY_LIGHT_COLOR
			else if(fire_active)
				light_state = AIRLOCK_LIGHT_FIRE
				pre_light_color = AIRLOCK_FIRE_LIGHT_COLOR
			else if(engineering_override)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				pre_light_color = AIRLOCK_ENGINEERING_LIGHT_COLOR
			else
				pre_light_color = AIRLOCK_POWERON_LIGHT_COLOR
		if(AIRLOCK_DENY)
			frame_state = AIRLOCK_FRAME_CLOSED
			light_state = AIRLOCK_LIGHT_DENIED
			pre_light_color = AIRLOCK_DENY_LIGHT_COLOR
		if(AIRLOCK_EMAG)
			frame_state = AIRLOCK_FRAME_CLOSED
		if(AIRLOCK_CLOSING)
			frame_state = AIRLOCK_FRAME_CLOSING
			light_state = AIRLOCK_LIGHT_CLOSING
			pre_light_color = AIRLOCK_ACCESS_LIGHT_COLOR
		if(AIRLOCK_OPEN)
			frame_state = AIRLOCK_FRAME_OPEN
			if(locked)
				light_state = null
				pre_light_color = AIRLOCK_BOLTS_LIGHT_COLOR
			else if(emergency)
				light_state = AIRLOCK_LIGHT_EMERGENCY
				pre_light_color = AIRLOCK_EMERGENCY_LIGHT_COLOR
			else if(fire_active)
				light_state = AIRLOCK_LIGHT_FIRE
				pre_light_color = AIRLOCK_FIRE_LIGHT_COLOR
			else if(engineering_override)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				pre_light_color = AIRLOCK_ENGINEERING_LIGHT_COLOR
			else
				pre_light_color = AIRLOCK_POWERON_LIGHT_COLOR
			if(light_state)
				light_state += "_open"
		if(AIRLOCK_OPENING)
			frame_state = AIRLOCK_FRAME_OPENING
			light_state = AIRLOCK_LIGHT_OPENING
			pre_light_color = AIRLOCK_ACCESS_LIGHT_COLOR

	. += get_airlock_overlay(frame_state, icon, src, em_block = TRUE)
	if(airlock_material)
		. += get_airlock_overlay("[airlock_material]_[frame_state]", glass_fill_overlays, src, em_block = TRUE)
	else
		. += get_airlock_overlay("fill_[frame_state + fill_state_suffix]", icon, src, em_block = TRUE)

	if(airlock_paint && color_overlays)
		. += get_airlock_overlay(frame_state, color_overlays, state_color = airlock_paint)
		if(!glass && has_fill_overlays)
			. += get_airlock_overlay("fill_[frame_state]", color_overlays, state_color = airlock_paint)

	if(stripe_paint && stripe_overlays)
		. += get_airlock_overlay(frame_state, stripe_overlays, state_color = stripe_paint)
		if(!glass && has_fill_overlays)
			. += get_airlock_overlay("fill_[frame_state]", stripe_overlays, state_color = stripe_paint)

	if(lights && hasPower() && has_environment_lights && light_state)
		. += get_airlock_overlay("lights_[light_state]", overlays_file, src, em_block = FALSE)
		. += emissive_appearance(overlays_file, "lights_[light_state]", src, alpha = src.alpha)

		if(multi_tile && filler)
			filler.set_light(l_range = AIRLOCK_LIGHT_RANGE, l_power = AIRLOCK_LIGHT_POWER, l_color = pre_light_color, l_on = TRUE)

		set_light(l_range = AIRLOCK_LIGHT_RANGE, l_power = AIRLOCK_LIGHT_POWER, l_color = pre_light_color, l_on = TRUE)
	else
		set_light(l_on = FALSE)

	if(greyscale_accent_color)
		. += get_airlock_overlay("[frame_state]_accent", overlays_file, src, em_block = TRUE, state_color = greyscale_accent_color)

	if(panel_open)
		. += get_airlock_overlay("panel_[frame_state][security_level ? "_protected" : null]", overlays_file, src, em_block = TRUE)
	if(frame_state == AIRLOCK_FRAME_CLOSED && welded)
		. += get_airlock_overlay("welded", overlays_file, src, em_block = TRUE)

	if(airlock_state == AIRLOCK_EMAG)
		. += get_airlock_overlay("sparks", overlays_file, src, em_block = FALSE)

	if(hasPower())
		if(frame_state == AIRLOCK_FRAME_CLOSED)
			if(atom_integrity < integrity_failure * max_integrity)
				. += get_airlock_overlay("sparks_broken", overlays_file, src, em_block = FALSE)
			else if(atom_integrity < (0.75 * max_integrity))
				. += get_airlock_overlay("sparks_damaged", overlays_file, src, em_block = FALSE)
		else if(frame_state == AIRLOCK_FRAME_OPEN)
			if(atom_integrity < (0.75 * max_integrity))
				. += get_airlock_overlay("sparks_open", overlays_file, src, em_block = FALSE)

	if(note)
		. += get_airlock_overlay(get_note_state(frame_state), note_overlay_file, src, em_block = TRUE)

	if(frame_state == AIRLOCK_FRAME_CLOSED && seal)
		. += get_airlock_overlay("sealed", overlays_file, src, em_block = TRUE)

	if(hasPower() && unres_sides)
		for(var/heading in GLOB.cardinals)
			if(!(unres_sides & heading))
				continue
			var/mutable_appearance/floorlight = mutable_appearance('icons/obj/doors/airlocks/station/overlays.dmi', "unres_[heading]", FLOAT_LAYER, src, ABOVE_LIGHTING_PLANE)
			switch (heading)
				if (NORTH)
					floorlight.pixel_x = 0
					floorlight.pixel_y = 32
				if (SOUTH)
					floorlight.pixel_x = 0
					floorlight.pixel_y = -32
				if (EAST)
					floorlight.pixel_x = 32
					floorlight.pixel_y = 0
				if (WEST)
					floorlight.pixel_x = -32
					floorlight.pixel_y = 0
			. += floorlight
