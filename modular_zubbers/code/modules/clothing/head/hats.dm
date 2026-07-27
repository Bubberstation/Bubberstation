/obj/item/clothing/head/soft/allamerican
	name = "all-american diner employee cap"
	desc = "It's a salmon colored baseball cap that All-American Diner employees wear, you see the name of the diner on the front of the cap, just to tell you where you are."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "allamericansoft"
	soft_type = "allamerican"
	dog_fashion = null

/obj/item/clothing/head/soft/galfedcap
	name = "Galactic Federation cap"
	desc = "A cap with the Galactic Federation logo on the front, it's a nice shade of blue."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "galfedsoft"
	soft_type = "galfed"
	dog_fashion = null

/obj/item/clothing/head/peacekeeperberet
	name = "peacekeeper Beret"
	desc = "A relic from the past. Its effectiveness as a stylish hat was never debated."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "unberet"
	dog_fashion = null

//Ported from Kuro020 of TGMC.
/obj/item/clothing/head/bandana/snake
	name = "soldier's bandana"
	desc = "<i>Her</i> bandana, salvaged from Lake Nicaragua and lovingly repaired."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "headband_snake"

/obj/item/clothing/head/bandana/snake/sec
	name = "armored bandana"
	desc = "For ten years, we lived and died together. You couldn't possibly understand."
	armor_type = /datum/armor/cosmetic_sec

//virosec hats
/obj/item/clothing/head/sec/viro
	name = "security softcap"
	desc = "A soft hat to give security operators less strain on their necks after wearing helmets all day."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "secsoft_v"
	armor_type = /datum/armor/cosmetic_sec

/datum/greyscale_component_style/security_cap
	output_icon_state = "security_cap"
	fallback_icon_state = "security_cap"
	default_accessories = list("security_cap_accs_front", "security_cap_accs_logo")
	core_components = list(
		list(
			"name" = "Cap",
			"key" = "cap",
			"default" = "security",
			"options" = list(
				"security" = list(
					"name" = "Security cap",
					"state" = "security_cap",
					"color_id" = 1,
					"color_label" = "Main",
					"default_color" = "#A53429",
				),
			),
		),
	)
	accessories = list(
		"Backing" = list(
			"state" = "security_cap_accs_front",
			"color_id" = 2,
			"color_label" = "Backing",
			"default_color" = "#3F6E9E",
		),
		"Logo" = list(
			"state" = "security_cap_accs_logo",
			"color_id" = 3,
			"color_label" = "Logo",
			"default_color" = "#FFFFFF",
		),
	)

/obj/item/clothing/head/soft/sec/recolorable
	name = "security cap"
	desc = "It's a robust baseball hat, this one seems to have been custom ordered."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "security_cap"
	post_init_icon_state = "security_cap"
	soft_type = "security_cap"
	soft_suffix = ""
	greyscale_config = /datum/greyscale_config/security_cap
	greyscale_config_worn = /datum/greyscale_config/security_cap/worn
	greyscale_colors = "#A53429#3F6E9E#FFFFFF"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1
	greyscale_component_style_type = /datum/greyscale_component_style/security_cap
	greyscale_component_icon_file = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	greyscale_component_worn_icon_file = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	greyscale_component_worn_state_overrides = list(
		"security_cap" = "security_capg",
		"security_cap_accs_front" = "security_capg_accs_backing",
		"security_cap_accs_logo" = "security_capg_accs_logo",
	)
	greyscale_component_accessories = list("security_cap_accs_front", "security_cap_accs_logo")

/obj/item/clothing/head/soft/sec/recolorable/Initialize(mapload)
	initialize_greyscale_component_style()
	return ..()

/obj/item/clothing/head/soft/sec/recolorable/update_greyscale()
	. = ..()
	update_greyscale_component_icons()

/obj/item/clothing/head/soft/sec/recolorable/flip(mob/user)
	balloon_alert(user, "can't be flipped!")

/obj/item/clothing/head/sec/viro/beanie
	name = "security beanie"
	desc = "A beanie for security purposes"
	icon_state = "security_beanie"
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/head/costume/mailman
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/costume_teshari.dmi'

/obj/item/clothing/head/fedora/det_hat
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/obj/item/clothing/head/hats/caphat
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/obj/item/clothing/head/nanotrasen_consultant
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/obj/item/clothing/head/hats/hopcap
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'

/obj/item/clothing/head/hats/warden/red
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/hats_teshari.dmi'
