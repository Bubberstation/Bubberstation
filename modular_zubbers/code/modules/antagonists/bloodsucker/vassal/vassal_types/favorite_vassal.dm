/**
 * Favorite Vassal
 *
 * Gets some cool abilities depending on the Clan.
 */
/datum/antagonist/vassal/favorite
	name = "\improper Favorite Vassal"
	antag_hud_name = "vassal6"
	special_type = FAVORITE_VASSAL
	vassal_description = "The Favorite Vassal gets unique abilities over other Vassals depending on your Clan \
		and becomes completely immune to Mindshields. If part of Ventrue, this is the Vassal you will rank up."

	///Bloodsucker levels, but for Vassals, used by Ventrue.
	var/vassal_level
	/// Power's we're going to inherit once we turn into a Bloodsucker
	var/list/bloodsucker_powers = list()

/datum/antagonist/vassal/favorite/on_gain()
	. = ..()
	SEND_SIGNAL(master, BLOODSUCKER_MAKE_FAVORITE, src)

/datum/antagonist/vassal/favorite/on_removal()
	SEND_SIGNAL(master, BLOODSUCKER_LOOSE_FAVORITE, src)
	. = ..()

/datum/antagonist/vassal/favorite/pre_mindshield(mob/implanter, mob/living/mob_override)
	return COMPONENT_MINDSHIELD_RESISTED

///Set the Vassal's rank to their Bloodsucker level
/datum/antagonist/vassal/favorite/proc/set_vassal_level(mob/living/carbon/human/target)
	vassal_level = master.GetRank()
