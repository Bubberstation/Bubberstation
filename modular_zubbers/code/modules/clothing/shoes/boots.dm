/obj/item/clothing/shoes/boots/diver //Donor item for patriot210
	icon = 'modular_zubbers/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet.dmi'
	name = "black divers boots"
	desc = "An old pair of boots used by a now-defunct mining coalition, it seems close to the ones used by Nanotrasen miners, but without the compartments for fitting small items."
	icon_state = "diver"
	worn_icon_state = "diver"

/obj/item/clothing/shoes/fancy_heels/cc
	name = "nanotrasen heels"
	desc = "Surely these aren't official. Right?"
	greyscale_colors = "#316E4A"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/syndi
	name = "syndiheels"
	desc = "Heel in more way than one."
	greyscale_colors = "#18191E"
	armor_type = /datum/armor/shoes_combat
	lace_time = 12 SECONDS
	hitsound = 'sound/weapons/bladeslice.ogg'
	strip_delay = 2 SECONDS
	force = 10
	throwforce = 15
	sharpness = SHARP_POINTY
	attack_verb_continuous = list("attacks", "slices", "slashes", "cuts", "stabs")
	attack_verb_simple = list("attack", "slice", "slash", "cut", "stab")
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/wizard
	name = "magical heels"
	desc = "A pair of heels that seem to magically solve all the problems with walking in heels."
	strip_delay = 2 SECONDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	greyscale_colors = "#291A69"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/red
	name = "red heels"
	desc = "A pair of classy red heels."
	greyscale_colors = "#921C25"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/blue
	name = "blue heels"
	greyscale_colors = "#41579a"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/lightgrey
	name = "light grey heels"
	greyscale_colors = "#d0d7da"
	flags_1 = null

/obj/item/clothing/shoes/workboots/mining/heeled
	name = "heeled mining boots"
	desc = "Steel-toed mining heels for mining in hazardous environments. This was an awful idea."
	icon_state = "explorer_heeled"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	species_exception = null

/obj/item/clothing/shoes/fancy_heels/navyblue
	name = "navy blue heels"
	greyscale_colors = "#362f68"
	flags_1 = null

/obj/item/clothing/shoes/workboots/heeled
	name = "heeled work boots"
	desc = "Nanotrasen-issue Engineering lace-up work heels that seem almost especially designed to cause a workplace accident."
	icon_state = "workboots_heeled"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	species_exception = null

