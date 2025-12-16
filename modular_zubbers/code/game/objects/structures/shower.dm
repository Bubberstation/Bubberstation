/// Run the shower for SHOWER_TIMED_LENGTH time, or until we run out of reagents.
#define SHOWER_MODE_TIMED 1
/// How long we run in TIMED mode
#define SHOWER_TIMED_LENGTH (15 SECONDS)

/obj/machinery/shower
	mode = SHOWER_MODE_TIMED

// Restart the shower idle timer if someone is still using it, washing up or otherwise
/obj/machinery/shower/proc/shower_occupied()
	for(var/mob/living/carbon/showerer in loc)
		COOLDOWN_START(src, timed_cooldown, SHOWER_TIMED_LENGTH)
		return TRUE

	return FALSE

#undef SHOWER_MODE_TIMED
#undef SHOWER_TIMED_LENGTH
