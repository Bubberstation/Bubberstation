
/obj/item/book/granter/martial/ultra_violence
	martial = /datum/martial_art/ultra_violence
	name = "version one upgrade module"
	martial_name = "Ultra Violence"
	desc = "A module full of forbidden techniques from a horrific event long since passed, or perhaps yet to come."
	greet = span_sciradio("You have installed Ultra Violence! You are able to redirect electromagnetic pulses with throwmode, \
		blood heals you, and you CANNOT BE STOPPED. You can mentally practice by using Cyber Grind in the Ultra Violence tab.")
	icon = 'icons/obj/module.dmi'
	icon_state = "cyborg_upgrade"
	remarks = list("MANKIND IS DEAD.", "BLOOD IS FUEL.", "HELL IS FULL.")

/obj/item/book/granter/martial/ultra_violence/on_reading_start(mob/user)
	to_chat(user, span_notice("You plug \the [src] in and begin loading PRG$[martial_name]."))

/obj/item/book/granter/martial/ultra_violence/can_learn(mob/user)
	if(!isipc(user))
		to_chat(user, span_warning("A nice looking piece of scrap, would make a fine trade offer."))
		return FALSE
	return ..()

/obj/item/book/granter/martial/ultra_violence/on_reading_finished(mob/living/carbon/user)
	..()
	if(!uses)
		desc = "It's a damaged upgrade module."
		name = "damaged board"
