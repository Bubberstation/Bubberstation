/**
 * Favorite Ghoul
 *
 * Gets some cool abilities depending on the Clan.
 */
/datum/antagonist/ghoul/favorite
	name = "\improper Favorite Ghoul"
	antag_hud_name = "ghoul6"
	special_type = FAVORITE_GHOUL
	ghoul_description = "The Favorite Ghoul gets unique abilities over other Ghouls depending on the Master's Clan \
		and becomes completely immune to Mindshields. If part of Ventrue, this is the Ghoul a Bloodsucker will rank up."

	///Bloodsucker levels, but for Ghouls, used by Ventrue. Used for ventrue creating a new bloodsucker.
	var/ghoul_level
	/// Power's we're going to inherit once we turn into a Bloodsucker
	var/list/bloodsucker_powers = list()

/datum/antagonist/ghoul/favorite/on_gain()
	. = ..()
	SEND_SIGNAL(master, COMSIG_BLOODSUCKER_MAKE_FAVORITE, src)

/datum/antagonist/ghoul/favorite/on_removal()
	SEND_SIGNAL(master, COMSIG_BLOODSUCKER_LOOSE_FAVORITE, src)
	remove_powers(bloodsucker_powers)
	. = ..()

/datum/antagonist/ghoul/favorite/pre_mindshield(mob/implanter, mob/living/mob_override)
	return COMPONENT_MINDSHIELD_RESISTED
