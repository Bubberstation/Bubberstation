/datum/quirk/grasping_arms
	name = "Grasping Arms"
	desc = "You have particularly bulky, solid arms, good for both punching and blocking. Might make grabbing large objects difficult, however."
	value = 10
	mob_trait = list(TRAIT_CHUNKYFINGERS_IGNORE_BATON, TRAIT_NO_TWOHANDING)
	medical_record_text = "Patient's arms are covered in hard exoskeleton, and seem particularly suited for hunting."
	icon = FA_ICON_SHAPES
	/// The slot to replace, in GLOB.limb_zones
	var/limb_zone

/datum/quirk_constant_data/grasping_arms
	associated_typepath = /datum/quirk/grasping_arms
	customization_options = list(/datum/preference/choiced/arms)

/datum/quirk/item_quirk/grasping_arms/add_unique(client/client_source)
	var/obj/item/bodypart/limb_type = GLOB.grasping_arms_choice[client_source?.prefs?.read_preference(/datum/preference/choiced/prosthetic)]
	if(isnull(limb_type))  //Client gone or they chose a random option
		limb_type = GLOB.grasping_arms_choice[pick(GLOB.grasping_arms_choice)]
	limb_zone = limb_type.body_zone

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/bodypart/large = new limb_type()
	human_holder.del_and_replace_bodypart(large, special = TRUE)

/datum/quirk/grasping_arms/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.reset_to_original_bodypart(limb_zone)

// Lets handle item interactions
/datum/quirk/grasping_arms/proc/on_owner_equipping_item(mob/living/carbon/human/owner, obj/item/pick_item)
	SIGNAL_HANDLER
	if((pick_item.w_class > WEIGHT_CLASS_BULKY) && !(pick_item.item_flags & ABSTRACT|HAND_ITEM))
		pick_item.balloon_alert(owner, "arms too large to wield!")
		return COMPONENT_LIVING_CANT_PUT_IN_HAND
