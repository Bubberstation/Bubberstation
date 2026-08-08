/obj/item/clothing/under/rank/captain
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/command_digi.dmi' //Anything that was in TG's captain.dmi, should be in our command_digi.dmi
	//NOTE - TG uses "captain.dmi"; because we have a few non-captain items going in here for ease of access, this will just be "command.dmi"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/captain/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/command.dmi'

/*
*	CAPTAIN
*/

/obj/item/clothing/under/rank/captain/skyrat/kilt
	name = "captain's kilt"
	desc = "A midnight blue kilt, padded with nano-kevlar and adorned with gold and a tartan sash."
	icon_state = "capkilt"

/obj/item/clothing/under/rank/captain/skyrat/shipdress
	name = "captain's dress"
	desc = "A blue dress adorned with a gold trim. Perfect for a formal dinner."
	icon_state = "terragov_dress"
	can_adjust = FALSE

//Donor item for Gandalf - all donors have access
/obj/item/clothing/under/rank/captain/skyrat/black
	name = "captain's black suit"
	desc = "A very sleek, albeit outdated, naval captain's uniform for those who think they're commanding a battleship."
	icon_state = "captainblacksuit"
	can_adjust = FALSE

/*
*	BLUESHIELD
*/
//Why is this in command.dm? Simple: Centcom.dmi will already be packed with CC/NTNavy/AD/LL/TERRA/FTU - all of them more event-based clothes, while this will appear
//on-station often.

/obj/item/clothing/under/rank/blueshield
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/command.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/command_digi.dmi'
	name = "blueshield's suit"
	desc = "A classic bodyguard's suit, with custom-fitted Blueshield-Blue cuffs and a Nanotrasen insignia over one of the pockets."
	icon_state = "blueshield"
	strip_delay = 50
	armor_type = /datum/armor/clothing_under/rank_blueshield
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	alt_covers_chest = TRUE

/datum/armor/clothing_under/rank_blueshield
	melee = 10
	bullet = 5
	laser = 5
	energy = 10
	bomb = 10
	fire = 50
	acid = 50

/obj/item/clothing/under/rank/blueshield/skirt
	name = "blueshield's suitskirt"
	desc = "A classic bodyguard's suitskirt, with custom-fitted Blueshield-Blue cuffs and a Nanotrasen insignia over one of the pockets."
	icon_state = "blueshieldskirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/blueshield/turtleneck
	name = "blueshield's turtleneck"
	desc = "A tactical jumper fit for only the best of bodyguards, with plenty of tactical pockets for your tactical needs."
	icon_state = "bs_turtleneck"

/obj/item/clothing/under/rank/blueshield/turtleneck/skirt
	name = "blueshield's skirtleneck"
	desc = "A tactical jumper fit for only the best of bodyguards - instead of tactical pockets, this one has a tactical lack of leg protection."
	icon_state = "bs_skirtleneck"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

//These next four items are by RealWinterFrost of NovaStation.

/obj/item/clothing/under/rank/blueshield/consult
	name = "blueshield's consulting suit"
	desc = "A not so tactical uniform, held up to a greater standard of care by the company, tailored to be fancy with its golden trims matching that of the Nanotrasen Consultant. A symbol of unity, cohesion, and an annoyingly massive amount of paperwork."
	icon_state = "bs_consult"

/obj/item/clothing/under/rank/blueshield/consult/skirt
	name = "blueshield's consulting skirt"
	icon_state = "bs_consult_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/blueshield/russian
	name = "blueshield's sweatsuit"
	desc = "An older styled jumpsuit meant for military application by soldiers, still plenty useful nowadays, dyed and seamed to newer NT standards."
	icon_state = "bs_rus"
	can_adjust = FALSE

/obj/item/clothing/under/rank/blueshield/formal
	name = "blueshield's formal uniform"
	desc = "A budget efficient uniform, making yourself stand out from others yet not drawing too much attention."
	icon_state = "bs_formal"

/obj/item/clothing/under/rank/blueshield/naval
	name = "blueshield's naval uniform"
	desc = "An upper level uniform granted to shields alike, representing CentCom's grand naval fleet."
	icon_state = "bs_grandnaval"
	can_adjust = FALSE

/*
*	NT CONSULTANT
*/
//See Blueshield note - tl;dr, this role is a station role, while Centcom.dmi is more event roles

/obj/item/clothing/under/rank/nanotrasen_consultant
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/command.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/command_digi.dmi'
	desc = "It's a green jumpsuit with some gold markings denoting the rank of \"Nanotrasen Consultant\"."
	name = "nanotrasen consultant's jumpsuit"
	icon_state = "nt_consultant"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/nanotrasen_consultant/skirt
	name = "nanotrasen consultant's jumpskirt"
	desc = "It's a green jumpskirt with some gold markings denoting the rank of \"Nanotrasen Consultant\"."
	icon_state = "nt_consultant_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

//By RealWinterFrost of NovaStation.
/obj/item/clothing/under/rank/nanotrasen_consultant/naval
	name = "nanotrasen consultant's naval uniform"
	desc = "An upper level uniform granted to consultants and representatives alike, representing CentCom's grand naval fleet."
	icon_state = "nt_grandnaval"
	can_adjust = FALSE

/*
*	Bridge Officer -- Sprites from RealWinterFrost of NovaStation
*/

/obj/item/clothing/under/rank/bridge_assistant
	name = "bridge assistant's jumpsuit"
	desc = "It's a blue jumpsuit with silver markings denoting the rank of \"Bridge Assistant\". For those big enough to be on the bridge, but not big enough to touch the buttons."
	icon_state = "bo_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/command.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/command_digi.dmi'
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/bridge_assistant/skirt
	name = "bridge assistant's jumpskirt"
	desc = "It's a blue jumpskirt with silver markings denoting the rank of \"Bridge Assistant\". For those big enough to be on the bridge, but not big enough to touch the buttons."
	icon_state = "bo_skirt"

/obj/item/clothing/under/rank/bridge_assistant/turtle
	name = "bridge assistant's turtleneck"
	desc = "It's a blue turtleneck with silver markings denoting the rank of \"Bridge Assistant\". For those big enough to be on the bridge, but not big enough to touch the buttons."
	icon_state = "bo_turtleneck"

/obj/item/clothing/under/rank/bridge_assistant/turtle/skirt
	name = "bridge assistant's skirtleneck"
	desc = "It's a blue skirtleneck with silver markings denoting the rank of \"Bridge Assistant\". For those big enough to be on the bridge, but not big enough to touch the buttons."
	icon_state = "bo_skirtleneck"

/*
*	UNASSIGNED (Any head of staff)
*/

/obj/item/clothing/under/rank/captain/skyrat/utility
	name = "command utility uniform"
	desc = "A utility uniform worn by Station Command."
	icon_state = "util_com"
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/skyrat/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/*
*	MISC
*/

/obj/item/clothing/under/rank/captain/skyrat/pilot
	name = "shuttle pilot's jumpsuit"
	desc = "It's a blue jumpsuit with some silver markings denoting the wearer as a certified pilot."
	icon_state = "pilot"
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/skyrat/pilot/skirt
	name = "shuttle pilot's jumpskirt"
	desc = "It's a blue jumpskirt with some silver markings denoting the wearer as a certified pilot."
	icon_state = "pilot_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
