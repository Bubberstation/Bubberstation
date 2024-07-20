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

//Bunny Stuff from Monkee

/obj/item/clothing/neck/tie/bunnytie
	name = "bowtie collar"
	desc = "A fancy tie that includes a collar. Looking snazzy!"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_tied"
	tie_type = "bowtie_collar"
	greyscale_colors = "#ffffff#39393f"
	greyscale_config = /datum/greyscale_config/bowtie_collar
	greyscale_config_worn = /datum/greyscale_config/bowtie_collar_worn
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = UNDER_SUIT_LAYER

/obj/item/clothing/neck/tie/bunnytie/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/syndicate
	name = "blood-red bowtie collar"
	desc = "A fancy tie that includes a red collar. Looking sinister..."
	icon_state = "bowtie_collar_syndi_tied"
	tie_type = "bowtie_collar_syndi"
	armor_type = /datum/armor/large_scarf_syndie
	tie_timer = 2 SECONDS //Tactical tie
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/syndicate/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/magician
	name = "magician's bowtie collar"
	desc = "A fancy gold tie that includes a collar. Looking magical!"
	icon_state = "bowtie_collar_wiz_tied"
	tie_type = "bowtie_collar_wiz"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	custom_price = null

/obj/item/clothing/neck/tie/bunnytie/magician/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/centcom
	name = "centcom bowtie collar"
	desc = "A fancy gold tie that includes a collar. Looking in charge!"
	icon_state = "bowtie_collar_centcom_tied"
	tie_type = "bowtie_collar_centcom"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/centcom/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/communist
	name = "really red bowtie collar"
	desc = "A simple red tie that includes a collar. Looking egalitarian!"
	icon_state = "bowtie_collar_communist_tied"
	tie_type = "bowtie_collar_communist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/communist/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/blue
	name = "blue bowtie collar"
	desc = "A simple blue tie that includes a collar. Looking imperialist!"
	icon_state = "bowtie_collar_blue_tied"
	tie_type = "bowtie_collar_blue"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/neck/tie/bunnytie/blue/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/captain
	name = "captain's bowtie"
	desc = "A blue tie that includes a collar. Looking commanding!"
	icon = 'monkestation/icons/obj/clothing/costumes/bunnysprites/neckwear.dmi'
	worn_icon = 'monkestation/icons/mob/clothing/costumes/bunnysprites/neckwear_worn.dmi'
	icon_state = "bowtie_collar_captain_tied"
	tie_type = "bowtie_collar_captain"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/captain/tied
	is_tied = TRUE


/obj/item/clothing/neck/tie/bunnytie/cargo
	name = "cargo bowtie"
	desc = "A brown tie that includes a collar. Looking unionized!"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_cargo_tied"
	tie_type = "bowtie_collar_cargo"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/cargo/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/miner
	name = "shaft miner's bowtie"
	desc = "A purple tie that includes a collar. Looking hardy!"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_explorer_tied"
	tie_type = "bowtie_collar_explorer"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/miner/tied
	is_tied = TRUE

/obj/item/clothing/neck/tie/bunnytie/mailman
	name = "mailman's bowtie"
	desc = "A red tie that includes a collar. Looking unstoppable!"
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	icon_state = "bowtie_collar_mail_tied"
	tie_type = "bowtie_collar_mail"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	flags_1 = null

/obj/item/clothing/neck/tie/bunnytie/mail/tied
	is_tied = TRUE

