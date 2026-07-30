/datum/heretic_knowledge/feast_of_owls
	is_starting_knowledge = FALSE
	abstract_type = /datum/heretic_knowledge/feast_of_owls

/datum/heretic_knowledge/spell/cloak_of_shadows
	is_starting_knowledge = FALSE
	drafting_tier = 1
	drafting_cost = 0.5

/datum/heretic_knowledge/enable_blades
	name = "Khopesh Crafting"
	desc = "Enables you to craft your path's blade. The blades are very robust and have good armor pen, but can't block and can NOT be used to teleport."
	gain_text = "The time for subterfuge is over. The Light casts too much a shadow - I cannot hide anymore. Their eyes must be sown shut."
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "eldritch_blade"
	cost = 2

/datum/heretic_knowledge/enable_blades/can_be_invoked(datum/antagonist/heretic/invoker)
	return FALSE

/datum/heretic_knowledge/enable_blades/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	our_heretic.can_craft_blades = TRUE

/datum/heretic_knowledge/mansus_mark
	name = "Mansus Mark"
	desc = "Enables your path's marking ability on mansus grasp. Your mark is a secondary ability caused by your mansus grasp, that, when triggered \
	by your khopesh, causes a variety of effects to your victim."
	gain_text = "The Mansus left a mark on me. I will leave one on them."
	research_tree_icon_path = 'icons/obj/weapons/hand.dmi'
	research_tree_icon_state = "mansus"
	cost = 2

/datum/heretic_knowledge/mansus_mark/can_be_invoked(datum/antagonist/heretic/invoker)
	return FALSE

/datum/heretic_knowledge/mansus_mark/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	our_heretic.mark_enabled = TRUE

/datum/heretic_knowledge/limited_amount/starting/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/heretic = GET_HERETIC(user)
	if (!istype(heretic))
		return FALSE

	if (!heretic.can_craft_blades)
		loc.balloon_alert(user, "haven't researched blade crafting!")
		return FALSE

	return ..()

/datum/heretic_knowledge/limited_amount/starting/proc/should_create_mark(mob/living/source, mob/living/target)
	var/datum/antagonist/heretic/heretic = GET_HERETIC(source)
	if (!istype(heretic))
		return FALSE

	return heretic.mark_enabled
