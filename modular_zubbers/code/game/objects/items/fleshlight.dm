//Hyperstation 13 fleshlight
//Humbley request this doesnt get ported to other code bases, we strive to make things unique on our server and we dont have alot of coders
//but if you absolutely must. please give us some credit~ <3
//made by quotefox
//Hyperstation 13 portal fleshlight
//kinky!

/obj/item/portallight
	name = "portal fleshlight"
	desc = "A silver love(TM) fleshlight, used to stimulate someones penis, with bluespace tech that allows lovers to hump at a distance."
	icon = 'modular_zubbers/icons/obj/fleshlight.dmi'
	icon_state = "unpaired"
	base_icon_state = "fleshlight"
	w_class = WEIGHT_CLASS_SMALL
	var/paired = 0
	var/obj/item/portalunderwear
	var/useable = FALSE
	var/organ_type

/obj/item/portallight/examine(mob/user)
	. = ..()
	if(!portalunderwear)
		. += "<span class='notice'>The device is unpaired, to pair, swipe against a pair of portal panties. </span>"
	else
		. += "<span class='notice'>The device is paired, and awaiting input. </span>"

/obj/item/portallight/attackby(obj/item/panties, mob/user, params)

//Hyperstation 13 portal underwear
//can be attached to vagina or anus, just like the vibrator, still requires pairing with the portallight
/obj/item/portalpanties
	name = "portal panties"
	desc = "A silver love(TM) pair of portal underwear, with bluespace tech allows lovers to hump at a distance. Needs to be paired with a portal fleshlight before use."
	icon = 'modular_zubbers/icons/obj/fleshlight.dmi'
	icon_state = "portalpanties"
	base_icon_state = "fleshlight"
	w_class = WEIGHT_CLASS_SMALL
	lewd_slot_flags = LEWD_SLOT_ANUS | LEWD_SLOT_VAGINA
	var/obj/item/portallight
	var/attached = FALSE
	var/shapetype = "vagina"

/obj/item/portalpanties/examine(mob/user)
	. = ..()
	if(!portallight)
		. += "<span class='notice'>The device is unpaired, to pair, swipe the fleshlight against this pair of portal panties(TM). </span>"
	else
		. += "<span class='notice'>The device is paired, and awaiting attachment. </span>"

/obj/item/storage/box/portallight
	name =  "Portal Fleshlight and Underwear"
	icon = 'modular_zubbers/icons/obj/fleshlight.dmi'
	desc = "A box containing a pair of portal toys designed by a station in the Hyper sector."
	icon_state = "box"

// portal fleshlight box
/obj/item/storage/box/portallight/PopulateContents()
	new /obj/item/portallight/(src)
	new /obj/item/portalpanties/(src)
	new /obj/item/paper/fluff/portallight(src)

/obj/item/paper/fluff/portallight
	name = "Portal Fleshlight Instructions"
	default_raw_text = "Thank you for purchasing the Silver Love Portal Fleshlight!<BR>To use, simply register your new portal fleshlight with the provided underwear to link them together. The ask your lover to wear the underwear.<BR>Have fun lovers,<BR><BR>Wilhelmina Steiner."
