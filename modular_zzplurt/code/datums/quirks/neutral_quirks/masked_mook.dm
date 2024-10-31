/datum/quirk/masked_mook
	name = "Bane Syndrome"
	desc = "For some reason you don't feel... right without wearing some kind of gas mask."
	value = 0
	quirk_flags = QUIRK_MOODLET_BASED | QUIRK_PROCESSES
	gain_text = span_danger("You start feeling unwell without a gas mask on.")
	lose_text = span_notice("You no longer feel the need to wear a gas mask.")
	medical_record_text = "Patient feels a strong psychological attachment to gas masks."
	mob_trait = TRAIT_MASKED_MOOK
	hardcore_value = 1
	icon = FA_ICON_MASK_VENTILATOR
	mail_goodies = list (
		/obj/item/gas_filter = 1
	)

// TODO: Change this to not require processing.
/datum/quirk/masked_mook/process(seconds_per_tick)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask/gas/gasmask = H.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(gasmask))
		quirk_holder.add_mood_event(QMOOD_MASKED_MOOK, /datum/mood_event/masked_mook)
	else
		quirk_holder.add_mood_event(QMOOD_MASKED_MOOK, /datum/mood_event/masked_mook_incomplete)

/datum/quirk/masked_mook/add_unique(client/client_source)
	. = ..()

	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask/gas/cosmetic/gasmask = new(get_turf(quirk_holder)) // Uses a custom gas mask
	H.equip_to_slot_if_possible(gasmask, ITEM_SLOT_MASK) // If character has a loadout mask, the custom one will not overwrite it but instead will be dropped on floor
	H.regenerate_icons()

// Equal to having heirloom
/datum/mood_event/masked_mook
	description = span_nicegreen("I feel more complete with a gas mask on.")
	mood_change = 1

// Equal to losing heirloom
/datum/mood_event/masked_mook_incomplete
	description = span_warning("I feel incomplete without a gas mask...")
	mood_change = -4
