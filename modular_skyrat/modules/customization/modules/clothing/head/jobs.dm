// This is for all the berets that /tg/ didn't want. You're welcome, they should look better.

/obj/item/clothing/head/hats/hos/beret/syndicate
	icon_state = "/obj/item/clothing/head/hats/hos/beret/syndicate"
	greyscale_colors = "#3F3C40#DB2929"

/obj/item/clothing/head/beret/sec/navywarden
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/sec/navywarden"
	post_init_icon_state = "beret_badge_fancy_twist"
	greyscale_config = /datum/greyscale_config/beret_badge_fancy
	greyscale_config_worn = /datum/greyscale_config/beret_badge_fancy/worn
	greyscale_colors = "#3C485A#FF0000#00AEEF"
	armor_type = /datum/armor/sec_navywarden

/datum/armor/sec_navywarden
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 50
	wound = 6

/obj/item/clothing/head/beret/sec/navyofficer
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/sec/navyofficer"
	post_init_icon_state = "beret_badge_bolt"
	greyscale_colors = "#3C485A#FF0000"

//Medical

/obj/item/clothing/head/beret/medical
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/medical"
	post_init_icon_state = "beret_badge_med"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#FFFFFF#5FA4CC"
	flags_1 = NONE

/obj/item/clothing/head/beret/medical/paramedic
	icon_state = "/obj/item/clothing/head/beret/medical/paramedic"
	greyscale_colors = "#364660#5FA4CC"

/obj/item/clothing/head/beret/medical/chemist
	name = "chemist beret"
	desc = "Not acid-proof!"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/medical/chemist"
	greyscale_colors = "#FFFFFF#D15B1B"

/obj/item/clothing/head/beret/medical/virologist
	name = "virologist beret"
	desc = "Sneezing in this expensive beret would be a waste of a good beret."
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/medical/virologist"
	greyscale_colors = "#FFFFFF#198019"


//Engineering

/obj/item/clothing/head/beret/engi
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/engi"
	post_init_icon_state = "beret_badge_engi"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#ff8200#ffe12f"
	flags_1 = NONE

/obj/item/clothing/head/beret/atmos
	name = "atmospheric beret"
	desc = "While \"pipes\" and \"style\" might not rhyme, this beret sure makes you feel like they should!"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/atmos"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#59D7FF#ffe12f"
	flags_1 = NONE

// From this point forth will be berets that are made especially for Skyrat. Those are loosely based off of the ones that were ported initially, but they might not be 1:1

/obj/item/clothing/head/beret/engi/ce
	name = "chief engineer's beret"
	desc = "A fancy beret designed exactly to the Chief Engineer's tastes, minus the LEDs."
	icon_state = "/obj/item/clothing/head/beret/engi/ce"
	greyscale_colors = "#FFFFFF#2E992E"

/obj/item/clothing/head/beret/medical/cmo
	name = "chief medical officer's beret"
	desc = "A beret custom-fit to the Chief Medical Officer, repaired once or twice after Runtime got a hold of it."
	icon_state = "/obj/item/clothing/head/beret/medical/cmo"
	greyscale_colors = "#5EB8B8#5FA4CC"

/obj/item/clothing/head/beret/medical/cmo/alt
	name = "chief medical officer's beret"
	desc = "A beret custom-fit to the Chief Medical Officer, repaired once or twice after Runtime got a hold of it. This one is made out of white fabric. Fancy."
	icon_state = "/obj/item/clothing/head/beret/medical/cmo/alt"
	greyscale_colors = "#FFFFFF#199393"

/obj/item/clothing/head/beret/science/fancy
	desc = "A science-themed beret for our hardworking scientists. This one comes with a fancy badge!"
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/science/fancy"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/beret_badge/worn/teshari
	greyscale_colors = "#7E1980#FFFFFF"

/obj/item/clothing/head/beret/science/fancy/robo
	name = "robotics beret"
	desc = "A sleek black beret designed with high-durability nano-mesh fiber - or so the roboticists claim."
	icon_state = "/obj/item/clothing/head/beret/science/fancy/robo"
	greyscale_colors = "#3E3E48#88242D"

/obj/item/clothing/head/beret/science/rd/alt
	name = "research director's beret"
	desc = "A custom-tailored beret for the Research Director. Lamarr thinks it looks great. This one is made out of white fabric. Fancy."
	icon_state = "/obj/item/clothing/head/beret/science/rd/alt"
	greyscale_colors = "#FFFFFF#7E1980"

/obj/item/clothing/head/beret/cargo/qm
	name = "quartermaster's beret"
	desc = "A beret that helps the QM keep telling themselves that they're an official head of staff."
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret/cargo/qm"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	post_init_icon_state = "beret_badge"
	greyscale_colors = "#cf932f#FFCE5B"

/obj/item/clothing/head/beret/cargo/qm/alt
	name = "quartermaster's beret"
	desc = "A beret that helps the QM keep telling themselves that they're an official head of staff. This one is made out of white fabric. Fancy"
	icon_state = "/obj/item/clothing/head/beret/cargo/qm/alt"
	greyscale_colors = "#FFFFFF#FFCE5B"

/obj/item/clothing/head/caphat/beret/alt
	name = "captain's beret"
	desc = "For the Captains known for their sense of fashion. This one is made out of white fabric. Fancy"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/caphat/beret/alt"
	greyscale_colors = "#FFFFFF#FFCE5B"

/obj/item/clothing/head/hopcap/beret
	name = "head of personnel's beret"
	desc = "A fancy beret designed by NT's Personnel division for their favorite head's head."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hopcap/beret"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	post_init_icon_state = "beret_badge"
	greyscale_colors = "#3e5c88#88242D"

/obj/item/clothing/head/hopcap/beret/alt
	name = "head of personnel's beret"
	desc = "A fancy beret designed by NT's Personnel division for their favorite head's head. This one is made out of white fabric. Fancy"
	icon_state = "/obj/item/clothing/head/hopcap/beret/alt"
	greyscale_colors = "#FFFFFF#88242D"

/obj/item/clothing/head/beret/clown
	name = "H.O.N.K tactical beret"
	desc = "A tactical berret to be used during the enacting of the most dangerous of pranks."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "beret_clown"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null

/obj/item/clothing/head/beret/clown/rainbow
	name = "rainbow beret"
	desc = "You see, when a Mime loves a Clown very much..."
	icon_state = "beret_rainbow"
