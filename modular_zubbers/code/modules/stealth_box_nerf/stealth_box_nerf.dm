/obj/structure/closet/handle_deconstruct(...) // I'm about to bust.

	for(var/mob/living/person_in_box in contents)
		person_in_box.Knockdown(1 SECONDS)

	. = ..()

/datum/uplink_item/implants/stealthimplant
	name = "Stealth Implant (Fragile, Handle with Care)"
	desc = "This one-of-a-kind implant will make you almost invisible if you play your cards right. \
			On activation, it will conceal you inside a chameleon cardboard box that is only revealed once someone bumps into it. \
			SURGEON GENERAL'S WARNING: The cardboard box is fragile, and may stun the user when destroyed."
	cost = 6
