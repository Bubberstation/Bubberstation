// UNIMPLEMENTED QUIRK!
/datum/quirk/cum_sniff
	name = "Genital Sniffer"
	desc = "You can accurately identify what reagents other people's genitals produce."
	value = 0
	mob_trait = TRAIT_GFLUID_DETECT // TODO: Add the reagent detection system
	gain_text = span_purple("You begin sensing peculiar smells from people's bits...")
	lose_text = span_purple("People's genitals start smelling all the same to you...")
	medical_record_text = "Patient has exemplary olfactory capability for specific body regions."
	icon = FA_ICON_VIAL
	erp_quirk = TRUE
	hidden_quirk = TRUE
