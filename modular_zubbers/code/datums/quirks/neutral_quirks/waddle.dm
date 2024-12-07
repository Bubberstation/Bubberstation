/datum/quirk/waddle
	name = "Waddle"
	desc = "Your movements always had a bit more of a waddle to them."
	medical_record_text = "Subject appears to be terrible at dancing."
	value = 0
	icon = FA_ICON_WIND
	gain_text = span_notice("You feel like walking silly")
	lose_text = span_notice("You no longer feel like walking silly")
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/food/grown/banana)


/datum/quirk/waddle/add(client/client_source)
	. = ..()
	quirk_holder.AddElementTrait(TRAIT_WADDLING, QUIRK_TRAIT, /datum/element/waddling)

/datum/quirk/waddle/remove()
	. = ..()
	quirk_holder.RemoveElement(/datum/element/waddling)
