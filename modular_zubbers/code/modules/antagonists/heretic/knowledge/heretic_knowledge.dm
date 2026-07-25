/datum/heretic_knowledge
	var/combat_specialty = 0
	/// If not null, this will override the default shop drafting costs.
	var/drafting_cost
	/// If TRUE, will not trigger CI failures - this has been intentionally made unreachable.
	var/unreachable

/datum/heretic_knowledge/New()
	. = ..()

	// replacing items with harder ones
	for (var/atom/type as anything in required_atoms)
		if (ispath(type, /obj/item/knife))
			required_atoms -= type
			required_atoms[/obj/item/knife/kitchen] = 1

/datum/heretic_knowledge/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if (!.)
		return FALSE

	if (HAS_TRAIT(user, TRAIT_MANSUS_INHIBITION))
		loc.balloon_alert(user, "inhibited! can't perform ritual!")
		return FALSE
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	if (!heretic_datum)
		return FALSE
	if (heretic_datum.has_living_heart() != HERETIC_HAS_LIVING_HEART)
		loc.balloon_alert(user, "ritual failed, no living heart!")
		return FALSE
