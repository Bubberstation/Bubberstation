/obj/item/bodypart/head/mutant/lycan
	icon_greyscale = BODYPART_ICON_LYCAN
	limb_id = SPECIES_LYCAN
	is_dimorphic = TRUE
	head_flags = HEAD_DEFAULT_FEATURES
	teeth_count = 42 // Wolves have 42 teeth :)

/obj/item/bodypart/chest/mutant/lycan
	icon_greyscale = BODYPART_ICON_LYCAN
	limb_id = SPECIES_LYCAN
	is_dimorphic = TRUE

/obj/item/bodypart/chest/mutant/lycan/get_butt_sprite()
	return icon('modular_skyrat/master_files/icons/mob/butts.dmi', BUTT_SPRITE_VULP) // I can't be bothered making a new sprite.

/obj/item/bodypart/arm/left/mutant/lycan
	icon_greyscale = BODYPART_ICON_LYCAN
	limb_id = SPECIES_LYCAN
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	grappled_attack_verb = "lacerate"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
	bodypart_traits = list(TRAIT_CHUNKYFINGERS)

	unarmed_damage_low = 15
	unarmed_damage_high = 15
	unarmed_sharpness = SHARP_EDGED

/obj/item/bodypart/arm/right/mutant/lycan
	icon_greyscale = BODYPART_ICON_LYCAN
	limb_id = SPECIES_LYCAN
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	grappled_attack_verb = "lacerate"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
	bodypart_traits = list(TRAIT_CHUNKYFINGERS)

	unarmed_damage_low = 15
	unarmed_damage_high = 15
	unarmed_sharpness = SHARP_EDGED

/obj/item/bodypart/leg/left/mutant/lycan
	icon_greyscale = BODYPART_ICON_LYCAN
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/lycan
	limb_id = SPECIES_LYCAN

/obj/item/bodypart/leg/right/mutant/lycan
	icon_greyscale = BODYPART_ICON_LYCAN
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/lycan
	limb_id = SPECIES_LYCAN

/obj/item/bodypart/leg/left/digitigrade/lycan
	icon_greyscale = BODYPART_ICON_LYCAN

/obj/item/bodypart/leg/right/digitigrade/lycan
	icon_greyscale = BODYPART_ICON_LYCAN
