// This is it's own file because each of these needs a helper proc
/obj/vore_belly
	// Text
	var/list/digest_messages_pred
	var/list/digest_messages_prey
	var/list/absorb_messages_owner
	var/list/absorb_messages_prey
	var/list/unabsorb_messages_owner
	var/list/unabsorb_messages_prey
	var/list/struggle_messages_outside
	var/list/struggle_messages_inside
	var/list/absorbed_struggle_messages_outside
	var/list/absorbed_struggle_messages_inside
	var/list/escape_attempt_messages_owner
	var/list/escape_attempt_messages_prey
	var/list/escape_messages_owner
	var/list/escape_messages_prey
	var/list/escape_messages_outside
	var/list/escape_fail_messages_owner
	var/list/escape_fail_messages_prey

/// Formats a vore message
/obj/vore_belly/proc/format_message(message, mob/prey)
	message = replacetext(message, "%pred", owner.parent)
	message = replacetext(message, "%prey", prey)
	message = replacetext(message, "%belly", src)
	message = replacetext(message, "%count", LAZYLEN(contents))
	return message

/obj/vore_belly/proc/set_messages(key, value, delim = "\n\n")
	var/list/raw_list = value
	if(istext(value))
		// Give a bunch of overhead length for the message to make sure we don't mangle the important messages
		raw_list = splittext(STRIP_HTML_SIMPLE(value, MAX_VORE_MESSAGE_LENGTH * 20), delim)

	if(!islist(raw_list))
		return

	if(LAZYLEN(raw_list) > 10)
		raw_list.Cut(11)

	// We use a lazylist here because we want our values being set to null if our data is empty / all invalid
	var/list/sanitized_list = null
	for(var/i in 1 to LAZYLEN(raw_list))
		if(length(raw_list[i]) > MAX_VORE_MESSAGE_LENGTH)
			// Ignore over-length messages
			to_chat(usr, span_warning("Warning: Message [i] (\"[STRIP_HTML_SIMPLE(raw_list[i], 20)]...\") deleted due to being too long (must be < [MAX_VORE_MESSAGE_LENGTH])"))
		else if(length(raw_list[i]) < MIN_VORE_MESSAGE_LENGTH)
			// Ignore under-length messages
			to_chat(usr, span_warning("Warning: Message [i] (\"[STRIP_HTML_SIMPLE(raw_list[i], 20)]...\") deleted due to being too short (must be > [MIN_VORE_MESSAGE_LENGTH])"))
		else
			LAZYADD(sanitized_list, STRIP_HTML_SIMPLE(raw_list[i], MAX_VORE_MESSAGE_LENGTH))

	// All of these shorthand strings aren't explicitly used in our code
	// but are present to make translating Vore 3.0 code easier
	switch(key)
		if("digest_messages_pred", "dmo")
			digest_messages_pred = sanitized_list
		if("digest_messages_prey", "dmp")
			digest_messages_prey = sanitized_list
		if("absorb_messages_owner", "amo")
			absorb_messages_owner = sanitized_list
		if("absorb_messages_prey", "amp")
			absorb_messages_prey = sanitized_list
		if("unabsorb_messages_owner", "uamo")
			unabsorb_messages_owner = sanitized_list
		if("unabsorb_messages_prey", "uamp")
			unabsorb_messages_prey = sanitized_list
		if("struggle_messages_outside", "smo")
			struggle_messages_outside = sanitized_list
		if("struggle_messages_inside", "smi")
			struggle_messages_inside = sanitized_list
		if("absorbed_struggle_messages_outside", "asmo")
			absorbed_struggle_messages_outside = sanitized_list
		if("absorbed_struggle_messages_inside", "asmi")
			absorbed_struggle_messages_inside = sanitized_list
		if("escape_attempt_messages_owner", "escao")
			escape_attempt_messages_owner = sanitized_list
		if("escape_attempt_messages_prey", "escap")
			escape_attempt_messages_prey = sanitized_list
		if("escape_messages_owner", "esco")
			escape_messages_owner = sanitized_list
		if("escape_messages_prey", "escp")
			escape_messages_prey = sanitized_list
		if("escape_messages_outside", "escout")
			escape_messages_outside = sanitized_list
		if("escape_fail_messages_owner", "escfo")
			escape_fail_messages_owner = sanitized_list
		if("escape_fail_messages_prey", "escfp")
			escape_fail_messages_prey = sanitized_list

// All the getters
/obj/vore_belly/proc/get_digest_messages_pred(mob/prey)
	if(LAZYLEN(digest_messages_pred))
		return format_message(pick(digest_messages_pred), prey)
	return format_message(pick(GLOB.digest_messages_pred), prey)

/obj/vore_belly/proc/get_digest_messages_prey(mob/prey)
	if(LAZYLEN(digest_messages_prey))
		return format_message(pick(digest_messages_prey), prey)
	return format_message(pick(GLOB.digest_messages_prey), prey)

/obj/vore_belly/proc/get_absorb_messages_owner(mob/prey)
	if(LAZYLEN(absorb_messages_owner))
		return format_message(pick(absorb_messages_owner), prey)
	return format_message(pick(GLOB.absorb_messages_owner), prey)

/obj/vore_belly/proc/get_absorb_messages_prey(mob/prey)
	if(LAZYLEN(absorb_messages_prey))
		return format_message(pick(absorb_messages_prey), prey)
	return format_message(pick(GLOB.absorb_messages_prey), prey)

/obj/vore_belly/proc/get_unabsorb_messages_owner(mob/prey)
	if(LAZYLEN(unabsorb_messages_owner))
		return format_message(pick(unabsorb_messages_owner), prey)
	return format_message(pick(GLOB.unabsorb_messages_owner), prey)

/obj/vore_belly/proc/get_unabsorb_messages_prey(mob/prey)
	if(LAZYLEN(unabsorb_messages_prey))
		return format_message(pick(unabsorb_messages_prey), prey)
	return format_message(pick(GLOB.unabsorb_messages_prey), prey)

/obj/vore_belly/proc/get_struggle_messages_outside(mob/prey)
	if(LAZYLEN(struggle_messages_outside))
		return format_message(pick(struggle_messages_outside), prey)
	return format_message(pick(GLOB.struggle_messages_outside), prey)

/obj/vore_belly/proc/get_struggle_messages_inside(mob/prey)
	if(LAZYLEN(struggle_messages_inside))
		return format_message(pick(struggle_messages_inside), prey)
	return format_message(pick(GLOB.struggle_messages_inside), prey)

/obj/vore_belly/proc/get_absorbed_struggle_messages_outside(mob/prey)
	if(LAZYLEN(absorbed_struggle_messages_outside))
		return format_message(pick(absorbed_struggle_messages_outside), prey)
	return format_message(pick(GLOB.absorbed_struggle_messages_outside), prey)

/obj/vore_belly/proc/get_absorbed_struggle_messages_inside(mob/prey)
	if(LAZYLEN(absorbed_struggle_messages_inside))
		return format_message(pick(absorbed_struggle_messages_inside), prey)
	return format_message(pick(GLOB.absorbed_struggle_messages_inside), prey)

/obj/vore_belly/proc/get_escape_attempt_messages_owner(mob/prey)
	if(LAZYLEN(escape_attempt_messages_owner))
		return format_message(pick(escape_attempt_messages_owner), prey)
	return format_message(pick(GLOB.escape_attempt_messages_owner), prey)

/obj/vore_belly/proc/get_escape_attempt_messages_prey(mob/prey)
	if(LAZYLEN(escape_attempt_messages_prey))
		return format_message(pick(escape_attempt_messages_prey), prey)
	return format_message(pick(GLOB.escape_attempt_messages_prey), prey)

/obj/vore_belly/proc/get_escape_messages_owner(mob/prey)
	if(LAZYLEN(escape_messages_owner))
		return format_message(pick(escape_messages_owner), prey)
	return format_message(pick(GLOB.escape_messages_owner), prey)

/obj/vore_belly/proc/get_escape_messages_prey(mob/prey)
	if(LAZYLEN(escape_messages_prey))
		return format_message(pick(escape_messages_prey), prey)
	return format_message(pick(GLOB.escape_messages_prey), prey)

/obj/vore_belly/proc/get_escape_messages_outside(mob/prey)
	if(LAZYLEN(escape_messages_outside))
		return format_message(pick(escape_messages_outside), prey)
	return format_message(pick(GLOB.escape_messages_outside), prey)

/obj/vore_belly/proc/get_escape_fail_messages_owner(mob/prey)
	if(LAZYLEN(escape_fail_messages_owner))
		return format_message(pick(escape_fail_messages_owner), prey)
	return format_message(pick(GLOB.escape_fail_messages_owner), prey)

/obj/vore_belly/proc/get_escape_fail_messages_prey(mob/prey)
	if(LAZYLEN(escape_fail_messages_prey))
		return format_message(pick(escape_fail_messages_prey), prey)
	return format_message(pick(GLOB.escape_fail_messages_prey), prey)
