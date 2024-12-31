// Boatcloaks
/obj/item/clothing/neck/cloak/alt/boatcloak
	name = "boatcloak"
	desc = "A simple, short-ish boatcloak."
	icon = 'modular_zzplurt/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_zzplurt/icons/mob/clothing/neck.dmi'
	icon_state = "boatcloak"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/cloak/alt/boatcloak/command
	name = "command boatcloak"
	desc = "A boatcloak with gold ribbon."
	icon_state = "boatcloak_com"
	body_parts_covered = CHEST|LEGS|ARMS

/obj/item/clothing/neck/cloak/alt/boatcloak/greyscale
	name = "colorable boatcloak"
	desc = "Colorable short-ish boatcloak."
	icon_state = "boatcloak"
	greyscale_colors = "#EEEEEE"
	greyscale_config = /datum/greyscale_config/boatcloak
	greyscale_config_worn = /datum/greyscale_config/boatcloak/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/datum/greyscale_config/boatcloak
	name = "Boatcloak"
	icon_file = 'modular_zzplurt/icons/obj/clothing/neck.dmi'
	json_config = 'modular_zzplurt/code/datums/greyscale/json_configs/boatcloak.json'

/datum/greyscale_config/boatcloak/worn
	name = "Boatcloak (Worn)"
	icon_file = 'modular_zzplurt/icons/mob/clothing/neck.dmi'
