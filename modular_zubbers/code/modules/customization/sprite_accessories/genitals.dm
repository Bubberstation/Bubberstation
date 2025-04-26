/datum/sprite_accessory/genital/vagina/cloaca
	icon = 'modular_zubbers/icons/customization/genitals/vagina.dmi'

/datum/sprite_accessory/genital/penis/alt
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/penis_onmob.dmi'

/datum/sprite_accessory/genital/penis/alt/human
	name = "Human (Alt)"
	icon_state = "human"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SKIN_OR_PRIMARY
	has_skintone_shading = TRUE
	can_have_sheath = FALSE

/datum/sprite_accessory/genital/penis/alt/nondescript
	name = "Nondescript (Alt)"
	icon_state = "nondescript"

/datum/sprite_accessory/genital/penis/alt/knotted
	name = "Knotted (Alt)"
	icon_state = "knotted"

/datum/sprite_accessory/genital/penis/alt/flared
	name = "Flared (Alt)"
	icon_state = "flared"

/datum/sprite_accessory/genital/penis/alt/barbknot
	name = "Barbed, Knotted (Alt)"
	icon_state = "barbknot"

/datum/sprite_accessory/genital/penis/alt/tapered
	name = "Tapered (Alt)"
	icon_state = "tapered"

/datum/sprite_accessory/genital/penis/alt/tentacle
	name = "Tentacled (Alt)"
	icon_state = "tentacle"

/datum/sprite_accessory/genital/penis/alt/hemi
	name = "Hemi (Alt)"
	icon_state = "hemi"

/datum/sprite_accessory/genital/penis/alt/hemiknot
	name = "Knotted Hemi (Alt)"
	icon_state = "hemiknot"

/*
/datum/sprite_accessory/genital/penis/human_old
	icon_state = /datum/sprite_accessory/genital/penis/human::icon_state
	name = /datum/sprite_accessory/genital/penis/human::name + " (Old)"
	color_src = /datum/sprite_accessory/genital/penis/human::color_src
	default_color = /datum/sprite_accessory/genital/penis/human::default_color
	has_skintone_shading = /datum/sprite_accessory/genital/penis/human::has_skintone_shading
	can_have_sheath = /datum/sprite_accessory/genital/penis/human::can_have_sheath

/datum/sprite_accessory/genital/penis/nondescript_old
	icon_state = /datum/sprite_accessory/genital/penis/nondescript::icon_state
	name = /datum/sprite_accessory/genital/penis/nondescript::name + " (Old)"

/datum/sprite_accessory/genital/penis/knotted_old
	icon_state = /datum/sprite_accessory/genital/penis/knotted::icon_state
	name = /datum/sprite_accessory/genital/penis/knotted::name + " (Old)"

/datum/sprite_accessory/genital/penis/flared_old
	icon_state = /datum/sprite_accessory/genital/penis/flared::icon_state
	name = /datum/sprite_accessory/genital/penis/flared::name + " (Old)"

/datum/sprite_accessory/genital/penis/barbknot_old
	icon_state = /datum/sprite_accessory/genital/penis/barbknot::icon_state
	name = /datum/sprite_accessory/genital/penis/barbknot::name + " (Old)"

/datum/sprite_accessory/genital/penis/tapered_old
	icon_state = /datum/sprite_accessory/genital/penis/tapered::icon_state
	name = /datum/sprite_accessory/genital/penis/tapered::name + " (Old)"

/datum/sprite_accessory/genital/penis/tentacle_old
	icon_state = /datum/sprite_accessory/genital/penis/tentacle::icon_state
	name = /datum/sprite_accessory/genital/penis/tentacle::name + " (Old)"

/datum/sprite_accessory/genital/penis/hemi_old
	icon_state = /datum/sprite_accessory/genital/penis/hemi::icon_state
	name = /datum/sprite_accessory/genital/penis/hemi::name + " (Old)"

/datum/sprite_accessory/genital/penis/hemiknot_old
	icon_state = /datum/sprite_accessory/genital/penis/hemiknot::icon_state
	name = /datum/sprite_accessory/genital/penis/hemiknot::name + " (Old)"
*/

/datum/sprite_accessory/genital/breasts/alt
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/breasts_onmob.dmi'
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/genital/breasts/alt/pair
	name = "Pair (Alt)"
	icon_state = "pair"

/datum/sprite_accessory/genital/breasts/alt/quad
	name = "Quad (Alt)"
	icon_state = "quad"

/datum/sprite_accessory/genital/breasts/alt/sextuple
	name = "Sextuple (Alt)"
	icon_state = "sextuple"

/*
/datum/sprite_accessory/genital/breasts/pair_old
	icon_state = /datum/sprite_accessory/genital/breasts/pair::icon_state
	name = /datum/sprite_accessory/genital/breasts/pair::name + " (Old)"

/datum/sprite_accessory/genital/breasts/quad_old
	icon_state = /datum/sprite_accessory/genital/breasts/quad::icon_state
	name = /datum/sprite_accessory/genital/breasts/quad::name + " (Old)"

/datum/sprite_accessory/genital/breasts/sextuple_old
	icon_state = /datum/sprite_accessory/genital/breasts/sextuple::icon_state
	name = /datum/sprite_accessory/genital/breasts/sextuple::name + " (Old)"
*/

/datum/sprite_accessory/genital/testicles/alt
	name = "Pair (Alt)"
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/testicles_onmob.dmi'
	icon_state = "pair"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/testicles/sheath
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/testicles_onmob.dmi'
	name = "Sheathed Pair"
	icon_state = "sheath"
	has_skintone_shading = TRUE

/*
/datum/sprite_accessory/genital/testicles/pair_old
	name = /datum/sprite_accessory/genital/testicles/pair::name + " (Old)"
	icon_state = /datum/sprite_accessory/genital/testicles/pair::icon_state
*/

// New Objects

/datum/sprite_accessory/genital/butt
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/butt.dmi'
	organ_type = /obj/item/organ/genital/butt
	associated_organ_slot = ORGAN_SLOT_BUTT
	key = ORGAN_SLOT_BUTT
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	has_skintone_shading = TRUE
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE

/datum/sprite_accessory/genital/butt/none
    icon_state = "none"
    name = SPRITE_ACCESSORY_NONE
    factual = FALSE
    color_src = null

/datum/sprite_accessory/genital/butt/pair
    icon_state = "pair"
    name = "Pair" //a pair of buns i guess

/datum/sprite_accessory/genital/anus/alt
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/anus.dmi'
	color_src = USE_MATRIXED_COLORS
	has_skintone_shading = TRUE
	always_color_customizable = TRUE
	relevent_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/genital/anus/alt/donut
	icon_state = "donut"
	name = "Donut"

/datum/sprite_accessory/genital/anus/alt/squished
	icon_state = "squished"
	name = "Squished"

/datum/sprite_accessory/genital/belly
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/belly.dmi'
	organ_type = /obj/item/organ/genital/belly
	associated_organ_slot = ORGAN_SLOT_BELLY
	key = ORGAN_SLOT_BELLY
	color_src = USE_ONE_COLOR
	always_color_customizable = TRUE
	has_skintone_shading = TRUE
	relevent_layers = list(BODY_FRONT_LAYER, BODY_BEHIND_LAYER)
	genetic = TRUE

/datum/sprite_accessory/genital/belly/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/belly/normal
	icon_state = "pair" //????
	name = "Belly"
