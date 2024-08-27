/datum/heretic_knowledge/ultimate/exile_final
	name = "Exile's Ascension"



/datum/heretic_knowledge/ultimate/exile_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)

	. = ..()

	user.add_traits(
		list(
			TRAIT_STUNIMMUNE,
			TRAIT_PIERCEIMMUNE,
			TRAIT_NODISMEMBER,
			TRAIT_PUSHIMMUNE,
			TRAIT_PERFECT_ATTACKER,
			TRAIT_NOGUNS,
			TRAIT_NEVER_WOUNDED
		),
		EXILE_ASCENSION_TRAIT
	)


	RegisterSignal(user, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(modify_damage))


/datum/heretic_knowledge/ultimate/exile_final/proc/modify_damage(mob/living/carbon/human/source, list/damage_mods, damage_amount, damagetype, def_zone, sharpness, attack_direction, obj/item/attacking_item)
	SIGNAL_HANDLER
	damage_amount *= 0.25 //75% resistances
