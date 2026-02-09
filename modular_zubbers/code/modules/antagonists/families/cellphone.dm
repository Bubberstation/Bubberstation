/obj/item/radio/gangphone
	name = "Cellphone"
	desc = "TODO: funny joke about the 80s, brick phones"
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

/obj/item/radio/gangphone/examine(mob/user)
	var/list/lines = ..()
	for (var/i = lines.len; i >= 1; i--)
		if (findtext(lines[i], "It is set to broadcast over the") || findtext(lines[i], "attached"))
			lines.Cut(i, i + 1)
	if (!isnull(gang_id))
		lines += span_notice("When turned on, it will broadcast to other active phones of your gang.")
		lines += span_notice("You can speak into it by holding it in your hand and using the .r or .l prefix")
	return lines
