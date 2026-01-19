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

/obj/item/clothing/under/rank/security/skyrat/utility/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_utility)

/datum/atom_skin/security_utility
	abstract_type = /datum/atom_skin/security_utility

/datum/atom_skin/security_utility/blue
	preview_name = "Blue Variant"
	new_icon_state = "util_sec"

/datum/atom_skin/security_utility/red
	preview_name = "Red Variant"
	new_icon_state = "util_sec_old"

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
	worn_icon_state = "security_skirt"
	icon_state = "security_skirt"
	can_adjust = TRUE
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_peacekeeper_skirt)

/datum/atom_skin/security_peacekeeper_skirt
	abstract_type = /datum/atom_skin/security_peacekeeper_skirt

/datum/atom_skin/security_peacekeeper_skirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "security_skirt"

/datum/atom_skin/security_peacekeeper_skirt/red
	preview_name = "Red Variant"
	new_icon_state = "security_skirt_red"

/obj/item/clothing/under/rank/security/peacekeeper/skirt_redsec
	name = "security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt. Now in classic security red!"
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

/obj/item/clothing/under/rank/security/peacekeeper/skirt_hos
	name = "head of security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt. This version is specifically designed for the head of the security department!"
	worn_icon_state = "security_skirt_hos"
	icon_state = "security_skirt_hos"
	can_adjust = TRUE
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/skirt_hos/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

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

/obj/item/clothing/under/rank/security/peacekeeper/trousers/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_peacekeeper_trousers)

/datum/atom_skin/security_peacekeeper_trousers
	abstract_type = /datum/atom_skin/security_peacekeeper_trousers

/datum/atom_skin/security_peacekeeper_trousers/blue
	preview_name = "Blue Variant"
	new_icon_state = "workpants_blue"

/datum/atom_skin/security_peacekeeper_trousers/white
	preview_name = "White Variant"
	new_icon_state = "workpants_white"

/datum/atom_skin/security_peacekeeper_trousers/red
	preview_name = "Red Variant"
	new_icon_state = "workpants_red"

/obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts
	name = "security shorts"
	desc = "Some Peacekeeper-blue combat shorts. Definitely should pair it with a vest for safety."
	icon_state = "workshorts_blue"

/obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_peacekeeper_shorts)

/datum/atom_skin/security_peacekeeper_shorts
	abstract_type = /datum/atom_skin/security_peacekeeper_shorts

/datum/atom_skin/security_peacekeeper_shorts/blue_short
	preview_name = "Blue Variant, Short"
	new_icon_state = "workshorts_blue"

/datum/atom_skin/security_peacekeeper_shorts/blue_short_short
	preview_name = "Blue Variant, Short Short"
	new_icon_state = "workshorts_blue_short"

/datum/atom_skin/security_peacekeeper_shorts/white_short
	preview_name = "White Variant, Short"
	new_icon_state = "workshorts_white"

/datum/atom_skin/security_peacekeeper_shorts/white_short_short
	preview_name = "White Variant, Short Short"
	new_icon_state = "workshorts_white_short"

/datum/atom_skin/security_peacekeeper_shorts/red_short
	preview_name = "Red Variant, Short"
	new_icon_state = "workshorts_red"

/datum/atom_skin/security_peacekeeper_shorts/red_short_short
	preview_name = "Red Variant, Short Short"
	new_icon_state = "workshorts_red_short"

/obj/item/clothing/under/rank/security/peacekeeper/jumpsuit
	name = "security jumpsuit"
	desc = "Turtleneck sweater commonly worn by Peacekeepers, attached with pants."
	icon_state = "jumpsuit_blue"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/jumpsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_peacekeeper_jumpsuit)

/datum/atom_skin/security_peacekeeper_jumpsuit
	abstract_type = /datum/atom_skin/security_peacekeeper_jumpsuit

/datum/atom_skin/security_peacekeeper_jumpsuit/blue
	preview_name = "Blue Variant"
	new_icon_state = "jumpsuit_blue"

/datum/atom_skin/security_peacekeeper_jumpsuit/red
	preview_name = "Red Variant"
	new_icon_state = "jumpsuit_red"

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

/obj/item/clothing/under/rank/security/peacekeeper/shortskirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_peacekeeper_shortskirt)

/datum/atom_skin/security_peacekeeper_shortskirt
	abstract_type = /datum/atom_skin/security_peacekeeper_shortskirt

/datum/atom_skin/security_peacekeeper_shortskirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "shortskirt_blue"

/datum/atom_skin/security_peacekeeper_shortskirt/black
	preview_name = "Black Variant"
	new_icon_state = "shortskirt_black"

/obj/item/clothing/under/rank/security/peacekeeper/miniskirt
	name = "security miniskirt"
	desc = "This miniskirt was originally featured in a gag calendar, but entered official use once they realized its potential for arid climates."
	icon_state = "miniskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	can_adjust = TRUE
	body_parts_covered = GROIN | LEGS

/obj/item/clothing/under/rank/security/peacekeeper/miniskirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_peacekeeper_miniskirt)

/datum/atom_skin/security_peacekeeper_miniskirt
	abstract_type = /datum/atom_skin/security_peacekeeper_miniskirt

/datum/atom_skin/security_peacekeeper_miniskirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "miniskirt"

/datum/atom_skin/security_peacekeeper_miniskirt/red
	preview_name = "Red Variant"
	new_icon_state = "miniskirt_red"

/datum/atom_skin/security_peacekeeper_miniskirt/black
	preview_name = "Black Variant"
	new_icon_state = "miniskirt_black"

/*
*	HEAD OF SECURITY
*/

/datum/armor/clothing_under/redsec_syndicate
	melee = 10
	fire = 50
	acid = 40
