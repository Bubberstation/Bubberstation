/obj/item/bodypart/arm/left/kinetic
	name = "left kinetic prosthetic arm"
	desc = "A simple, yet elegantly designed, prosthetic. Intended to give some functionality back to the user and retain the appearance of an organic arm, but its use is limited to simple actions, as it lacks fine motor control."
	icon_static = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon_state = "kinetic_l_arm"
	limb_id = BODYPART_ID_KINETIC
	bodytype = BODYTYPE_KINETIC
	should_draw_greyscale = FALSE
	attack_verb_simple = list("bashed", "slashed")
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_KINETIC
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_EASYDISMEMBER)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = BIO_INORGANIC

/obj/item/bodypart/arm/left/kinetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/arm/right/kinetic
	name = "right kinetic prosthetic arm"
	desc = "A simple, yet elegantly designed, prosthetic. Intended to give some functionality back to the user and retain the appearance of an organic arm, but its use is limited to simple actions, as it lacks fine motor control."
	icon_static = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon_state = "kinetic_r_arm"
	limb_id = BODYPART_ID_KINETIC
	bodytype = BODYTYPE_KINETIC
	should_draw_greyscale = FALSE
	attack_verb_simple = list("bashed", "slashed")
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_KINETIC
	bodypart_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_EASYDISMEMBER)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = BIO_INORGANIC

/obj/item/bodypart/arm/right/kinetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/leg/left/kinetic
	name = "left kinetic prosthetic leg"
	desc = "A simple, yet elegantly designed, prosthetic. Rather than a normal foot on the end, this prosthetic is fitted with a simple blade style foot, allowing the user to walk as normal."
	icon_static = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon_state = "kinetic_r_leg"
	limb_id = BODYPART_ID_KINETIC
	bodytype = BODYTYPE_KINETIC
	should_draw_greyscale = FALSE
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_KINETIC
	bodypart_traits = list(TRAIT_EASYDISMEMBER)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = BIO_INORGANIC

/obj/item/bodypart/leg/left/kinetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)

/obj/item/bodypart/leg/right/kinetic
	name = "right kinetic prosthetic leg"
	desc = "A simple, yet elegantly designed, prosthetic. Rather than a normal foot on the end, this prosthetic is fitted with a simple blade style foot, allowing the user to walk as normal."
	icon_static = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon = 'modular_zubbers/icons/mob/human/kinetic.dmi'
	icon_state = "kinetic_l_leg"
	limb_id = BODYPART_ID_KINETIC
	bodytype = BODYTYPE_KINETIC
	should_draw_greyscale = FALSE
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_KINETIC
	bodypart_traits = list(TRAIT_EASYDISMEMBER)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	biological_state = BIO_INORGANIC

/obj/item/bodypart/leg/right/kinetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASY_ATTACH, INNATE_TRAIT)
