//S.P.L.U.R.T-tg/modular_zzplurt/code/modules/resize/smallsprite_action.dm
//Technically the same as /datum/action/small_sprite but for our macro players (I'm one of them)
#define SPRITE_SIZE 32

/datum/action/sizecode_smallsprite
	name = "Toggle Giant Sprite"
	desc = "Others will always see you as giant"
	button_icon = 'icons/mob/actions/actions_xeno.dmi'
	button_icon_state = "alien_sneak"
	background_icon_state = "bg_alien"
	var/small = FALSE
	var/image/small_icon
	var/scale

/datum/action/sizecode_smallsprite/Trigger(trigger_flags)
	. = ..()
	if(!owner || has_everyone_appearance() || !iscarbon(owner))
		return

	small = !small
	var/mob/living/carbon/human/human_holder = owner
	if(small)
		var/body_size = human_holder.dna.features["body_size"]
		scale = 1 / body_size
		var/center_offset = round((SPRITE_SIZE * (scale - 1)) / body_size)

		small_icon = image(icon = owner.icon, icon_state = owner.icon_state, loc = owner, layer = owner.layer, pixel_x = 0, pixel_y = center_offset)
		src.update_small_icon()
		small_icon.override = TRUE
		owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic, "smallsprite_sizecode", small_icon)
		RegisterSignal(human_holder, COMSIG_CARBON_APPLY_OVERLAY, PROC_REF(update_small_icon))
	else
		owner.remove_alt_appearance("smallsprite_sizecode")
		UnregisterSignal(human_holder, COMSIG_CARBON_APPLY_OVERLAY)
	return TRUE

/datum/action/sizecode_smallsprite/proc/update_small_icon()
	if(small_icon)
		small_icon.icon = owner.icon
		small_icon.icon_state = owner.icon_state
		small_icon.overlays = owner.overlays
		small_icon.transform = matrix(owner.transform) * matrix(scale, scale, MATRIX_SCALE)

/*  Returns true if owner has alt appearance with subtype /everyone.
	Useful when potted plants used */
/datum/action/sizecode_smallsprite/proc/has_everyone_appearance()
	for(var/apperance as anything in owner.alternate_appearances)
		if(istype(owner.alternate_appearances[apperance], /datum/atom_hud/alternate_appearance/basic/everyone))
			return TRUE
	return FALSE

/datum/action/sizecode_smallsprite/proc/update_transform()
	small_icon.transform = matrix(owner.transform) * matrix(scale, scale, MATRIX_SCALE)

#undef SPRITE_SIZE
