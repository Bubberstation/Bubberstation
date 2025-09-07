/// I need to completely refactor all of this. None of it works because realistically making a new /item/bodypart doesn't work. I'd have to go the way of taurs and make it an overlay.
/obj/item/bodypart/arm/grasping
	name = "Grasping Arm"
	desc = "A big ol' arm."
	/// Did our owner have their hands blocked before we ran on_adding? Used for determining if we should unblock their hand slots on removal.
	var/owner_blocked_hands_before_insert

/obj/item/bodypart/arm/grasping/on_adding(mob/living/carbon/new_owner)
	. = ..()

	owner_blocked_hands_before_insert = (new_owner.dna.species.no_equip_flags & ITEM_SLOT_HANDS)
	new_owner.dna.species.no_equip_flags |= ITEM_SLOT_HANDS
	new_owner.dna.species.modsuit_slot_exceptions |= ITEM_SLOT_HANDS

	var/obj/item/clothing/gloves = new_owner.get_item_by_slot(ITEM_SLOT_HANDS)
	if (gloves && !HAS_TRAIT(gloves, TRAIT_NODROP))
		gloves.forceMove(get_turf(new_owner))

/obj/item/bodypart/arm/grasping/on_removal(mob/living/carbon/old_owner)
	. = ..()

	if (!owner_blocked_hands_before_insert)
		old_owner.dna.species.no_equip_flags &= ~ITEM_SLOT_HANDS
	owner_blocked_hands_before_insert = FALSE
	old_owner.dna.species.modsuit_slot_exceptions &= ~ITEM_SLOT_HANDS

//Mantis
/obj/item/bodypart/arm/grasping/left/mantishigh
	bodytype = BODYTYPE_ORGANIC
	icon_static = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	icon = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	unarmed_damage_low = 20
	unarmed_damage_high = 20
	unarmed_effectiveness = 20
	brute_modifier = 1
	burn_modifier = 1.2
	max_damage = 75
	body_damage_coeff = 0.5
	unarmed_attack_verbs = list("slash", "tear", "slice", "lacerate", "rip", "dice", "cut", "rend")
	grappled_attack_verb = "lacerate"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
	unarmed_sharpness = SHARP_EDGED
	bodypart_traits = list(TRAIT_CHUNKYFINGERS_IGNORE_BATON, TRAIT_NO_TWOHANDING)

/obj/item/bodypart/arm/grasping/left/mantis
	bodytype = BODYTYPE_ORGANIC
	icon_static = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	icon = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	unarmed_damage_low = 5
	unarmed_damage_high = 10
	unarmed_effectiveness = 10
	brute_modifier = 0.9
	burn_modifier = 1.2
	max_damage = 75
	body_damage_coeff = 0.5
	bodypart_traits = list(TRAIT_CHUNKYFINGERS_IGNORE_BATON, TRAIT_NO_TWOHANDING)

/obj/item/bodypart/arm/grasping/right/mantishigh
	bodytype = BODYTYPE_ORGANIC
	icon_static = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	icon = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	unarmed_damage_low = 20
	unarmed_damage_high = 20
	unarmed_effectiveness = 20
	brute_modifier = 1
	burn_modifier = 1.2
	max_damage = 75
	body_damage_coeff = 0.5
	unarmed_attack_verbs = list("slash", "tear", "slice", "lacerate", "rip", "dice", "cut", "rend")
	grappled_attack_verb = "lacerate"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
	unarmed_sharpness = SHARP_EDGED
	bodypart_traits = list(TRAIT_CHUNKYFINGERS_IGNORE_BATON, TRAIT_NO_TWOHANDING)

/obj/item/bodypart/arm/grasping/right/mantis
	bodytype = BODYTYPE_ORGANIC
	icon_static = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	icon = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	unarmed_damage_low = 5
	unarmed_damage_high = 10
	unarmed_effectiveness = 10
	brute_modifier = 0.9
	burn_modifier = 1.2
	max_damage = 75
	body_damage_coeff = 0.5
	bodypart_traits = list(TRAIT_CHUNKYFINGERS_IGNORE_BATON, TRAIT_NO_TWOHANDING)

//Crab
/obj/item/bodypart/arm/grasping/left/crab
	bodytype = BODYTYPE_ORGANIC
	icon_static = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	icon = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	unarmed_damage_low = PUNCH_LOW
	unarmed_damage_high = PUNCH_HIGH
	unarmed_effectiveness = 20
	brute_modifier = 1
	burn_modifier = 1
	max_damage = LIMB_MAX_HP_GRASPING
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_GRASPING

/obj/item/bodypart/arm/grasping/right/crab
	bodytype = BODYTYPE_ORGANIC
	icon_static = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	icon = 'modular_zubbers/modules/bodyparts/icons/grasping_arms.dmi'
	unarmed_damage_low = PUNCH_LOW
	unarmed_damage_high = PUNCH_HIGH
	unarmed_effectiveness = 20
	brute_modifier = 1
	burn_modifier = 1
	max_damage = LIMB_MAX_HP_GRASPING
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_GRASPING
