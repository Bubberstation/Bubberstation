//S.P.L.U.R.T-tg/modular_zzplurt/code/modules/resize/smallsprite_action.dm
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
	var/y_offset_stored

/datum/action/sizecode_smallsprite/Trigger(trigger_flags)
	. = ..()
	validate_owner()
	if(has_everyone_appearance())
		return

	small = !small
	var/mob/living/carbon/carbon_holder = owner
	if(small)
		if(!small_icon)
			update_body_size(FALSE)
			small_icon = image(icon = owner.icon, icon_state = owner.icon_state, loc = owner, layer = owner.layer, pixel_x = 0, pixel_y = y_offset_stored)
			small_icon.override = TRUE

		update_small_icon()
		owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic, "smallsprite_sizecode", small_icon)
		RegisterSignal(carbon_holder, COMSIG_CARBON_APPLY_OVERLAY, PROC_REF(update_small_icon))
	else
		owner.remove_alt_appearance("smallsprite_sizecode")
		UnregisterSignal(carbon_holder, COMSIG_CARBON_APPLY_OVERLAY)
	return TRUE

/datum/action/sizecode_smallsprite/proc/update_small_icon()
	if(small_icon)
		small_icon.icon = owner.icon
		small_icon.icon_state = owner.icon_state
		small_icon.overlays = owner.overlays
		update_transform()

/*  Returns true if owner has alt appearance with subtype /everyone.
	Useful when potted plants used */
/datum/action/sizecode_smallsprite/proc/has_everyone_appearance()
	for(var/apperance as anything in owner.alternate_appearances)
		if(istype(owner.alternate_appearances[apperance], /datum/atom_hud/alternate_appearance/basic/everyone))
			return TRUE
	return FALSE

/datum/action/sizecode_smallsprite/proc/update_transform(var/update_size = TRUE)
	if(!small_icon)
		return
	if(update_size)
		update_body_size()
	small_icon.transform = matrix(owner.transform) * matrix(scale, scale, MATRIX_SCALE)

/* Updating body size related values
	We dont assume that owner's body size cant change over time
	We assume that we checked for not null and carbon before calling it */
/datum/action/sizecode_smallsprite/proc/update_body_size()
	var/mob/living/carbon/carbon_holder = owner
	var/body_size = carbon_holder.dna.features["body_size"]
	scale = 1 / body_size
	var/y_offset_current = round((SPRITE_SIZE * (scale - 1)) / body_size)
	if(y_offset_stored != y_offset_current || !y_offset_stored)
		y_offset_stored = y_offset_current

/datum/action/sizecode_smallsprite/proc/validate_owner()
	if(!owner || !iscarbon(owner))
		CRASH("sizecode_smallsprite: Invalid carbon holder! \
			Got: [owner] ([owner?.type]) \
			Expected: /mob/living/carbon")

#undef SPRITE_SIZE
