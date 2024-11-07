// REMOVED QUIRK - Disabled in favor of new NIFSoft method
/*
/datum/quirk/fluid_infuser
	name = "Fluid Infuser"
	desc = "You start the shift with one of NanoTrasen's new genital fluid inducers."
	value = 0
	gain_text = span_notice("Your Fluid Infuser implant has been activated.")
	lose_text = span_notice("Your Fluid Infuser implant encounters a critical error.")
	medical_record_text = "Patient has been implanted with a Fluid Infuser implant."
	// No mob trait
	icon = FA_ICON_BOTTLE_DROPLET
	erp_quirk = TRUE
	hidden_quirk = TRUE
*/
// Implant currently not implemented
/*
/datum/quirk/fluid_infuser/on_spawn()
	. = ..()
	var/obj/item/implant/genital_fluid/put_in = new
	put_in.implant(quirk_holder, null, TRUE, TRUE)
*/
