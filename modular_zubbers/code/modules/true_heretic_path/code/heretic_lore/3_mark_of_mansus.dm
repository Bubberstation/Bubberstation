/datum/heretic_knowledge/blade_upgrade/exile
	name = "Mansus Grasp Blade Augmentation"
	desc = "Attacking with your heretical blade and your Mansus Grasp active will now also apply your \
	researched effects (not the base ones) of Mansus Grasp on the target."

	gain_text = "Multitasking is essential to having more."

	next_knowledge = list(
		/datum/heretic_knowledge/access_belt,
		/datum/heretic_knowledge/reroll_targets/exile
	)

	cost = 1
	depth = 4
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "autograsp"




/datum/heretic_knowledge/blade_upgrade/exile/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)

	var/obj/item/melee/touch_attack/mansus_fist/off_hand = source.get_inactive_held_item()

	if(QDELETED(off_hand) || !istype(off_hand))
		return

	SEND_SIGNAL(source, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, target)