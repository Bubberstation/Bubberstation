/obj/structure/stripper_pole
	name = "stripper pole"
	desc = "A pole fastened to the ceiling and floor, used to show of one's goods to company."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/dancing_pole.dmi'
	icon_state = "pole_purple_off"
	base_icon_state = "pole"
	density = TRUE
	anchored = TRUE
	max_integrity = 75
	layer = BELOW_MOB_LAYER
	pseudo_z_axis = 9 //stepping onto the pole makes you raise upwards!
	density = 0 //easy to step up on
	light_system = STATIC_LIGHT
	light_range = 3
	light_power = 1
	light_color = COLOR_LIGHT_PINK
	light_on = FALSE
	/// Are the animated lights enabled?
	var/lights_enabled = FALSE
	/// The mob currently using the pole to dance
	var/mob/living/dancer = null
	/// The selected pole color
	var/current_pole_color = "purple"
	/// Possible designs for the pole, populating a radial selection menu
	var/static/list/pole_designs
	/// Possible colors for the pole
	var/static/list/pole_lights = list(
								"purple" = COLOR_LIGHT_PINK,
								"cyan" = COLOR_CYAN,
								"red" = COLOR_RED,
								"green" = COLOR_GREEN,
								"white" = COLOR_WHITE,
								)


/obj/structure/stripper_pole/examine(mob/user)
	. = ..()
	. += "The lights are currently <b>[lights_enabled ? "ON" : "OFF"]</b> and could be [lights_enabled ? "dis" : "en"]abled with <b>Alt-Click</b>."


/// The list of possible designs generated for the radial reskinning menu
/obj/structure/stripper_pole/proc/populate_pole_designs()
	pole_designs = list(
		"purple" = image(icon = src.icon, icon_state = "pole_purple_on"),
		"cyan" = image(icon = src.icon, icon_state = "pole_cyan_on"),
		"red" = image(icon = src.icon, icon_state = "pole_red_on"),
		"green" = image(icon = src.icon, icon_state = "pole_green_on"),
		"white" = image(icon = src.icon, icon_state = "pole_white_on"),
	)


/obj/structure/stripper_pole/multitool_act(mob/living/user, obj/item/used_item)
	. = ..()
	if(.)
		return
	var/choice = show_radial_menu(user, src, pole_designs, radius = 50, require_near = TRUE)
	if(!choice)
		return FALSE
	current_pole_color = choice
	light_color = pole_lights[choice]
	update_icon()
	update_brightness()
	return TRUE


// Alt-click to turn the lights on or off.
/obj/structure/stripper_pole/AltClick(mob/user)
	lights_enabled = !lights_enabled
	balloon_alert(user, "lights [lights_enabled ? "on" : "off"]")
	playsound(user, lights_enabled ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
	update_icon_state()
	update_icon()
	update_brightness()


/obj/structure/stripper_pole/Initialize(mapload)
	. = ..()
	update_icon_state()
	update_icon()
	update_brightness()
	if(!length(pole_designs))
		populate_pole_designs()


/obj/structure/stripper_pole/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_pole_color]_[lights_enabled ? "on" : "off"]"

/// Turns off/on the pole's ambient light source
/obj/structure/stripper_pole/proc/update_brightness()
	set_light_on(lights_enabled)
	update_light()


//trigger dance if character uses LBM
/obj/structure/stripper_pole/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(obj_flags & IN_USE)
		balloon_alert(user, "already in use!")
		return
	obj_flags |= IN_USE
	dancer = user
	user.setDir(SOUTH)
	user.Stun(10 SECONDS)
	user.forceMove(loc)
	user.visible_message(pick(span_purple("[user] dances on [src]!"), span_purple("[user] flexes their hip-moving skills on [src]!")))
	dance_animate(user)
	obj_flags &= ~IN_USE
	user.pixel_y = 0
	user.pixel_z = pseudo_z_axis //incase we are off it when we jump on!
	dancer = null

/// The proc used to make the user 'dance' on the pole. Basically just consists of pixel shifting them around a bunch and sleeping. Could probably be improved a lot.
/obj/structure/stripper_pole/proc/dance_animate(mob/living/user)
	if(user.loc != src.loc)
		return
	if(!QDELETED(src))
		animate(user, pixel_x = -6, pixel_y = 0, time = 10)
		sleep(2 SECONDS)
		user.dir = 4
	if(!QDELETED(src))
		animate(user, pixel_x = -6, pixel_y = 24, time = 10)
		sleep(1.2 SECONDS)
		src.layer = 4.01 //move the pole infront for now. better to move the pole, because the character moved behind people sitting above otherwise
	if(!QDELETED(src))
		animate(user, pixel_x = 6, pixel_y = 12, time = 5)
		user.dir = 8
		sleep(0.6 SECONDS)
	if(!QDELETED(src))
		animate(user, pixel_x = -6, pixel_y = 4, time = 5)
		user.dir = 4
		src.layer = 4 // move it back.
		sleep(0.6 SECONDS)
	if(!QDELETED(src))
		user.dir = 1
		animate(user, pixel_x = 0, pixel_y = 0, time = 3)
		sleep(0.6 SECONDS)
	if(!QDELETED(src))
		user.do_jitter_animation()
		sleep(0.6 SECONDS)
		user.dir = 2


/obj/structure/stripper_pole/Destroy()
	. = ..()
	if(dancer)
		dancer.SetStun(0)
		dancer.pixel_y = 0
		dancer.pixel_x = 0
		dancer.pixel_z = pseudo_z_axis
		dancer.layer = layer
		dancer.forceMove(get_turf(src))
		dancer = null


/obj/item/polepack
	name = "stripper pole flatpack"
	desc = "A flatpack containing a stripper pole. You could use a <b>wrench</b> to assemble it."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/dancing_pole.dmi'
	icon_state = "pole_base"
	w_class = WEIGHT_CLASS_HUGE


/obj/item/polepack/wrench_act(mob/living/user, obj/item/used_item, params) //erecting a pole here.
	. = ..()
	add_fingerprint(user)
	if(item_flags & IN_INVENTORY || item_flags & IN_STORAGE)
		return
	balloon_alert(user, "assembling...")
	if(!used_item.use_tool(src, user, 8 SECONDS, volume = 50))
		balloon_alert(user, "interrupted!")
		return
	balloon_alert(user, "assembled")
	new /obj/structure/stripper_pole(get_turf(user))
	qdel(src)
	return TRUE


/obj/structure/stripper_pole/wrench_act(mob/living/user, obj/item/used_item, params) //un-erecting a pole.
	. = ..()
	add_fingerprint(user)
	balloon_alert(user, "disassembling...")
	if(!used_item.use_tool(src, user, 8 SECONDS, volume = 50))
		balloon_alert(user, "interrupted!")
		return
	balloon_alert(user, "disassembled")
	new /obj/item/polepack(get_turf(user))
	qdel(src)
	return TRUE
