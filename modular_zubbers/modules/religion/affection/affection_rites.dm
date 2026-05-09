/datum/religion_rites/upgrade_favor_gain
	name = "Upgrade favor gain"
	desc = "Increase the amount of favor you gain when people show you affection."
	ritual_length = (5 SECONDS)
	ritual_invocations = list("Look upon the people who have shown me appreciation with their touch.")
	invoke_msg = "Let their gentle touch empower me!"
	favor_cost = 10
	rite_flags = RITE_AUTO_DELETE
	var/datum/religion_sect/affection/sect

/datum/religion_rites/upgrade_favor_gain/New()
	sect = GLOB.religious_sect
	if(isnull(sect))
		CRASH("A rite used for the affection sect was used with a different sect!")
	favor_cost = sect.favor_gain_upgrade_cost
	. = ..()

/datum/religion_rites/upgrade_favor_gain/get_favor_cost()
	return sect.favor_gain_upgrade_cost

/datum/religion_rites/upgrade_favor_gain/invoke_effect(mob/living/user, atom/religious_tool)
	..()
	if (isnull(sect))
		return FALSE
	sect.favor_gain++
	sect.favor_gain_upgrade_cost *= 2
	return TRUE


