/**
 * Checks if the target has antag datums and, if so,
 * are they allowed to be Ghouled, or not, or banned.
 * Args:
 * target - The person we check for antag datums.
 */
/datum/antagonist/bloodsucker/proc/AmValidAntag(mob/target)
	if(HAS_TRAIT(target, TRAIT_UNCONVERTABLE))
		return GHOULING_BANNED

	var/ghouling_status = GHOULING_ALLOWED
	for(var/datum/antagonist/antag_datum as anything in target.mind.antag_datums)
		if(antag_datum.type in ghoul_banned_antags)
			return GHOULING_BANNED
		ghouling_status = GHOULING_DISLOYAL
	return ghouling_status

/**
 * # can_make_ghoul
 * Checks if the person is allowed to turn into the Bloodsucker's
 * Ghoul, ensuring they are a player and valid.
 * If they are a Ghoul themselves, will check if their master
 * has broken the Masquerade, to steal them.
 * Args:
 * conversion_target - Person being ghouled
 */
/datum/antagonist/bloodsucker/proc/can_make_ghoul(mob/living/conversion_target)
	if(!iscarbon(conversion_target) || (conversion_target.stat < CONSCIOUS))
		return FALSE
	// No Mind!
	if(!conversion_target.mind)
		to_chat(owner.current, span_danger("[conversion_target] isn't self-aware enough to be made into a Ghoul."))
		return FALSE
	if(AmValidAntag(conversion_target) == GHOULING_BANNED)
		to_chat(owner.current, span_danger("[conversion_target] resists the power of your blood to dominate their mind!"))
		return FALSE
	var/mob/living/master = conversion_target.mind.enslaved_to?.resolve()
	if(!master || (master == owner.current))
		return TRUE
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(master)
	if(bloodsuckerdatum && bloodsuckerdatum.broke_masquerade)
		//ghoul stealing
		return TRUE
	to_chat(owner.current, span_danger("[conversion_target]'s mind is overwhelmed with too much external force to put your own!"))
	return FALSE

/**
 * First will check if the target can be turned into a Ghoul, if so then it will
 * turn them into one, log it, sync their minds, then updates the Rank
 * Args:
 * conversion_target - The person converted.
 */
/datum/antagonist/bloodsucker/proc/make_ghoul(mob/living/conversion_target)
#ifndef BLOODSUCKER_TESTING
	if(!can_make_ghoul(conversion_target))
		return FALSE
#endif
	//Check if they used to be a Ghoul and was stolen.
	var/datum/antagonist/ghoul/old_ghoul = IS_GHOUL(conversion_target)
	if(old_ghoul)
		conversion_target.mind.remove_antag_datum(/datum/antagonist/ghoul)

	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner.current)
	bloodsuckerdatum.SelectTitle(am_fledgling = FALSE)

	//set the master, then give the datum.
	var/datum/antagonist/ghoul/ghouldatum = new(conversion_target.mind)
	ghouldatum.master = bloodsuckerdatum
	conversion_target.mind.add_antag_datum(ghouldatum)

	message_admins("[conversion_target] has become a Ghoul, and is enslaved to [owner.current].")
	log_admin("[conversion_target] has become a Ghoul, and is enslaved to [owner.current].")
	return TRUE

/*
 *	# can_make_special
 *
 * MIND Helper proc that ensures the person can be a Special Ghoul,
 * without actually giving the antag datum to them.
 * This is because Special Ghouls get special abilities, without the unique Bloodsucker blood tracking,
 * and we don't want this to be infinite.
 * Args:
 * creator - Person attempting to convert them.
 */
/datum/mind/proc/can_make_special(datum/mind/creator)
	return TRUE

/// Check if this is a valid person to actually be a bloodsucker
/datum/mind/proc/is_valid_bloodsucker()
	if(has_antag_datum(/datum/antagonist/bloodsucker))
		return FALSE
	if(!(current.mob_biotypes & MOB_ORGANIC))
		stack_trace("Somehow tried to give [current] a bloodsucker datum, when they did not have the MOB_ORGANIC biotype. ")
		return FALSE
	// While the antag can function without the mob itself having no blood, it doesn't make sense.
	if(HAS_TRAIT(src, TRAIT_NOBLOOD))
		stack_trace("Somehow tried to give [current] a bloodsucker datum, when they had TRAIT_NOBLOOD. ")
		return FALSE
	return TRUE

/*
 *	# make_bloodsucker
 *
 * MIND Helper proc that turns the person into a Bloodsucker
 * Args:
 * creator - Person attempting to convert them.
 */
/datum/mind/proc/make_bloodsucker(datum/mind/creator)
	if(!is_valid_bloodsucker())
		return FALSE
	var/datum/antagonist/bloodsuckerdatum = add_antag_datum(/datum/antagonist/bloodsucker)
	if(bloodsuckerdatum && creator)
		message_admins("[src] has become a Bloodsucker, and was created by [creator].")
		log_admin("[src] has become a Bloodsucker, and was created by [creator].")
	return bloodsuckerdatum
