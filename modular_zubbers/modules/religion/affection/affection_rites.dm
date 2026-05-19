#define UPGRADE_PRICE_MULTIPLIER 1.5

/datum/religion_rites/upgrade_favor_gain
	name = "Upgrade favor gain"
	desc = "Increase the amount of favor you gain when people show you affection by 1. every upgrade increases the cost of this by 50%"
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
	sect.favor_gain_upgrade_cost = floor(sect.favor_gain_upgrade_cost * UPGRADE_PRICE_MULTIPLIER)
	return TRUE

#undef UPGRADE_PRICE_MULTIPLIER


/datum/religion_rites/summon_call_necklace
	name = "Summon call necklace"
	desc = "Summons a necklace imbued with divine energy, capable of summoning the chaplain to the wearer's location"
	ritual_length = (10 SECONDS)
	ritual_invocations = list("Look upon the people who have shown me appreciation with their touch.",
	"Allow me to reciprocate their affection!",
	"Allow me to be there when they need me most")
	invoke_msg = "Grant me a trinket to keep them safe!"
	favor_cost = 25

/datum/religion_rites/summon_call_necklace/invoke_effect(mob/living/user, atom/religious_tool)
	. = ..()
	var/obj/item/clothing/neck/affection_necklace/new_necklace = new(get_turf(religious_tool))
	new_necklace.chaplain_ref = WEAKREF(user)
