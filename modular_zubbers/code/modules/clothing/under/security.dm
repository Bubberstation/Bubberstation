///SECMED
/obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec
	name = "security medic scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards and acid, along with some light padding. This one is in a deep red."
	armor_type = /datum/armor/clothing_under/red_sec

/datum/armor/clothing_under/red_sec
	melee = 10
	bio = 10
	fire = 30
	acid = 30
	wound = 10

//Maid SEC

/obj/item/clothing/under/rank/security/maid ///Icon by Onule!
	name = "cnc maid uniform"
	desc = "Unlike a normal maid costume, this one is made of high-performance durathread weave. This relatively innocent at first glance outfit is actually the specialized type worn by Nanotrasen's infamous high profile 'Cleaning and Clearing' kill squads. It's a lot more robust than it's janitorial counterpart.."
	icon_state = "security_maid"
	icon = 'modular_zubbers/icons/obj/clothing/under/maidsec.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/maidsec.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/maidsec_d.dmi'

//Metro Cops

/obj/item/clothing/under/rank/security/metrocop //Sprite done by HL13 Station
	name = "civil protection uniform"
	desc = "Standard issue uniforms for Civil Protection forces. Uses advanced GigaSlop brand Matrixes to allow alternative variants!"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon_state = "civilprotection"
	inhand_icon_state =  null
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/metrocop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/metrocop)

/datum/atom_skin/metrocop
	abstract_type = /datum/atom_skin/metrocop

/datum/atom_skin/metrocop/metro
	preview_name = "MetroCop"
	new_icon_state = "civilprotection"

/datum/atom_skin/metrocop/red
	preview_name = "Red"
	new_icon_state = "divisionallead"

/datum/atom_skin/metrocop/overwatch_white
	preview_name = "White Overwatch"
	new_icon_state = "overwatch_white"

/datum/atom_skin/metrocop/overwatch
	preview_name = "Overwatch"
	new_icon_state = "overwatch"

/datum/atom_skin/metrocop/overwatch_red
	preview_name = "Red Overwatch"
	new_icon_state = "overwatch_red"

//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.
/obj/item/clothing/under/rank/security/snake
	name = "stealth suit"
	desc = "We may all be headed straight to hell. But what better place for us than this?"
	icon = 'modular_zubbers/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/syndicate.dmi'
	icon_state = "snake"

/obj/item/clothing/under/rank/security/camo
	name = "armored camouflage uniform"
	desc = "DO YOU FIND THAT FUNNY BUTTHEAD?!"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/camo"
	post_init_icon_state = "solfed_camo"
	worn_icon_state = "solfed_camo"
	worn_icon_digi = "solfed_camo"
	greyscale_config = /datum/greyscale_config/camo
	greyscale_config_worn = /datum/greyscale_config/camo/worn
	greyscale_config_worn_digi = /datum/greyscale_config/camo/worn/digi
	greyscale_colors = "#A53228#333333#292929"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE
