/// This is a special subtype of mob_holder that *spawns with a mob included* instead of being created by scooping a mob.
/// It can override the name & description of the included mob as well.
/obj/item/clothing/head/mob_holder/pet
	// Path to the mob that should be spawned on initialization.
	var/mob/living/starting_pet
	// Tracks if a custom name has been provided that should override the mob's default.
	var/renamed = FALSE
	// Tracks if a custom description has been provided that should override the mob's default.
	var/redescribed = FALSE

/obj/item/clothing/head/mob_holder/pet/Initialize(mapload, mob/living/M, worn_state, head_icon, lh_icon, rh_icon, worn_slot_flags = NONE)
	held_mob = new starting_pet(src)
	if(renamed)
		held_mob.name = name
	if(redescribed)
		held_mob.desc = desc

	return ..(get_turf(src), held_mob, held_mob.held_state, held_mob.head_icon, held_mob.held_lh, held_mob.held_rh, held_mob.worn_slot_flags)

/// If this gets renamed, make sure to paste the new name onto the mob as well.
/// If, for whatever reason, this gets called before Initialize, it also sets renamed = TRUE to ensure that the mob gets the custom name on initialization.
/obj/item/clothing/head/mob_holder/pet/on_loadout_custom_named()
	. = ..()
	renamed = TRUE
	if(held_mob != null)
		held_mob.name = name

/// See above.
/obj/item/clothing/head/mob_holder/pet/on_loadout_custom_described()
	. = ..()
	redescribed = TRUE
	if(held_mob != null)
		held_mob.desc = desc

/// == DONATOR PET: Mr. Fluff, Central's Mothroach, ckey centralsmith ==
/mob/living/basic/mothroach/mr_fluff
	name = "Mr. Fluff"
	desc = "Central's beloved pet mothroach, Mr. Fluff. He looks so happy to be here!"
	gender = MALE
	icon = 'modular_zubbers/icons/mob/donator_pets.dmi'
	icon_state = "mr_fluff"
	icon_living = "mr_fluff"
	icon_dead = "mr_fluff_dead"

/obj/item/clothing/head/mob_holder/pet/donator/centralsmith
	name = "Mr. Fluff"
	desc = "Central's beloved pet mothroach, Mr. Fluff. He looks so happy to be here!"
	icon = 'modular_zubbers/icons/mob/donator_pets.dmi'
	icon_state = "mr_fluff"
	starting_pet = /mob/living/basic/mothroach/mr_fluff

//FIND A BETTER SPOT FOR THIS
/datum/preference/choiced/pet_gender
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "pet_gender"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/pet_gender/init_possible_values()
	return list("Random", MALE, FEMALE, PLURAL, NEUTER)

/datum/preference/choiced/pet_gender/create_default_value()
	return PLURAL

/datum/preference/choiced/pet_gender/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Pet Owner" in preferences.all_quirks

/datum/preference/choiced/pet_gender/apply_to_human(mob/living/carbon/human/target, value)
	return
