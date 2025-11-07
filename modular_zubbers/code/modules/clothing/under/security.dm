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
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"MetroCop" = list(
			RESKIN_ICON_STATE = "civilprotection",
			RESKIN_WORN_ICON_STATE = "civilprotection"
		),
		"Red" = list(
			RESKIN_ICON_STATE = "divisionallead",
			RESKIN_WORN_ICON_STATE = "divisionallead"
		),
		"White Overwatch" = list(
			RESKIN_ICON_STATE = "overwatch_white",
			RESKIN_WORN_ICON_STATE = "overwatch_white"
		),
		"Overwatch" = list(
			RESKIN_ICON_STATE = "overwatch",
			RESKIN_WORN_ICON_STATE = "overwatch"
		),
		"Red Overwatch" = list(
			RESKIN_ICON_STATE = "overwatch_red",
			RESKIN_WORN_ICON_STATE = "overwatch_red"
		),
	)


//MGS stuff sprited by Crumpaloo for onlyplateau, please credit when porting, which you obviously have permission to do.
/obj/item/clothing/under/rank/security/snake
	name = "stealth suit"
	desc = "We may all be headed straight to hell. But what better place for us than this?"
	icon = 'modular_zubbers/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/syndicate.dmi'
	icon_state = "snake"
	uses_advanced_reskins = FALSE
