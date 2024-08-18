/* Commented until we have the genital fluid options
/datum/quirk/fluid_infuser
	name = "Fluid Infuser"
	desc = "You just couldn't wait to get one of NanoTrasen's new fluid inducers when they first came out, so now you can hop in the station with editable titty milk!"
	value = 0

/datum/quirk/fluid_infuser/on_spawn()
	. = ..()
	var/obj/item/implant/genital_fluid/put_in = new
	put_in.implant(quirk_holder, null, TRUE, TRUE)
*/
