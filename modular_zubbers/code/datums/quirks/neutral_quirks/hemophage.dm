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

/datum/quirk/hemophage/add(client/client_source)
	quirk_holder.add_traits(list(
		TRAIT_DRINKS_BLOOD,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
	), QUIRK_TRAIT)

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
