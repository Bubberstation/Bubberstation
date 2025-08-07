// SHADEKIN //

/obj/item/bodypart/head/shadekin
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_SHADEKIN
	is_dimorphic = TRUE
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/chest/shadekin
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_SHADEKIN
	is_dimorphic = TRUE
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/arm/left/shadekin
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/arm/right/shadekin
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/leg/left/shadekin
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/shadekin

/obj/item/bodypart/leg/right/shadekin
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/shadekin

/obj/item/bodypart/leg/left/digitigrade/shadekin
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = BODYPART_ID_DIGITIGRADE
	footprint_sprite = FOOTPRINT_SPRITE_PAWS
	footstep_type = FOOTSTEP_MOB_CLAW
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/leg/right/digitigrade/shadekin
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = BODYPART_ID_DIGITIGRADE
	footprint_sprite = FOOTPRINT_SPRITE_PAWS
	footstep_type = FOOTSTEP_MOB_CLAW
	brute_modifier = 1.2
	burn_modifier = 1.2

// XENOMORPH // - Original in modular_skyrat\modules\bodyparts\code\xenohybrid_bodyparts.dm

/obj/item/bodypart/head/mutant/xenohybrid
	burn_modifier = 1.15

/obj/item/bodypart/chest/mutant/xenohybrid
	burn_modifier = 1.15

/obj/item/bodypart/arm/left/mutant/xenohybrid
	burn_modifier = 1.15
	unarmed_attack_verbs = list("slash")
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/arm/right/mutant/xenohybrid
	burn_modifier = 1.15
	unarmed_attack_verbs = list("slash")
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/leg/left/mutant/xenohybrid
	burn_modifier = 1.15

/obj/item/bodypart/leg/right/mutant/xenohybrid
	burn_modifier = 1.15

/obj/item/bodypart/leg/left/digitigrade/xenohybrid
	burn_modifier = 1.15

/obj/item/bodypart/leg/right/digitigrade/xenohybrid
	burn_modifier = 1.15

// MUTANT HUMAN PART OVERRIDES - HEMOPHAGE AND HUMANOID SPRITE OVERRIDES//

/obj/item/bodypart/head/mhuman
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_MUTANT_HUMAN

/obj/item/bodypart/chest/mhuman
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_MUTANT_HUMAN

/obj/item/bodypart/arm/left/mhuman
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL

/obj/item/bodypart/arm/right/mhuman
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL

/obj/item/bodypart/leg/left/mhuman
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_MUTANT_HUMAN

/obj/item/bodypart/leg/right/mhuman
	icon_greyscale = BODYPART_ICON_BUBBER
	limb_id = SPECIES_MUTANT_HUMAN
