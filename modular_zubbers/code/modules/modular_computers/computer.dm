#define ALERT_RELEVANCY_SAFE 0 /// * 0: User is not in immediate danger and not needed for some station-critical task.
#define ALERT_RELEVANCY_WARN 1 /// * 1: Danger is around, but the user is not directly needed to handle it.
#define ALERT_RELEVANCY_PERTINENT 2/// * 2: Danger is around and the user is responsible for handling it.
/obj/item/modular_computer/get_security_level_relevancy()
	switch(SSsecurity_level.get_current_level_as_number())
		if(SEC_LEVEL_VIOLET)
			if(ACCESS_MEDICAL in stored_id?.access)
				return ALERT_RELEVANCY_PERTINENT
			else
				return ALERT_RELEVANCY_WARN
		if(SEC_LEVEL_ORANGE)
			if(ACCESS_ENGINEERING in stored_id?.access)
				return ALERT_RELEVANCY_PERTINENT
			else
				return ALERT_RELEVANCY_SAFE
		if(SEC_LEVEL_AMBER)
			if(ACCESS_SECURITY in stored_id?.access)
				return ALERT_RELEVANCY_PERTINENT
			else
				return ALERT_RELEVANCY_WARN
		if(SEC_LEVEL_BLUE) // do this even though the base function already covers blue -- this is cause we operate differently from blue (blue = sec prep on bubber, = sec active on tg)
			if(ACCESS_SECURITY in stored_id?.access)
				return ALERT_RELEVANCY_PERTINENT
			else
				return ALERT_RELEVANCY_SAFE
		if(SEC_LEVEL_EPSILON)
			return ALERT_RELEVANCY_PERTINENT
		if(SEC_LEVEL_GAMMA)
			return ALERT_RELEVANCY_PERTINENT
		else
			return ..()

#undef ALERT_RELEVANCY_SAFE
#undef ALERT_RELEVANCY_WARN
#undef ALERT_RELEVANCY_PERTINENT
