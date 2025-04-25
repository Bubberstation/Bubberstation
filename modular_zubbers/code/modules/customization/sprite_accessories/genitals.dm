/datum/sprite_accessory/genital/vagina/cloaca
	icon = 'modular_zubbers/icons/customization/genitals/vagina.dmi'

/datum/sprite_accessory/genital/splurtpenis
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/penis_onmob.dmi'
	organ_type = /obj/item/organ/genital/penis
	associated_organ_slot = ORGAN_SLOT_PENIS
	key = ORGAN_SLOT_PENIS
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	center = TRUE
	special_x_dimension = TRUE
	//default_color = DEFAULT_SKIN_OR_PRIMARY //This is the price we're paying for sheaths
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	var/can_have_sheath = TRUE

/datum/sprite_accessory/genital/penis/nondescript
	icon_state = "nondescript"
	name = "Nondescript (Alt)"

/datum/sprite_accessory/genital/penis/knotted
	icon_state = "knotted"
	name = "Knotted (Alt)"

/datum/sprite_accessory/genital/penis/flared
	icon_state = "flared"
	name = "Flared (Alt)"

/datum/sprite_accessory/genital/penis/barbknot
	icon_state = "barbknot"
	name = "Barbed, Knotted (Alt)"

/datum/sprite_accessory/genital/penis/tapered
	icon_state = "tapered"
	name = "Tapered (Alt)"

/datum/sprite_accessory/genital/penis/tentacle
	icon_state = "tentacle"
	name = "Tentacled (Alt)"

/datum/sprite_accessory/genital/penis/hemi
	icon_state = "hemi"
	name = "Hemi (Alt)"

/datum/sprite_accessory/genital/penis/hemiknot
	icon_state = "hemiknot"
	name = "Knotted Hemi (Alt)"

/datum/sprite_accessory/genital/splurtbreasts
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/breasts_onmob.dmi'
	organ_type = /obj/item/organ/genital/breasts
	associated_organ_slot = ORGAN_SLOT_BREASTS
	key = ORGAN_SLOT_BREASTS
	always_color_customizable = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	has_skintone_shading = TRUE
	genital_location = CHEST
	genetic = TRUE

/datum/sprite_accessory/genital/breasts/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/breasts/pair
	icon_state = "pair (Alt)"
	name = "Pair"

/datum/sprite_accessory/genital/breasts/quad
	icon_state = "quad (Alt)"
	name = "Quad"

/datum/sprite_accessory/genital/breasts/sextuple
	icon_state = "sextuple (Alt)"
	name = "Sextuple"

/datum/sprite_accessory/genital/splurttesticles
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/testicles_onmob.dmi'
	organ_type = /obj/item/organ/genital/testicles
	associated_organ_slot = ORGAN_SLOT_TESTICLES
	key = ORGAN_SLOT_TESTICLES
	always_color_customizable = TRUE
	special_x_dimension = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevent_layers = list(BODY_ADJ_LAYER, BODY_BEHIND_LAYER)
	genetic = TRUE
	var/has_size = TRUE

/datum/sprite_accessory/genital/testicles/pair
	name = "Pair (Alt)"
	icon_state = "pair"
	has_skintone_shading = TRUE

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

/datum/sprite_accessory/genital/anus
	icon = 'modular_zubbers/icons/mob/sprite_accesory/genitals/anus.dmi'
	color_src = USE_MATRIXED_COLORS
	has_skintone_shading = TRUE
	always_color_customizable = TRUE
	relevent_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/genital/anus/donut
	icon_state = "donut"
	name = "Donut"

/datum/sprite_accessory/genital/anus/squished
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
