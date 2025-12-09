//Override thing from Monkey. Lets us tie bowties.

/obj/item/clothing/neck/tie
	var/tie_type = "tie_greyscale"

/obj/item/clothing/neck/tie/update_icon()
	. = ..()
	// Normal strip & equip delay, along with 2 second self equip since you need to squeeze your head through the hole.
	if(is_tied)
		icon_state = "[tie_type]_tied"
		strip_delay = 4 SECONDS
		equip_delay_other = 4 SECONDS
		equip_delay_self = 2 SECONDS
	else // Extremely quick strip delay, it's practically a ribbon draped around your neck
		icon_state = "[tie_type]_untied"
		strip_delay = 1 SECONDS
		equip_delay_other = 1 SECONDS
		equip_delay_self = 0

//ALL BUNNY STUFF BY DimWhat OF MONKEESTATION

/obj/item/clothing/neck/tie/bunnytie
	name = "bowtie collar"
	desc = "A fancy tie that includes a collar. Looking snazzy!"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/tie/bunnytie"
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	post_init_icon_state = "bowtie_collar_tied"
	tie_type = "bowtie_collar"
	greyscale_colors = "#ffffff#39393f"
	greyscale_config = /datum/greyscale_config/bowtie_collar
	greyscale_config_worn = /datum/greyscale_config/bowtie_collar_worn
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = UNDER_SUIT_LAYER

/obj/item/clothing/neck/tie/bunnytie/tied
	is_tied = TRUE
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/neck/tie/clown
	name = "clown's bowtie"
	desc = "An outrageously large blue bowtie. Looking funny!"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "bowtie_clown_tied"
	post_init_icon_state = null
	tie_type = "bowtie_clown"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null
	tie_timer = 8 SECONDS //It's a BIG bowtie

/obj/item/clothing/neck/tie/clown/tied
	is_tied = TRUE

//BUNNY STUFF END, SPRITES BY DimWhat OF MONKE STATION

/obj/item/clothing/neck/tie/allamerican
	name = "all-american diner manager tie"
	desc = "A dark grey tie with a golden clip on it, makes you look formal in a joint usually covered in grease!"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "allamerican"
	post_init_icon_state = null
	greyscale_colors = null
	is_tied = TRUE
	clip_on = TRUE

//PRIDE SCARVES, SPRITES BY Cephalopod222 OF BUBBERSTATION
/obj/item/clothing/neck/scarf/pride
	name = "pride scarf"
	desc = "A Nanotrasen made nano-weave scarf to show off your favourite flavour of gay and keep you nice and warm! Congratulations!"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_preview = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "scarf_rainbow"
	post_init_icon_state = null
	icon_state_preview = "scarf_rainbow"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	obj_flags = UNIQUE_RENAME | INFINITE_RESKIN
	unique_reskin = list(
		"Rainbow Scarf" = "scarf_rainbow",
		"Bisexual Scarf" = "scarf_bi",
		"Pansexual Scarf" = "scarf_pan",
		"Asexual Scarf" = "scarf_ace",
		"Gay Scarf" = "scarf_gay",
		"Transgender Scarf" = "scarf_trans",
		"Lesbian Scarf" = "scarf_lesbian",
	)

//Shadekin Fur Scarf Sprites by Boviro of Bubberstation
/obj/item/clothing/neck/scarf/shadekin
	name = "shadekin fur scarf"
	desc = "An unethical scarf made from the soft fur and supple hides of Shadekin. Illegal in almost all areas of occupied space, but highly sought after by elites and pirates nonetheless."
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_preview = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "scarf_unethical"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
