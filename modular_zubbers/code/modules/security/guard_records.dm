/datum/record/crew
	/// Whether the current arrest status was set by a departmental guard.
	var/wanted_status_set_by_guard = FALSE

/datum/record/crew/proc/set_wanted_status(new_status, mob/user)
	wanted_status = new_status
	wanted_status_set_by_guard = (new_status == WANTED_ARREST) && is_department_guard(user)

/datum/record/crew/proc/get_latest_valid_crime_reason()
	for(var/i in length(crimes) to 1 step -1)
		var/datum/crime/crime = crimes[i]
		if(!crime.valid)
			continue
		return get_guard_wanted_reason(crime)
	return "No reason provided"

/datum/record/crew/proc/get_guard_wanted_reason(datum/crime/crime)
	if(!crime)
		return "No reason provided"
	if(crime.details && crime.details != "No details provided.")
		return "[crime.name]: [crime.details]"
	if(crime.name)
		return crime.name
	return crime.details ? crime.details : "No reason provided"

/proc/is_department_guard(mob/user)
	var/mob/living/living_user = user
	if(!istype(living_user))
		return FALSE
	var/obj/item/card/id/id_card = living_user.get_idcard(FALSE)
	return istype(id_card?.trim, /datum/id_trim/job/guard)

/obj/machinery/computer/records/security/allowed(mob/accessor)
	if(is_department_guard(accessor))
		return TRUE
	return ..()

/obj/machinery/computer/records/security/proc/announce_guard_wanted_status(datum/record/crew/target, mob/user, reason, old_wanted_status)
	if(old_wanted_status == WANTED_ARREST || target.wanted_status != WANTED_ARREST || !is_department_guard(user))
		return

	var/guard_name = user.real_name ? user.real_name : user.name
	var/obj/item/radio/radio = new(src)
	radio.keyslot = new /obj/item/encryptionkey/headset_sec
	radio.set_listening(FALSE)
	radio.recalculateChannels()
	radio.talk_into(src, "[target.name] has been set to wanted by Guard [guard_name], for the reason [reason]!", RADIO_CHANNEL_SECURITY)
	QDEL_IN(radio, 5 SECONDS)
