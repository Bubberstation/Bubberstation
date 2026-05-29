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
	icon_state = "util_sec_old"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/skyrat/utility/redsec
	desc = "A utility uniform worn by trained Security officers."
	icon_state = "util_sec_old"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/skyrat/utility/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate
	armor_type = /datum/armor/clothing_under/redsec_syndicate
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/security/peacekeeper/skirt
	name = "security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_state = "security_skirt_redsec"
	icon_state = "security_skirt_redsec"
	can_adjust = TRUE
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/skirt_redsec
	name = "security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt. Now in classic security red!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_state = "security_skirt_redsec"
	icon_state = "security_skirt_redsec"
	can_adjust = TRUE
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/skirt_redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/peacekeeper/trousers
	name = "security trousers"
	desc = "Some red security combat trousers. Probably should pair it with a vest for safety."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "workpants_red"
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS

/obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts
	name = "security shorts"
	desc = "Some red security combat shorts. Definitely should pair it with a vest for safety."
	icon_state = "workshorts_red"

/obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_peacekeeper_shorts)

/datum/atom_skin/security_peacekeeper_shorts
	abstract_type = /datum/atom_skin/security_peacekeeper_shorts

/datum/atom_skin/security_peacekeeper_shorts/red_short
	preview_name = "Red Variant, Short"
	new_icon_state = "workshorts_red"

/datum/atom_skin/security_peacekeeper_shorts/red_short_short
	preview_name = "Red Variant, Short Short"
	new_icon_state = "workshorts_red_short"

/obj/item/clothing/under/rank/security/peacekeeper/jumpsuit
	name = "security jumpsuit"
	desc = "Turtleneck sweater commonly worn by Peacekeepers, attached with pants."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "jumpsuit_red"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/officer/skirt
	name = "security jumpskirt"
	desc = "Turtleneck sweater commonly worn by Peacekeepers, attached with a skirt."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "secskirt"

/obj/item/clothing/under/rank/security/peacekeeper/miniskirt
	name = "security miniskirt"
	desc = "This miniskirt was originally featured in a gag calendar, but entered official use once they realized its potential for arid climates."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "miniskirt_red"
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
