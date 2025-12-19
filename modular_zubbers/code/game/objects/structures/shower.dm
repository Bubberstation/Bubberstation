/// Run the shower for SHOWER_TIMED_LENGTH time, or until we run out of reagents.
#define SHOWER_MODE_TIMED 1
/// How long we run in TIMED mode
#define SHOWER_TIMED_LENGTH (15 SECONDS)
// Temperatures
#define SHOWER_FREEZING "freezing"
#define SHOWER_NORMAL "normal"
#define SHOWER_BOILING "boiling"

/obj/machinery/shower
	mode = SHOWER_MODE_TIMED

// Restart the shower idle timer if someone is still using it, washing up or otherwise
/obj/machinery/shower/proc/shower_occupied()
	for(var/mob/living/carbon/showerer in loc)
		COOLDOWN_START(src, timed_cooldown, SHOWER_TIMED_LENGTH)
		return TRUE

	return FALSE

// Adjust the shower temperature, but only to the safe temperatures. You need a screwdriver to get spicy.
/obj/machinery/shower/click_ctrl(mob/user)
	switch(current_temperature)
		if(SHOWER_NORMAL)
			current_temperature = SHOWER_FREEZING
		if(SHOWER_FREEZING)
			current_temperature = SHOWER_NORMAL
		if(SHOWER_BOILING)
			current_temperature = SHOWER_NORMAL
	balloon_alert(user, "set to [current_temperature]")
	user.visible_message(span_notice("[user] adjusts the shower."), span_notice("You adjust the shower temperature to [current_temperature]."))
	user.log_message("has wrenched a shower to [current_temperature].", LOG_ATTACK)
	add_hiddenprint(user)
	handle_mist()
	return CLICK_ACTION_SUCCESS

#undef SHOWER_MODE_TIMED
#undef SHOWER_TIMED_LENGTH
#undef SHOWER_FREEZING
#undef SHOWER_NORMAL
#undef SHOWER_BOILING
