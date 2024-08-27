/datum/heretic_knowledge/blade_upgrade/exile
	name = "Mansus Grasp Blade Augmentation"
	desc = "Attacking someone with your Mansus Grasp active will now also apply all upgraded effects of Mansus Grasp on the target."
	gain_text = "Multitasking is essential to having more."
	next_knowledge = list(
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/flask_purchase,
		/datum/heretic_knowledge/unfathomable_curio,
		/datum/heretic_knowledge/painting,
	)

	cost = 1
	depth = 4
	route = PATH_EXILE

	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_blade"




/datum/heretic_knowledge/blade_upgrade/blade/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)

	var/obj/item/melee/touch_attack/mansus_fist/off_hand = source.get_inactive_held_item()

	if(QDELETED(off_hand) || !istype(off_hand))
		return

	SEND_SIGNAL(source, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, target)