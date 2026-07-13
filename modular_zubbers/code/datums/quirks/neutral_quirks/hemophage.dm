/datum/quirk/hemophage
	name = "Hemophagia"
	desc = "You have the organs and abilities of someone suffering hemophagic vampirism."
	icon = FA_ICON_TEETH
	value = 0
	medical_record_text = "During physical examination, patient was found to have corrupted organs and other abilities commonly found in those with \
		hemophagia."
	hardcore_value = 0
	mail_goodies = list(/obj/item/reagent_containers/blood/random)
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	// Most of these are Halloween species but we still have them once a year.
	species_blacklist = list(
		SPECIES_ABDUCTOR_STATION,
		SPECIES_ZOMBIE,
		SPECIES_SKELETON,
		SPECIES_SHADOW,
		SPECIES_PLASMAMAN,
		SPECIES_GOLEM,
		SPECIES_SPIRIT,
		SPECIES_ANDROID,
		SPECIES_ABDUCTOR,
		SPECIES_VAMPIRE,
	)

	var/old_heart = null
	var/old_liver = null
	var/old_stomach = null
	var/old_tongue = null

/datum/quirk/hemophage/add(client/client_source)
	quirk_holder.add_traits(list(
		TRAIT_DRINKS_BLOOD,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
	), QUIRK_TRAIT)

	if(client_source.prefs.read_preference(/datum/preference/toggle/masquerade))
		ADD_TRAIT(quirk_holder, TRAIT_MASQUERADE_FOOD, QUIRK_TRAIT)

/datum/quirk/hemophage/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/static/list/organ_slots = list(
		ORGAN_SLOT_HEART = /obj/item/organ/heart/hemophage,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/hemophage,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/hemophage,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/hemophage,
	)
	var/list/possible_organ_slots = organ_slots.Copy()
	if(!length(organ_slots)) //what the hell
		return

	var/obj/item/organ/heart/current_heart = human_holder.get_organ_slot(ORGAN_SLOT_HEART)
	var/obj/item/organ/liver/current_liver = human_holder.get_organ_slot(ORGAN_SLOT_LIVER)
	var/obj/item/organ/stomach/current_stomach = human_holder.get_organ_slot(ORGAN_SLOT_STOMACH)
	var/obj/item/organ/tongue/current_tongue = human_holder.get_organ_slot(ORGAN_SLOT_TONGUE)

	old_heart = current_heart?.type
	old_liver = current_liver?.type
	old_stomach = current_stomach?.type
	old_tongue = current_tongue?.type

	for(var/organ_slot in possible_organ_slots)
		var/organ_path = possible_organ_slots[organ_slot]
		var/obj/item/organ/new_organ = new organ_path()
		new_organ.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/hemophage/remove(client/client_source)
	quirk_holder.remove_traits(list(
		TRAIT_DRINKS_BLOOD,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
	), QUIRK_TRAIT)

	if(client_source.prefs.read_preference(/datum/preference/toggle/masquerade))
		REMOVE_TRAIT(quirk_holder, TRAIT_MASQUERADE_FOOD, QUIRK_TRAIT)

	// This is going to be super messy and I'm 100% sure there's a better way to do this.
	var/mob/living/carbon/carbon_holder = quirk_holder

	if(!istype(carbon_holder) || isnull(old_heart))
		return
	var/obj/item/organ/heart/new_heart = new old_heart

	if(!istype(carbon_holder) || isnull(old_liver))
		return
	var/obj/item/organ/liver/new_liver = new old_liver

	if(!istype(carbon_holder) || isnull(old_stomach))
		return
	var/obj/item/organ/stomach/new_stomach = new old_stomach

	if(!istype(carbon_holder) || isnull(old_tongue))
		return
	var/obj/item/organ/tongue/new_tongue = new old_tongue

	new_heart.Insert(carbon_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	new_liver.Insert(carbon_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	new_stomach.Insert(carbon_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	new_tongue.Insert(carbon_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk_constant_data/hemophage
	associated_typepath = /datum/quirk/hemophage
	customization_options = list(/datum/preference/toggle/masquerade)

/datum/preference/toggle/masquerade
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "masquerade_toggle"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	default_value = FALSE

/datum/preference/toggle/masquerade/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/masquerade/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Hemophagia" in preferences.all_quirks

// TO-DO:
// - Figure out how to convert sol weakness and pseudo-respiration
