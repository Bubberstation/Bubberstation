// TODO - per-path passive costs

/datum/heretic_knowledge/passive_upgrade
	abstract_type = /datum/heretic_knowledge/passive_upgrade
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "cosmic_blade"
	var/level

/datum/heretic_knowledge/passive_upgrade/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	our_heretic.passive_level = level

/datum/heretic_knowledge/passive_upgrade/one
	name = "Passive - Level One"
	desc = "PLACEHOLDER GIves level one passive"
	level = 1
	cost = 1

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
	cost = 2

/datum/heretic_knowledge/passive_upgrade/two/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	SEND_SIGNAL(our_heretic, COMSIG_HERETIC_PASSIVE_UPGRADE_FIRST)

/datum/heretic_knowledge/passive_upgrade/three
	name = "Passive - Level Three"
	desc = "PLACEHOLDER GIves level three passive"
	level = 3
	cost = 3

/datum/heretic_knowledge/passive_upgrade/three/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	SEND_SIGNAL(our_heretic, COMSIG_HERETIC_PASSIVE_UPGRADE_FINAL)

/datum/heretic_knowledge_tree_column/void
	passive_upgrade1 = /datum/heretic_knowledge/passive_upgrade/one/void
	passive_upgrade2 = /datum/heretic_knowledge/passive_upgrade/two/void
	passive_upgrade3 = /datum/heretic_knowledge/passive_upgrade/three/void

/datum/heretic_knowledge/passive_upgrade/one/void
	research_tree_icon_state = "void_blade"
	desc = "Grants you immunity to cold and low pressure."
	cost = 2

/datum/heretic_knowledge/passive_upgrade/two/void
	research_tree_icon_state = "void_blade"
	desc = "Makes you not need to breathe."
	cost = 1

/datum/heretic_knowledge/passive_upgrade/three/void
	research_tree_icon_state = "void_blade"
	desc = "You can no longer slip on any surface."
	cost = 2

//moon
/datum/heretic_knowledge_tree_column/moon
	passive_upgrade1 = /datum/heretic_knowledge/passive_upgrade/one/moon
	passive_upgrade2 = /datum/heretic_knowledge/passive_upgrade/two/moon
	passive_upgrade3 = /datum/heretic_knowledge/passive_upgrade/three/moon

/datum/heretic_knowledge/passive_upgrade/one/moon
	research_tree_icon_state = "moon_blade"
	desc = "Gain immunity to brain trauma, and regenerate brain damage passively."
	cost = 2

/datum/heretic_knowledge/passive_upgrade/two/moon
	research_tree_icon_state = "moon_blade"
	desc = "Grants sleep immunity, and improves your passive brain regeneration."
	cost = 2

/datum/heretic_knowledge/passive_upgrade/three/moon
	research_tree_icon_state = "moon_blade"
	desc = "Mind gate and Ringleader's rise will channel the moon amulet effects, further inreases brain regeneration."
	cost = 2

//flesh
/datum/heretic_knowledge_tree_column/flesh
	passive_upgrade1 = /datum/heretic_knowledge/passive_upgrade/one/flesh
	passive_upgrade2 = /datum/heretic_knowledge/passive_upgrade/two/flesh
	passive_upgrade3 = /datum/heretic_knowledge/passive_upgrade/three/flesh

/datum/heretic_knowledge/passive_upgrade/one/flesh
	research_tree_icon_state = "flesh_blade"
	desc = "Gain immunity to diseases, disgust, and space ants."
	cost = 0.5

/datum/heretic_knowledge/passive_upgrade/two/flesh
	research_tree_icon_state = "flesh_blade"
	desc = "Eating organs or meat now heals you, gain the voracious and gluttonous trait and being fat doesn't slow you down."
	cost = 2

/datum/heretic_knowledge/passive_upgrade/three/flesh
	research_tree_icon_state = "flesh_blade"
	desc = "Gain a flat 25% damage and stamina damage reduction when fat as well as baton resistance."
	cost = 2

//lock
/datum/heretic_knowledge_tree_column/lock
	passive_upgrade1 = /datum/heretic_knowledge/passive_upgrade/one/lock
	passive_upgrade2 = /datum/heretic_knowledge/passive_upgrade/two/lock
	passive_upgrade3 = /datum/heretic_knowledge/passive_upgrade/three/lock

/datum/heretic_knowledge/passive_upgrade/one/lock
	research_tree_icon_state = "key_blade"
	desc = "Gain shock immunity."
	cost = 1

/datum/heretic_knowledge/passive_upgrade/two/lock
	research_tree_icon_state = "key_blade"
	desc = "Gain x-ray vision."
	cost = 3 // thjis is so strong

/datum/heretic_knowledge/passive_upgrade/three/lock
	research_tree_icon_state = "key_blade"
	desc = "Grasp no longer goes on cooldown when used to open a door or locker."
	cost = 1
