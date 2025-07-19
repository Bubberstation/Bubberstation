/obj/item/bodypart/head/mutant/werewolf
	icon_greyscale = 'modular_zubbers/code/modules/customization/species/werewolves/bodyparts/bodyparts.dmi'
	limb_id = SPECIES_WEREWOLF
	is_dimorphic = FALSE
	head_flags = HEAD_ALL_FEATURES
	teeth_count = 42 // Wolves have 42 teeth :)

/obj/item/bodypart/chest/mutant/werewolf
	icon_greyscale = 'modular_zubbers/code/modules/customization/species/werewolves/bodyparts/bodyparts.dmi'
	limb_id = SPECIES_WEREWOLF
	is_dimorphic = TRUE
	wing_types = list(/obj/item/organ/wings/functional/angel) // Sure, I guess.

/obj/item/bodypart/chest/mutant/werewolf/get_butt_sprite()
	return icon('icons/mob/butts.dmi', BUTT_SPRITE_FUZZY) // I can't be bothered making a new sprite.

/obj/item/bodypart/arm/left/mutant/werewolf
	icon_greyscale = 'modular_zubbers/code/modules/customization/species/werewolves/bodyparts/bodyparts.dmi'
	limb_id = SPECIES_WEREWOLF
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	grappled_attack_verb = "lacerate"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
	bodypart_traits = list(TRAIT_CHUNKYFINGERS)

/obj/item/bodypart/arm/right/mutant/werewolf
	icon_greyscale = 'modular_zubbers/code/modules/customization/species/werewolves/bodyparts/bodyparts.dmi'
	limb_id = SPECIES_WEREWOLF
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	grappled_attack_verb = "lacerate"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
	bodypart_traits = list(TRAIT_CHUNKYFINGERS)

/obj/item/bodypart/leg/left/mutant/werewolf
	icon_greyscale = 'modular_zubbers/code/modules/customization/species/werewolves/bodyparts/bodyparts.dmi'
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/werewolf
	limb_id = SPECIES_WEREWOLF

/obj/item/bodypart/leg/right/mutant/werewolf
	icon_greyscale = 'modular_zubbers/code/modules/customization/species/werewolves/bodyparts/bodyparts.dmi'
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/werewolf
	limb_id = SPECIES_WEREWOLF

/obj/item/bodypart/leg/left/digitigrade/werewolf
	icon_greyscale = 'modular_zubbers/code/modules/customization/species/werewolves/bodyparts/bodyparts.dmi'

/obj/item/bodypart/leg/right/digitigrade/werewolf
	icon_greyscale = 'modular_zubbers/code/modules/customization/species/werewolves/bodyparts/bodyparts.dmi'
