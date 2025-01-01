/datum/quirk/messy
	name = "Messy"
	desc = "You always manage to make a mess when you cum, even if it's not possible in normal circumstances."
	value = 0
	gain_text = span_purple("You feel prepared to cover something in layer of bodily fluids.")
	lose_text = span_purple("You don't feel the need to make a mess anymore.")
	medical_record_text = "Patient's body has above-average fluid production capability."
	mob_trait = TRAIT_MESSY
	icon = FA_ICON_EXPLOSION
	erp_quirk = TRUE
	mail_goodies = list (
		/obj/item/mop = 1 // Clean this mess up!
	)
