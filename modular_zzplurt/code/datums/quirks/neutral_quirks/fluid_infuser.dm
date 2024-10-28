// UNIMPLEMENTED QUIRK!
/datum/quirk/fluid_infuser
	name = "Fluid Infuser"
	desc = "You just couldn't wait to get one of NanoTrasen's new fluid inducers when they first came out, so now you can hop in the station with editable bodily fluids!"
	value = 0
	gain_text = span_notice("Your Fluid Infuser implant has been activated.")
	lose_text = span_notice("Your Fluid Infuser implant encounters a critical error.")
	medical_record_text = "Patient has been implanted with a Fluid Infuser implant."
	// No mob trait
	icon = FA_ICON_BOTTLE_DROPLET

/* Commented until we have the genital fluid options
/datum/quirk/fluid_infuser/on_spawn()
	. = ..()
	var/obj/item/implant/genital_fluid/put_in = new
	put_in.implant(quirk_holder, null, TRUE, TRUE)
*/
