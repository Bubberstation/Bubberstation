/obj/item/scrap/bait_emag
	icon_state = "bait_emag"
	name = /obj/item/card/emag::name
	desc = /obj/item/card/emag::desc
	worn_icon = /obj/item/card/emag::worn_icon
	worn_icon_state = /obj/item/card/emag::worn_icon_state
	slot_flags = ITEM_SLOT_ID
	var/use_attempted = FALSE
	var/obj/item/radio/radio

/obj/item/scrap/bait_emag/randomize_credit_cost()
	return rand(10, 25)

/// Set up to snitch here
/obj/item/scrap/bait_emag/Initialize(mapload)
	. = ..()
	radio = new /obj/item/radio(src)
	radio.set_listening(FALSE)

/obj/item/scrap/bait_emag/Destroy(force)
	QDEL_NULL(radio)
	return ..()

/obj/item/scrap/bait_emag/examine(mob/user)
	. = ..()
	. += span_warning("There's no way this is real... right?")


/obj/item/scrap/bait_emag/attack_self(mob/user) //for assistants with balls of iron
	if(Adjacent(user))
		user.visible_message(span_notice("[user] shows you: [icon2html(src, viewers(user))] [name]."), span_notice("You show [src]."))
	add_fingerprint(user)


/obj/item/scrap/bait_emag/update_overlays()
	. = ..()
	var/datum/id_trim/picked_trim = pick(subtypesof(/datum/id_trim))
	. += mutable_appearance(picked_trim.trim_icon, picked_trim.trim_state)


/obj/item/scrap/bait_emag/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(use_attempted)
		balloon_alert(user, "used up!")
		return ITEM_INTERACT_BLOCKING
	/// 1% chance to actually emag something
	if(prob(1))
		log_combat(user, interacting_with, "managed to use bait emag")
		if(interacting_with.emag_act(user, src))
			SSblackbox.record_feedback("tally", "atom_emagged", 1, interacting_with.type)
	// 99% chance to also alert security in the process
	if(prob(99))
		log_combat(user, interacting_with, "was caught by bait emag")
		radio.set_frequency(FREQ_SECURITY)
		radio.talk_into(src, "SECURITY ALERT: Crewmember [user] recorded attempting illict activity in [get_area(src)]. Please watch for seditious behavior.", FREQ_SECURITY)
		remove_radio_all(radio) //so we dont keep transmitting sec comms
	use_attempted = TRUE
	return ITEM_INTERACT_SUCCESS
