/datum/quirk/choke_slut
	name = "Choke Slut"
	desc = "You are aroused by suffocation."
	value = 0
	gain_text = span_purple("You feel like you want to feel fingers around your neck, choking you until you pass out or make a mess... Maybe both.")
	lose_text = span_purple("Seems you don't have a kink for suffocation anymore.")
	medical_record_text = "Patient exhibits an abnormal obsession with restricted breathing."
	mob_trait = TRAIT_CHOKE_SLUT // Not implemented yet due to the lack of the arousal system
	icon = FA_ICON_LUNGS
	mail_goodies = list (
		/obj/item/reagent_containers/hypospray/medipen = 1 // Fix your oxy loss
	)
