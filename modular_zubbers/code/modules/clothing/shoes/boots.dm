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
	body_parts_covered = parent_type::body_parts_covered | LEGS
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

//HEELED STUFF (NOT THE FANCY HEELS) SPRITES BY DimWhat OF MONKE STATION

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

//MEDICAL

/obj/item/clothing/shoes/fancy_heels/white
	name = "white heels"
	greyscale_colors = "#ffffff"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/darkblue
	name = "dark blue heels"
	greyscale_colors = "#364660"
	flags_1 = null

//SCIENCE

/obj/item/clothing/shoes/fancy_heels/black
	name = "black heels"
	greyscale_colors = "#39393f"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/purple
	greyscale_colors = "#7e1980"
	flags_1 = null

//SECURITY

/obj/item/clothing/shoes/fancy_heels/red
	name = "red heels"
	greyscale_colors = "#a52f29"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/grey
	name = "grey heels"
	greyscale_colors = "#918f8c"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/brown
	name = "brown heels"
	greyscale_colors = "#784f44"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/orange
	name = "orange heels"
	greyscale_colors = "#ff8d1e"
	flags_1 = null

//HEELED STUFF (NOT THE FANCY HEELS) SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/shoes/jackboots/gogo_boots
	name = "tactical go-go boots"
	desc = "Highly tactical footwear designed to give you a better view of the battlefield."
	icon_state = "hos_boots"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'

//SERVICE

/obj/item/clothing/shoes/fancy_heels/lightblue
	name = "light blue heels"
	greyscale_colors = "#3e6588"
	flags_1 = null

//HEELED STUFF (NOT THE FANCY HEELS) SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/shoes/galoshes/heeled
	name = "heeled galoshes"
	desc = "A pair of yellow rubber heels, designed to prevent slipping on wet surfaces. These are even harder to walk in than normal heels."
	icon_state ="galoshes_heeled"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	custom_premium_price = PAYCHECK_CREW * 3

/obj/item/clothing/shoes/fancy_heels/green
	name = "green heels"
	greyscale_colors = "#50d967"
	flags_1 = null

//HEELED STUFF (NOT THE FANCY HEELS) SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/shoes/clown_shoes/heeled
	name = "honk heels"
	desc = "A pair of high heeled clown shoes. What kind of maniac would design these?"
	icon_state ="honk_heels"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'

/obj/item/clothing/shoes/fancy_heels/darkgreen
	name = "dark green heels"
	greyscale_colors = "#47853a"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/teal
	name = "teal heels"
	greyscale_colors = "#5cbfaa"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/mutedblack
	name = "muted black heels"
	greyscale_colors = "#2f3038"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/mutedblue
	name = "muted blue heels"
	greyscale_colors = "#1165c5"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/beige
	name = "beige heels"
	greyscale_colors = "#a69e9a"
	flags_1 = null

/obj/item/clothing/shoes/fancy_heels/darkgrey
	name = "dark grey heels"
	greyscale_colors = "#46464d"
	flags_1 = null
