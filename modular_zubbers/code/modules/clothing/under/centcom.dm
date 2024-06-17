/obj/item/clothing/under/rank/centcom/bubber
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'

/obj/item/clothing/under/rank/centcom/bubber/commander
	name = "\improper CentCom commander's suit"
	desc = "It's a suit worn by CentCom's highest-tier Commanders."
	icon_state = "centcom"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/centcom/bubber/commander/skirt
	name = "\improper CentCom commander's suitskirt"
	desc = "It's a suitskirt worn by CentCom's highest-tier Commanders."
	icon_state = "centcom_skirt"
	inhand_icon_state = "dg_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/centcom/bubber/official
	name = "\improper CentCom official's suit"
	desc = "A suit worn by CentCom Officials, with a silver belt buckle to indicate their rank from a glance."
	icon_state = "official"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/centcom/bubber/intern
	name = "\improper CentCom intern's uniform"
	desc = "It's a uniform worn by those interning for CentCom. The top is styled after a polo shirt for easy identification."
	icon_state = "intern"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/centcom/bubber/intern/head
	name = "\improper CentCom head intern's uniform"
	desc = "It's a jumpsuit worn by leaders of those interning for CentCom. The top is styled after a polo shirt for easy identification, along with well-earned pants."
	icon_state = "head_intern"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/centcom/bubber/officer/commander
	name = "\improper CentCom tactical commander's turtleneck suit"
	desc = "A casual, yet refined green turtleneck, above some combat trousers with a addition of gold insignia. Used by CentCom Team Commanders. It has a fragrance of aloe."
	icon_state = "commander"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/centcom/bubber/officer/commander/skirt
	name = "\improper CentCom tactical commander's turtleneck skirt"
	desc = "A casual, yet refined green turtleneck, above a well kempt skirt with a addition of gold insignia. Used by CentCom Team Commanders. It has a fragrance of aloe."
	icon_state = "commander_skirt"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/centcom/bubber/officer
	name = "\improper CentCom tactical turtleneck suit"
	desc = "A casual, yet refined green turtleneck, above some combat trousers. Used by CentCom Team Officers. It has a fragrance of aloe."
	icon_state = "officer"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/centcom/bubber/officer/skirt
	name = "\improper CentCom tactical turtleneck skirt"
	desc = "A casual, yet refined green turtleneck, above a well kempt skirt. Used by CentCom Team Officers. It has a fragrance of aloe."
	icon_state = "officer_skirt"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/centcom/bubber/officer/replica
	name = "\improper CentCom turtleneck replica"
	desc = "A cheap copy of the CentCom turtleneck! A Donk Co. logo can be seen on the collar."
	icon_state = "fakecent"

/obj/item/clothing/under/rank/centcom/bubber/officer/skirt/replica
	name = "\improper CentCom turtleneck skirt replica"
	desc = "A cheap copy of the CentCom turtleneck skirt! A Donk Co. logo can be seen on the collar."
	icon_state = "fakecent_skirt"

/obj/item/clothing/under/rank/centcom/bubber/civil
	name = "\improper CentCom turtleneck suit"
	desc = "A casual, yet refined green turtleneck, above some formal trousers. Used by CentCom Employees. It has a slight fragrance of aloe."
	icon_state = "fakecent"

/obj/item/clothing/under/rank/centcom/bubber/consultant
	name = "CentCom consultant's suit"
	desc = "It's a classic CentCom uniform, resembles the Commander's, but is silver and denotes the rank of \"Nanotrasen Consultant\"."
	icon_state = "ntconsultant"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/centcom/bubber/consultant/skirt
	name = "CentCom consultant's suitskirt"
	desc = "It's a classic CentCom uniform with a skirt, resembles the Commander's, but is silver and denotes the rank of \"Nanotrasen Consultant\"."
	icon_state = "ntconsultant_skirt"
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/centcom/bubber/military
	name = "tactical combat uniform"
	desc = "A dark colored uniform worn by CentCom's conscripted military forces."
	icon_state = "military"
	inhand_icon_state = "bl_suit"
	armor_type = /datum/armor/clothing_under/centcom_military

/obj/item/clothing/under/rank/centcom/bubber/military/eng
	name = "tactical engineering uniform"
	desc = "A dark colored uniform worn by CentCom's regular military engineers."
	icon_state = "military_eng"

/obj/item/clothing/under/rank/centcom/bubber/military/eng
	name = "tactical medical uniform"
	desc = "A dark colored uniform worn by CentCom's regular military medics."
	icon_state = "military_med"
