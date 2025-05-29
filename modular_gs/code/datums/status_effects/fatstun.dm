// Cba making a define file just for status effects so all the helper stuff goes here!~
#define STATUS_EFFECT_FATSTUN /datum/status_effect/incapacitating/stun/fat //the affected is knocked down

////
// Makes it so player is stunned and while stunned, fatness level grows.
////
/datum/status_effect/incapacitating/stun/fat
	var/fatAmount = 1

/datum/status_effect/incapacitating/stun/fat/on_creation(mob/living/new_owner, set_duration, updating_canmove, fatnessAmount)
	fatAmount = fatnessAmount
	..()

/datum/status_effect/incapacitating/stun/fat/tick()
	var/mob/living/carbon/C = owner
	if(C)
		C.adjust_fatness(fatAmount, FATTENING_TYPE_ITEM) // simply adds/removes the fat overtime.
	// to_chat(owner, "You feel larger...") // debugging to see if the stun works.

////
// Helpers so it applies to the mob. (I cannot be bothered making a new file for this AUGH)
////
/mob/proc/IsFatStunned() //non-living mobs shouldn't be stunned
	return FALSE

/mob/living/IsFatStunned() //If we're knocked down
	return has_status_effect(STATUS_EFFECT_FATSTUN)

/mob/living/proc/AmountFatStunned() //How many deciseconds remain in our knockdown
	var/datum/status_effect/incapacitating/stun/fat/F = IsFatStunned()
	if(F)
		return F.duration - world.time
	return FALSE

/mob/living/proc/FatStun(amount, updating = TRUE, ignore_canstun = FALSE, fatAmount)
	if(((status_flags & CANSTUN) && !HAS_TRAIT(src, TRAIT_STUNIMMUNE)) || ignore_canstun)
		var/datum/status_effect/incapacitating/stun/fat/F = IsFatStunned()
		if(F)
			F.duration = max(world.time + amount, F.duration)
		else if(amount > 0)
			F = apply_status_effect(STATUS_EFFECT_FATSTUN, amount, updating, fatAmount)
		return F

/mob/living/proc/SetFatStun(amount, updating = TRUE, ignore_canstun = FALSE) //Sets remaining duration
	if(((status_flags & CANSTUN) && !HAS_TRAIT(src, TRAIT_STUNIMMUNE)) || ignore_canstun)
		var/datum/status_effect/incapacitating/stun/fat/F = IsFatStunned()
		if(amount <= 0)
			if(F)
				qdel(F)
		else
			if(F)
				F.duration = world.time + amount
			else
				F = apply_status_effect(STATUS_EFFECT_FATSTUN, amount, updating)
		return F

/mob/living/proc/AdjustFatStun(amount, updating = TRUE, ignore_canstun = FALSE) //Adds to remaining duration
	if(((status_flags & CANSTUN) && !HAS_TRAIT(src, TRAIT_STUNIMMUNE)) || ignore_canstun)
		var/datum/status_effect/incapacitating/stun/fat/F = IsFatStunned()
		if(F)
			F.duration += amount
		else if(amount > 0)
			F = apply_status_effect(STATUS_EFFECT_FATSTUN, amount, updating)
		return F
