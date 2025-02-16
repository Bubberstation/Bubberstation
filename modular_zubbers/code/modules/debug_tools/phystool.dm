/obj/item/phystool
	name = "Toolgun"
	desc = "Some kind of a revolver with a bluespace power cell and an anomaly core attached together."
	icon = 'modular_zubbers/icons/obj/equipment/architector_items.dmi'
	icon_state = "toolgun"
	inhand_icon_state = "toolgun"
	worn_icon_state = "toolgun"
	worn_icon = 'modular_zubbers/icons/mob/inhands/architector_items_belt.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/architector_items_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/architector_items_righthand.dmi'
	demolition_mod = 0.5
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 1
	throw_range = 1
	drop_sound = 'sound/items/handling/tools/screwdriver_drop.ogg'
	pickup_sound = 'modular_zubbers/sound/phystools/toolgun_select.ogg'
	resistance_flags = INDESTRUCTIBLE


	/// The mode that is chosen at the moment
	var/datum/phystool_mode/selected_mode
	/// Available modes
	var/list/datum/phystool_mode/available_modes = list(
		/datum/phystool_mode/build_mode,
		/datum/phystool_mode/spawn_mode,
		/datum/phystool_mode/remove_mode,
		/datum/phystool_mode/color_mode,
		/datum/phystool_mode/size_mode,
	)
	/// The datum of the beam
	var/datum/beam/work_beam

/obj/item/phystool/examine(mob/user)
	. = ..()
	. += span_notice("Use ALT + LMB on the device to choose the mode.")
	if(!selected_mode)
		. += span_notice("No selected mode!")
		return
	. += span_notice(selected_mode.desc)

/obj/item/phystool/click_alt(mob/user)
	. = ..()
	if(selected_mode)
		qdel(selected_mode)
	var/datum/phystool_mode/mode_to_select = tgui_input_list(user, "Select work mode:", "Phystool mode", available_modes)
	if(!mode_to_select)
		return
	selected_mode = new mode_to_select
	selected_mode.on_selected(user)
	playsound(user, 'modular_zubbers/sound/phystools/toolgun_select.ogg', 100, TRUE)

/obj/item/phystool/attack_self(mob/user)
	. = ..()
	if(!selected_mode)
		return
	selected_mode.use_act(user)

/obj/item/phystool/ranged_interact_with_atom(atom/target, mob/user, list/modifiers)
	. = ..()
	if(!selected_mode)
		return
	if(!selected_mode.main_act(target, user))
		playsound(user, 'modular_zubbers/sound/phystools/toolgun_error.ogg', 100, TRUE)
		return
	do_work_effect(target, user)
	playsound(user, 'modular_zubbers/sound/phystools/toolgun_shot1.ogg', 100, TRUE)

/obj/item/phystool/ranged_interact_with_atom_secondary(atom/target, mob/user, proximity_flag, list/modifiers)
	. = ..()
	if(!selected_mode)
		return
	if(!selected_mode.secondnary_act(target, user))
		playsound(user, 'modular_zubbers/sound/phystools/toolgun_error.ogg', 100, TRUE)
		return
	do_work_effect(target, user)
	playsound(user, 'modular_zubbers/sound/phystools/toolgun_shot1.ogg', 100, TRUE)

/obj/item/phystool/proc/do_work_effect(atom/target, mob/user)
	if(!target)
		return
	work_beam = user.Beam(target, "light_beam", time = 3)
