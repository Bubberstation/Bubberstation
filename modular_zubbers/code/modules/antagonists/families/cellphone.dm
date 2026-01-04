/obj/item/radio/gangphone
	name = "Cellphone"
	desc = "The new upgraded model which changed nothing"
	icon = 'icons/obj/antags/gang/cell_phone.dmi'
	icon_state = "phone_off"
	throwforce = 15 // these things are dense as fuck
	canhear_range = 0
	radio_noise = FALSE
	var/gang_id = null

/obj/item/radio/gangphone/Initialize(mapload)
	. = ..()
	set_on(FALSE)
	set_listening(FALSE)
	set_broadcasting(FALSE)

/obj/item/radio/gangphone/talk_into_impl(atom/movable/talking_movable, message, channel, list/spans, datum/language/language, list/message_mods)
	if(!gang_id)
		return

	if(!is_on() || !talking_movable || !message)
		return
	if(wires?.is_cut(WIRE_TX))
		return
	if(!talking_movable.try_speak(message, ignore_spam = TRUE, filterproof = TRUE))
		return

	var/formatted = span_gangradio("<b>[talking_movable.name]</b> \[CELL: [gang_id]\] says, \"[message]\"")

	// Deliver to matching phones
	for(var/obj/item/radio/gangphone/cellphone in world)
		if(cellphone.gang_id != gang_id)
			continue
		if(!isliving(cellphone.loc))
			continue

		var/mob/living/listener = cellphone.loc
		to_chat(listener, formatted)

/obj/item/radio/gangphone/attack_self(mob/user)
	toggle_phone(user)
	return TRUE

/obj/item/radio/gangphone/proc/toggle_phone(mob/user)
	if(is_on())
		set_on(FALSE)
		icon_state = "phone_off"
		to_chat(user, span_notice("You turn off the cellphone."))
	else
		set_on(TRUE)
		icon_state = "phone_on"
		to_chat(user, span_notice("You turn on the cellphone."))

	update_icon()

