/datum/heretic_knowledge/passive_upgrade
	abstract_type = /datum/heretic_knowledge/passive_upgrade
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "cosmic_blade"
	var/level
	cost = 3

/datum/heretic_knowledge/passive_upgrade/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	our_heretic.passive_level = level

/datum/heretic_knowledge/passive_upgrade/one
	name = "Passive - Level One"
	desc = "PLACEHOLDER GIves level one passive"
	level = 1

/datum/heretic_knowledge/passive_upgrade/one/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	if (!isliving(user))
		return

	var/mob/living/living_user = user
	living_user.apply_status_effect(our_heretic.heretic_path.start.eldritch_passive)

/datum/heretic_knowledge/passive_upgrade/two
	name = "Passive - Level Two"
	desc = "PLACEHOLDER GIves level two passive"
	level = 2

/datum/heretic_knowledge/passive_upgrade/two/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	SEND_SIGNAL(our_heretic, COMSIG_HERETIC_PASSIVE_UPGRADE_FIRST)

/datum/heretic_knowledge/passive_upgrade/three
	name = "Passive - Level Three"
	desc = "PLACEHOLDER GIves level three passive"
	level = 3

/datum/heretic_knowledge/passive_upgrade/three/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	SEND_SIGNAL(our_heretic, COMSIG_HERETIC_PASSIVE_UPGRADE_FINAL)
