/datum/sprite_accessory/wings/mammal/sylveon
	name = "Sylveon ribbons"
	icon = 'modular_zubbers/icons/customization/wings.dmi'
	icon_state = "sylveon_bow" // SPRITE CREDIT - https://github.com/SPLURT-Station/S.P.L.U.R.T-Station-13/pull/375
	color_src = USE_MATRIXED_COLORS
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

	dimension_x = 45
	dimension_y = 34

// AEROMORPH/AIRPLANE WINGS - All of them except for 'Airplane' (which is from Hyperstation) are ported from SPLURT, with minor adjustments.

/datum/sprite_accessory/wings/robotic/aeromorph
	icon = 'modular_zubbers/icons/customization/wings.dmi'
	color_src = USE_ONE_COLOR
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	center = TRUE
	dimension_x = 45
	dimension_y = 34

/datum/sprite_accessory/wings/robotic/aeromorph/delta
	name = "Aeromorph Delta"
	icon_state = "delta"

/datum/sprite_accessory/wings/robotic/aeromorph/variable
	name = "Aeromorph Variable"
	icon_state = "variable"

/datum/sprite_accessory/wings/robotic/aeromorph/straight
	name = "Aeromorph Straight"
	icon_state = "straight"

/datum/sprite_accessory/wings/robotic/aeromorph/swept
	name = "Aeromorph Swept"
	icon_state = "swept"

/datum/sprite_accessory/wings/robotic/aeromorph/flyingwing
	name = "Aeromorph Flying"
	icon_state = "flyingwing"

/datum/sprite_accessory/wings/robotic/aeromorph/airplane
	name = "Aeromorph Hyper"
	icon = 'modular_zubbers/icons/mob/sprite_accesory/wings.dmi'
	icon_state = "airplane_hyper"
	color_src = USE_MATRIXED_COLORS
	dimension_x = 32
	dimension_y = 32
