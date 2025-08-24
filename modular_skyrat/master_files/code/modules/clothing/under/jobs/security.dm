/obj/item/clothing/under/rank/security
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/security_digi.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/head_of_security/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'

//DEBATE MOVING *ALL* SECURITY STUFF HERE? Even overrides, at least as a like, sub-file?

/*
*	SECURITY OFFICER
*/

/obj/item/clothing/under/rank/security/skyrat/utility
	name = "security utility uniform"
	desc = "A utility uniform worn by Lopland-certified Security officers."
	icon_state = "util_sec"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/skyrat/utility/redsec
	desc = "A utility uniform worn by trained Security officers."
	icon_state = "util_sec_old"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate
	armor_type = /datum/armor/clothing_under/redsec_syndicate
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/security/peacekeeper/skirt
	name = "security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt."
	worn_icon_state = "security_skirt"
	icon_state = "security_skirt"
	can_adjust = TRUE
	uses_advanced_reskins = FALSE
	unique_reskin = null
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/skirt_redsec
	name = "security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt. Now in classic security red!"
	worn_icon_state = "security_skirt_redsec"
	icon_state = "security_skirt_redsec"
	can_adjust = TRUE
	uses_advanced_reskins = FALSE
	unique_reskin = null
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/skirt_hos
	name = "head of security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt. This version is specifically designed for the head of the security department!"
	worn_icon_state = "security_skirt_hos"
	icon_state = "security_skirt_hos"
	can_adjust = TRUE
	uses_advanced_reskins = FALSE
	unique_reskin = null
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/trousers
	name = "security trousers"
	desc = "Some Peacekeeper-blue combat trousers. Probably should pair it with a vest for safety."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "workpants_blue"
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "workpants_blue",
			RESKIN_WORN_ICON_STATE = "workpants_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "workpants_white",
			RESKIN_WORN_ICON_STATE = "workpants_white"
		),
	)

/obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts
	name = "security shorts"
	desc = "Some Peacekeeper-blue combat shorts. Definitely should pair it with a vest for safety."
	icon_state = "workshorts_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant, Short" = list(
			RESKIN_ICON_STATE = "workshorts_blue",
			RESKIN_WORN_ICON_STATE = "workshorts_blue"
		),
		"Blue Variant, Short Short" = list(
			RESKIN_ICON_STATE = "workshorts_blue_short",
			RESKIN_WORN_ICON_STATE = "workshorts_blue_short"
		),
		"White Variant, Short" = list(
			RESKIN_ICON_STATE = "workshorts_white",
			RESKIN_WORN_ICON_STATE = "workshorts_white"
		),
		"White Variant, Short Short" = list(
			RESKIN_ICON_STATE = "workshorts_white_short",
			RESKIN_WORN_ICON_STATE = "workshorts_white_short"
		),
	)

/obj/item/clothing/under/rank/security/peacekeeper/jumpsuit
	name = "security jumpsuit"
	desc = "Turtleneck sweater commonly worn by Peacekeepers, attached with pants."
	icon_state = "jumpsuit_blue"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/officer/skirt
	name = "security jumpskirt"
	desc = "Turtleneck sweater commonly worn by Peacekeepers, attached with a skirt."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "secskirt"


/obj/item/clothing/under/rank/security/peacekeeper/shortskirt
	name = "security shortskirt"
	desc = "Plainshirted uniform commonly worn by Peacekeepers, attached with a skirt."
	icon_state = "shortskirt_blue"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "shortskirt_blue",
			RESKIN_WORN_ICON_STATE = "shortskirt_blue"
	    ),
		"Black Variant" = list(
			RESKIN_ICON_STATE = "shortskirt_black",
			RESKIN_WORN_ICON_STATE = "shortskirt_black"
	    ),
	)

/obj/item/clothing/under/rank/security/peacekeeper/miniskirt
	name = "security miniskirt"
	desc = "This miniskirt was originally featured in a gag calendar, but entered official use once they realized its potential for arid climates."
	icon_state = "miniskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	can_adjust = TRUE
	body_parts_covered = GROIN | LEGS

/*
*	HEAD OF SECURITY
*/

/datum/armor/clothing_under/redsec_syndicate
	melee = 10
	fire = 50
	acid = 40

/obj/item/clothing/under/rank/security/head_of_security/skyrat/imperial //Rank pins of the Grand General
	desc = "A tar black naval suit and a rank badge denoting the Officer of The Internal Security Division. Be careful your underlings don't bump their head on a door."
	name = "head of security's naval jumpsuit"
	icon_state = "imphos"
