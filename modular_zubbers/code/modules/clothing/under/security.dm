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

/obj/item/clothing/under/rank/security/officer/turtleneck
	name = "security turtleneck"
	desc = "A tactical turtleneck meant for those long nights out on the night shift."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "jumpsuit_red"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Virosec, sprites by axietheaxolotl

/obj/item/clothing/under/rank/security/viro/officer/
	name = "security uniform"
	desc = "A tactical security jumpsuit for officers complete with Nanotrasen belt buckle."
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon_state = "security_uniform_v"
	inhand_icon_state = "r_suit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/officer/lowcut
	name = "low-cut security uniform"
	desc = "A tactical security uniform for officers, complete lower-cut top."
	icon_state = "security_lowcut"
	inhand_icon_state = "r_suit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/officer/skirt/
	name = "security skirt"
	desc = "A \"tactical\" security uniform with the legs replaced by a skirt."
	icon_state = "security_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/officer/formal/
	name = "security officer's formal uniform"
	desc = "The latest in fashionable security outfits."
	icon_state = "security_formals"
	inhand_icon_state = "r_suit"
	alt_covers_chest = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/officer/bodysuit
	name = "seucrity officer's bodysuit"
	desc = "The latest in form-fitting, high speed, and low drag security equipment."
	icon_state = "security_bodysuit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/officer/bodysuit/equipped(mob/living/affected_mob, slot)
	. = ..()
	var/mob/living/carbon/human/affected_human = affected_mob
	if(src == affected_human.w_uniform)
		if(affected_mob.gender == FEMALE)
			icon_state = "security_bodysuit_female"
		else
			icon_state = "security_bodysuit_male"

	affected_mob.update_worn_undersuit()

/obj/item/clothing/under/rank/security/viro/warden/
	name = "security suit"
	desc = "A formal security suit for officers complete with Nanotrasen belt buckle."
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon_state = "warden_uniform"
	inhand_icon_state = "r_suit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/warden/skirt/
	name = "warden's suitskirt"
	desc = "A formal security suitskirt for officers complete with Nanotrasen belt buckle."
	icon_state = "warden_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/warden/formal/
	desc = "The insignia on this uniform tells you that this uniform belongs to the Warden."
	name = "warden's formal uniform"
	icon_state = "wardenblueclothes"
	inhand_icon_state = null
	alt_covers_chest = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/viro/warden/formal/skirt
	desc = "The insignia on this uniform tells you that this uniform belongs to the Warden. This one has a skirt."
	name = "warden's formal uniform"
	icon_state = "wardenblueclothes_skirt"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/head_of_security/viro
	name = "head of security's uniform"
	desc = "A security jumpsuit decorated for those few with the dedication to achieve the position of Head of Security."
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon_state = "hos_uniform"
	inhand_icon_state = "r_suit"
	armor_type = /datum/armor/clothing_under/security_head_of_security
	strip_delay = 6 SECONDS

/datum/armor/clothing_under/security_head_of_security
	melee = 10
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/under/rank/security/viro/head_of_security/skirt
	name = "head of security's skirt"
	desc = "A security jumpskirt decorated for those few with the dedication to achieve the position of Head of Security."
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon_state = "hos_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/head_of_security/alt
	name = "head of security's turtleneck"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with tactical pants."
	icon_state = "hosalt"
	inhand_icon_state = "bl_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	name = "head of security's turtleneck skirt"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with a tactical skirt."
	icon_state = "hosalt_skirt"
	inhand_icon_state = "bl_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alt_covers_chest = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/viro/head_of_security/formal
	desc = "The insignia on this uniform tells you that this uniform belongs to the Head of Security."
	name = "head of security's formal uniform"
	icon_state = "hosblueclothes"
	inhand_icon_state = null
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/viro/head_of_security/formal/skirt
	desc = "The insignia on this uniform tells you that this uniform belongs to the Head of Security."
	name = "head of security's formal uniform skirt"
	icon_state = "hosblueclothes"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
