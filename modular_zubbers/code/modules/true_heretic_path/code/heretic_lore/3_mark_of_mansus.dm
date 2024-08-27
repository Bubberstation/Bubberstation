/datum/heretic_knowledge/blade_upgrade/exile
	name = "Mansus Grasp Blade Augmentation"
	desc = "Attacking someone with your Mansus Grasp active will now also apply all upgraded effects of Mansus Grasp on the target."
	gain_text = "I found him cleaved in twain, halves locked in a duel without end; \
		a flurry of blades, neither hitting their mark, for the Champion was indomitable."
	next_knowledge = list(/datum/heretic_knowledge/spell/furious_steel)
	route = PATH_BLADE
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_blade"


/datum/heretic_knowledge/blade_upgrade/blade/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)

	var/obj/item/melee/touch_attack/mansus_fist/off_hand = source.get_inactive_held_item()

	if(QDELETED(off_hand) || !istype(off_hand))
		return

	SEND_SIGNAL(source, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, target)