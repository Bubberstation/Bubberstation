// UNIMPLEMENTED QUIRK!
/datum/quirk/headpat_slut
	name = "Headpat Slut"
	desc = "You love the feeling of others touching your head! Maybe a little too much, actually... Others patting your head will provide a stronger mood boost, along with other sensual reactions."
	value = 0
	gain_text = span_purple("You long for the wonderful sensation of head pats!")
	lose_text = span_purple("Being pat on the head doesn't feel special anymore.")
	medical_record_text = "Patient seems abnormally responsive to being touched on the head."
	mob_trait = TRAIT_HEADPAT_SLUT
	icon = FA_ICON_HAND_HOLDING_HEART
	erp_quirk = TRUE

// Copy pasted from old code
/*
/datum/quirk/headpat_slut/add()
	. = ..()
	quirk_holder.AddElement(/datum/element/wuv/headpat, null, null, /datum/mood_event/pet_animal)

/datum/quirk/headpat_slut/remove()
	. = ..()
	quirk_holder.RemoveElement(/datum/element/wuv/headpat)
*/
