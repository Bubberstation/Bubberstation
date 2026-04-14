/obj/item/breastpump
	name = "breast pump"
	icon = 'modular_skyrat/modules/hyposprays/icons/hypokits.dmi'
	icon_state = "hypo2"
	greyscale_config = /datum/greyscale_config/hypospray_mkii
	desc = "A breast pump, designed to take beakers to help assist lactating patients."
	w_class = WEIGHT_CLASS_SMALL
	/// Only allowed to input beaker type objects
	var/list/allowed_containers = list(/obj/item/reagent_containers/cup/beaker)
	/// The presently-inserted beaker.
	var/obj/item/reagent_containers/cup/beaker/beaker

	/// Can you hotswap beakers? - Yes
	var/quickload = TRUE
	/// Does it penetrate clothing? - We probably want it to be used with clothing
	var/penetrates = null
	/// The original icon file where our overlays reside.
	var/original_icon = 'modular_skyrat/modules/hyposprays/icons/hypokits.dmi'

/obj/item/breastpump/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
/*
/obj/item/breastpump/update_overlays()
	. = ..()
	update_overlays()
	. = ..()
	if(!beaker)
		return
	if(beaker.reagents.total_volume)
		var/beaker_spritetype = "chem-color"
		if(istype(beaker, /obj/item/reagent_containers/cup/beaker/large))
			vial_spritetype += "[beaker.type_suffix]"
		else
			vial_spritetype += "-s"
		var/mutable_appearance/chem_loaded = mutable_appearance(original_icon, vial_spritetype)
		chem_loaded.color = vial.chem_color
		. += chem_loaded
	if(vial.greyscale_colors != null)
		var/mutable_appearance/vial_overlay = mutable_appearance(original_icon, "[vial.icon_state]-body")
		vial_overlay.color = vial.greyscale_colors
		. += vial_overlay
		var/mutable_appearance/vial_overlay_glass = mutable_appearance(original_icon, "[vial.icon_state]-glass")
		. += vial_overlay_glass
	else
		var/mutable_appearance/vial_overlay = mutable_appearance(original_icon, vial.icon_state)
		. += vial_overlay
*/

/obj/item/breastpump/examine(mob/user)
	. = ..()
	if(beaker)
		. += "[beaker] contains [beaker.reagents.total_volume]u of liquids."
	else
		. += "It has no beaker loaded in."

/obj/item/breastpump/proc/unload_beaker(obj/object, mob/user)
	if((istype(object, /obj/item/reagent_containers/cup/beaker)))
		var/obj/item/reagent_containers/cup/beaker/container = object
		container.forceMove(user.loc)
		user.put_in_hands(container)
		to_chat(user, span_notice("You remove [object] from [src]."))
		beaker = null
		update_icon()
		playsound(loc, 'sound/items/weapons/empty.ogg', 50, 1)
	else
		to_chat(user, span_notice("This beaker isn't loaded!"))
		return

/obj/item/breastpump/proc/insert_beaker(obj/item/new_beaker, mob/living/user)
	if(!is_type_in_list(new_beaker, allowed_containers))
		to_chat(user, span_notice("[src] doesn't accept this type of beaker."))
		return FALSE
	var/atom/quickswap_loc = new_beaker.loc
	if(!user.transferItemToLoc(new_beaker, src))
		return FALSE
	if(!isnull(beaker))
		if(quickswap_loc == user)
			user.put_in_hands(beaker)
		else
			beaker.forceMove(quickswap_loc)
	beaker = new_beaker
	user.visible_message(span_notice("[user] has loaded a beaker into [src]."), span_notice("You have loaded [beaker] into [src]."))
	playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)
	update_appearance()

/obj/item/breastpump/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/reagent_containers/cup/beaker))
		return NONE
	if(isnull(beaker) || quickload)
		insert_beaker(tool, user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("[src] can not hold more than one beaker!"))
	return ITEM_INTERACT_BLOCKING

/*

/obj/item/reagent_containers/breastpump/attack_self(mob/user)
	. = ..()
	if(vial)
		vial.attack_self(user)
		return TRUE

/obj/item/reagent_containers/breastpump/attack_self_secondary(mob/user)
	. = ..()
	if(vial)
		vial.attack_self_secondary(user)
		return TRUE

/obj/item/reagent_containers/breastpump/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/item/reagent_containers/cup/vial))
		insert_vial(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	return do_inject(interacting_with, user, mode=HYPO_SPRAY)

/obj/item/reagent_containers/breastpump/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	return do_inject(interacting_with, user, mode=HYPO_INJECT)

/obj/item/reagent_containers/breastpump/proc/do_inject(mob/living/injectee, mob/living/user, mode)
	if(!isliving(injectee))
		return NONE

	if(!injectee.reagents || !injectee.can_inject(user, user.zone_selected, penetrates))
		return NONE

	if(iscarbon(injectee))
		var/obj/item/bodypart/affecting = injectee.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("The limb is missing!"))
			return ITEM_INTERACT_BLOCKING
	//Always log attemped injections for admins
	var/contained = vial.reagents.get_reagent_log_string()
	log_combat(user, injectee, "attemped to inject", src, addition="which had [contained]")

	if(!vial)
		to_chat(user, span_notice("[src] doesn't have any vial installed!"))
		return ITEM_INTERACT_BLOCKING
	if(!vial.reagents.total_volume)
		to_chat(user, span_notice("[src]'s vial is empty!"))
		return ITEM_INTERACT_BLOCKING

	var/fp_verb = mode == HYPO_SPRAY ? "spray" : "inject"

	if(injectee != user)
		injectee.visible_message(span_danger("[user] is trying to [fp_verb] [injectee] with [src]!"), \
						span_userdanger("[user] is trying to [fp_verb] you with [src]!"))

	var/selected_wait_time
	if(injectee == user)
		selected_wait_time = (mode == HYPO_INJECT) ? inject_self : spray_self
	else
		selected_wait_time = (mode == HYPO_INJECT) ? inject_wait : spray_wait

	if(!do_after(user, selected_wait_time, injectee, extra_checks = CALLBACK(injectee, /mob/living/proc/can_inject, user, user.zone_selected, penetrates)))
		return ITEM_INTERACT_BLOCKING
	if(!vial || !vial.reagents.total_volume)
		return ITEM_INTERACT_BLOCKING
	log_attack("<font color='red'>[user.name] ([user.ckey]) applied [src] to [injectee.name] ([injectee.ckey]), which had [contained] (COMBAT MODE: [uppertext(user.combat_mode)]) (MODE: [mode])</font>")
	if(injectee != user)
		injectee.visible_message(span_danger("[user] uses the [src] on [injectee]!"), \
						span_userdanger("[user] uses the [src] on you!"))
	else
		injectee.log_message("<font color='orange'>applied [src] to themselves ([contained]).</font>", LOG_ATTACK)

	switch(mode)
		if(HYPO_INJECT)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this, methods = INJECT)
		if(HYPO_SPRAY)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this, methods = PATCH)

	var/long_sound = vial.amount_per_transfer_from_this >= 15
	playsound(loc, long_sound ? 'modular_skyrat/modules/hyposprays/sound/hypospray_long.ogg' : pick('modular_skyrat/modules/hyposprays/sound/hypospray.ogg','modular_skyrat/modules/hyposprays/sound/hypospray2.ogg'), 50, 1, -1)
	to_chat(user, span_notice("You [fp_verb] [vial.amount_per_transfer_from_this] units of the solution. The hypospray's cartridge now contains [vial.reagents.total_volume] units."))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

*/

/obj/item/breastpump/attack_hand(mob/living/user)
	if(user && loc == user && user.is_holding(src))
		if(user.incapacitated)
			return
		else if(!beaker)
			. = ..()
			return
		else
			unload_beaker(beaker,user)
	else
		. = ..()

/obj/item/breastpump/examine(mob/user)
	. = ..()
	. += span_notice("<b>Left-Click</b> on yourself to SUCC, <b>Right-Click</b> to inject.")


