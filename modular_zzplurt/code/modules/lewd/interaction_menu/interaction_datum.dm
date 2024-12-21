/datum/interaction/proc/allow_act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target == user && usage == INTERACTION_OTHER)
		return FALSE

	if(user_required_parts.len)
		for(var/slot in user_required_parts)
			if(!user.has_genital(LAZYACCESS(user_required_parts, slot) || REQUIRE_GENITAL_EXPOSED, slot))
				return FALSE

	if(target_required_parts.len)
		for(var/slot in target_required_parts)
			if(!target.has_genital(LAZYACCESS(target_required_parts, slot) || REQUIRE_GENITAL_EXPOSED, slot))
				return FALSE

	for(var/requirement in interaction_requires)
		switch(requirement)
			if(INTERACTION_REQUIRE_SELF_HAND)
				if(!user.get_active_hand())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_HAND)
				if(!target.get_active_hand())
					return FALSE
			if(INTERACTION_REQUIRE_SELF_MOUTH)
				if(!user.get_bodypart(BODY_ZONE_PRECISE_MOUTH) || user.is_mouth_covered())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_MOUTH)
				if(!target.get_bodypart(BODY_ZONE_PRECISE_MOUTH) || target.is_mouth_covered())
					return FALSE
			if(INTERACTION_REQUIRE_SELF_TOPLESS)
				if(!user.is_topless())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_TOPLESS)
				if(!target.is_topless())
					return FALSE
			if(INTERACTION_REQUIRE_SELF_BOTTOMLESS)
				if(!user.is_bottomless())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_BOTTOMLESS)
				if(!target.is_bottomless())
					return FALSE
			if(INTERACTION_REQUIRE_SELF_FEET)
				if(!(user.has_feet() >= (LAZYACCESS(user_required_parts, INTERACTION_REQUIRE_SELF_FEET) || 2))) //We prolly don't need to care if it's exposed or not
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_FEET)
				if(!(target.has_feet() >= (LAZYACCESS(target_required_parts, INTERACTION_REQUIRE_TARGET_FEET) || 2)))
					return FALSE
			else
				CRASH("Unimplemented interaction requirement '[requirement]'")
	return TRUE
