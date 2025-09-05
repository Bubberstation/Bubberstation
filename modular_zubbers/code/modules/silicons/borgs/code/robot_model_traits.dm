/******************************************************
			Cyborg model trait procs below
*******************************************************/

//Quad cyborg trait
/obj/item/robot_model/proc/update_quadruped()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return
	if(model_features && ((TRAIT_R_SQUADRUPED in model_features) || (TRAIT_R_WIDE in model_features) || (TRAIT_R_BIG in model_features)))
		if(model_features && ((TRAIT_R_WIDE in model_features) || (TRAIT_R_BIG in model_features)))
			cyborg.base_pixel_w = -16 //for runechat
			cyborg.pixel_w = -16 //sprite offset
		add_verb(cyborg, /mob/living/silicon/robot/proc/rest_style)
	else
		if(model_features && (!(TRAIT_R_WIDE in model_features) || !(TRAIT_R_BIG in model_features)))
			cyborg.base_pixel_w = 0
			cyborg.pixel_w = 0
		remove_verb(cyborg, /mob/living/silicon/robot/proc/rest_style)

// Cyborg foot step traits
/obj/item/robot_model/proc/update_footsteps()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return

	if (model_features)
		// This is ugly but there is unironically not a better way
		if (TRAIT_R_SQUADRUPED in model_features)
			cyborg.AddElement(/datum/element/footstep, FOOTSTEP_ROBOT_SMALL, 6, -6, sound_vary = TRUE)
		else
			cyborg.RemoveElement(/datum/element/footstep, FOOTSTEP_ROBOT_SMALL, 6, -6, sound_vary = TRUE)

		if ((TRAIT_R_TALL in model_features) || (TRAIT_R_BIG in model_features))
			cyborg.AddElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE, 2, -6, sound_vary = TRUE)
		else
			cyborg.RemoveElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE, 2, -6, sound_vary = TRUE)

//Cyborg resting trait for cyborgs that have a resting state
/obj/item/robot_model/proc/update_robot_rest()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return
	if(model_features && ((TRAIT_R_SQUADRUPED in model_features) || (TRAIT_R_WIDE in model_features) || (TRAIT_R_TALL in model_features) || (TRAIT_R_BIG in model_features)))
		add_verb(cyborg, /mob/living/silicon/robot/proc/robot_lay_down)
	else
		remove_verb(cyborg, /mob/living/silicon/robot/proc/robot_lay_down)

// TODO: Move Cat like grace to it's own thing
//For cyborgs who have a lighter chassis
// !!!NOTE WORKS BEST WITH ONLY 32 X 32 CYBORBG SPRITES!!!
/obj/item/robot_model/proc/update_lightweight()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return
	if (model_features && (TRAIT_R_LIGHT_WEIGHT in model_features))
		cyborg.can_be_held = TRUE
		cyborg.held_w_class = WEIGHT_CLASS_HUGE
		cyborg.add_traits(list(TRAIT_CATLIKE_GRACE), INNATE_TRAIT)
		cyborg.mob_size = MOB_SIZE_SMALL
	else
		cyborg.can_be_held = FALSE
		cyborg.held_w_class = WEIGHT_CLASS_NORMAL
		cyborg.remove_traits(list(TRAIT_CATLIKE_GRACE), INNATE_TRAIT)
		cyborg.mob_size = MOB_SIZE_HUMAN
