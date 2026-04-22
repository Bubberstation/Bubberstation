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
	to_chat(user, span_warning("[src] is only able to hold one beaker!"))
	return ITEM_INTERACT_BLOCKING



// Must be used on self only, to prevent abuse
/obj/item/reagent_containers/breastpump/attack_self(mob/user)
	. = ..()
	if(beaker)
		beaker.attack_self(user)
		return TRUE

// Breast Pump Workflow Processor
/obj/item/breastpump/process(seconds_per_tick, mob/living/user)
	//Get the breasts
	var/obj/item/organ/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)

	if(!breasts || !breasts.lactates || !user)
		return FALSE

	// Hard stop at 120 so it doesn't go forever
	if(beaker.reagents.total_volume == 120)
		return FALSE

	retrieve_liquids_from_breasts(seconds_per_tick)
	increase_current_mob_arousal(seconds_per_tick)

	return TRUE

/obj/item/breastpump/proc/retrieve_liquids_from_breasts(seconds_per_tick, mob/living/user)
	var/obj/item/organ/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
	var/fluid_multiplier = 1

	if(user.has_status_effect(/datum/status_effect/climax))
		fluid_multiplier = 2

	if(!beaker || breasts.reagents.total_volume <= 0)
		return FALSE

	breasts.reagents.trans_to(beaker, 1 * fluid_multiplier * seconds_per_tick)
	return TRUE

// Handling the process of the impact of the machine on the organs of the mob
/obj/item/breastpump/proc/increase_current_mob_arousal(seconds_per_tick, mob/living/user)
	var/mob/living/carbon/human/producer = user
	producer.adjust_arousal(1 * seconds_per_tick)
	producer.adjust_pleasure(0.2 * seconds_per_tick)


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


