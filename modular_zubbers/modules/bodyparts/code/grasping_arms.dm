#define PUNCH_LOW 5
#define PUNCH_HIGH 10
#define LIMB_MAX_HP_GRASPING 75
#define LIMB_BODY_DAMAGE_COEFFICIENT_GRASPING 0.5

/obj/item/bodypart/grasping/arm
	name = "Grasping Arm"
	desc = "A big ol' arm."
	/// The changing stance action given by the quirk. Nullable, if we have no owner.
	var/datum/action/innate/stance/change_stance
	/// Did our owner have their hands blocked before we ran on_adding? Used for determining if we should unblock their hand slots on removal.
	var/owner_blocked_hands_before_insert

/obj/item/bodypart/grasping/arm/Destroy()
	QDEL_NULL(change_stance) // handled in remove, but just to be safe
	return ..()

/obj/item/bodypart/grasping/arm/on_adding(mob/living/carbon/new_owner)
	. = ..()

	change_stance = new /datum/action/innate/stance(new_owner)
	change_stance.Grant(new_owner)

	owner_blocked_hands_before_insert = (new_owner.dna.species.no_equip_flags & ITEM_SLOT_HANDS)
	new_owner.dna.species.no_equip_flags |= ITEM_SLOT_HANDS
	new_owner.dna.species.modsuit_slot_exceptions |= ITEM_SLOT_HANDS

	var/obj/item/clothing/gloves = new_owner.get_item_by_slot(ITEM_SLOT_HANDS)
	if (gloves && !HAS_TRAIT(gloves, TRAIT_NODROP))
		gloves.forceMove(get_turf(new_owner))
	add

/// Adds mob traits to our owner.
/obj/item/bodypart/grasping/arm/proc/add_traits(mob/living/carbon/organ_owner = owner)
	ADD_TRAIT(organ_owner, TRAIT_CHUNKYFINGERS_IGNORE_BATON, ORGAN_TRAIT)
	ADD_TRAIT(organ_owner, TRAIT_NO_TWOHANDING, ORGAN_TRAIT)

/obj/item/bodypart/grasping/arm/on_removal(mob/living/carbon/old_owner)
	. = ..()

	if (!owner_blocked_hands_before_insert)
		organ_owner.dna.species.no_equip_flags &= ~ITEM_SLOT_HANDS
	owner_blocked_hands_before_insert = FALSE
	organ_owner.dna.species.modsuit_slot_exceptions &= ~ITEM_SLOT_HANDS

	REMOVE_TRAIT(organ_owner, TRAIT_CHUNKYFINGERS_IGNORE_BATON, ORGAN_TRAIT)
	REMOVE_TRAIT(organ_owner, TRAIT_NO_TWOHANDING, ORGAN_TRAIT)

/obj/item/bodypart/grasping/arm/left/mantis
	bodytype = BODYTYPE_ORGANIC
	icon = 'icons/mob/augmentation/advanced_augments.dmi'
	unarmed_damage_low = PUNCH_LOW
	unarmed_damage_high = PUNCH_HIGH
	unarmed_effectiveness = 20
	brute_modifier = 1
	burn_modifier = 1
	max_damage = LIMB_MAX_HP_GRASPING
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_GRASPING

/obj/item/bodypart/grasping/arm/right/mantis
	bodytype = BODYTYPE_ORGANIC
	icon = 'icons/mob/augmentation/advanced_augments.dmi'
	unarmed_damage_low = PUNCH_LOW
	unarmed_damage_high = PUNCH_HIGH
	unarmed_effectiveness = 20
	brute_modifier = 1
	burn_modifier = 1
	max_damage = LIMB_MAX_HP_GRASPING
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_GRASPING
