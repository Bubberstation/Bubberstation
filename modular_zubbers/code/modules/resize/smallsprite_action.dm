#define SPRITE_SIZE 32
#define LYING_WEST_PIXEL_X 8
#define LYING_EAST_PIXEL_X -8

/datum/action/oversized_visibility
	name = "Toggle Oversized Sprite"
	desc = "Others will always see you as oversized."
	button_icon = 'icons/mob/actions/actions_xeno.dmi'
	button_icon_state = "alien_sneak"
	background_icon_state = "bg_alien"
	var/small = FALSE
	var/image/small_icon
	var/scale
	var/y_offset_stored

/datum/action/oversized_visibility/Trigger(trigger_flags)
	. = ..()
	validate_owner()
	if(has_everyone_appearance())
		return

	small = !small
	var/mob/living/carbon/carbon_holder = owner
	if(small)
		if(!small_icon)
			update_scale()
			small_icon = image(icon = owner.icon, icon_state = owner.icon_state, loc = owner, layer = owner.layer, pixel_x = 0, pixel_y = y_offset_stored)
			small_icon.override = TRUE

		update_small_icon()
		update_scale()
		update_transform()
		owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic, "smallsprite_sizecode", small_icon)
		RegisterSignal(carbon_holder, COMSIG_CARBON_APPLY_OVERLAY, PROC_REF(update_small_icon))
		RegisterSignal(carbon_holder, COMSIG_LIVING_POST_UPDATE_TRANSFORM, PROC_REF(update_appearance))
	else
		owner.remove_alt_appearance("smallsprite_sizecode")
		UnregisterSignal(carbon_holder, COMSIG_CARBON_APPLY_OVERLAY)
		UnregisterSignal(carbon_holder, COMSIG_LIVING_POST_UPDATE_TRANSFORM)
	return TRUE

/datum/action/oversized_visibility/proc/update_small_icon()
	if(small_icon)
		small_icon.icon = owner.icon
		small_icon.icon_state = owner.icon_state
		small_icon.overlays = owner.overlays

/*  Returns true if owner has alt appearance with subtype /everyone.
	Useful when potted plants used */
/datum/action/oversized_visibility/proc/has_everyone_appearance()
	for(var/apperance as anything in owner.alternate_appearances)
		if(istype(owner.alternate_appearances[apperance], /datum/atom_hud/alternate_appearance/basic/everyone))
			return TRUE
	return FALSE

// Updates transform value. Useful when body size values changed, so it updates them by default
/datum/action/oversized_visibility/proc/update_transform(update_scale = TRUE)
	if(!small_icon)
		return
	if(update_scale)
		update_scale()
	small_icon.transform = matrix(owner.transform) * matrix(scale, scale, MATRIX_SCALE)

/*  Updating body size dependent values
	scale and y_offset_stored
	We assume that we checked for not null and carbon before calling it */
/datum/action/oversized_visibility/proc/update_scale()
	var/mob/living/carbon/carbon_holder = owner
	var/body_size = carbon_holder.dna.features["body_size"]
	scale = 1 / body_size
	var/y_offset_current = round((SPRITE_SIZE * (scale - 1)) / body_size)
	if(y_offset_stored != y_offset_current || !y_offset_stored)
		y_offset_stored = y_offset_current

/datum/action/oversized_visibility/proc/update_pixel_y()
	if(!small_icon)
		return
	var/total_offset = y_offset_stored
	var/mob/living/carbon/carbon_holder = owner
	if(carbon_holder.get_lying_angle() != 0)
		total_offset -= PIXEL_Y_OFFSET_LYING
	small_icon.pixel_y = total_offset

/datum/action/oversized_visibility/proc/update_pixel_x()
	var/mob/living/carbon/carbon_holder = owner
	var/mob_lying_angle = carbon_holder.get_lying_angle()
	if(mob_lying_angle != 0)
		if(mob_lying_angle == LYING_ANGLE_WEST)
			small_icon.pixel_x = LYING_WEST_PIXEL_X
			return
		if(mob_lying_angle == LYING_ANGLE_EAST)
			small_icon.pixel_x = LYING_EAST_PIXEL_X
			return
	small_icon.pixel_x = 0

/datum/action/oversized_visibility/proc/validate_owner()
	if(!owner || !iscarbon(owner))
		CRASH("oversized_visibility: Invalid carbon holder! \
			Got: [owner] ([owner?.type]) \
			Expected: /mob/living/carbon")

/datum/action/oversized_visibility/proc/update_appearance()
	SIGNAL_HANDLER
	if(small_icon)
		update_transform()
		update_pixel_y()
		update_pixel_x()

/datum/action/oversized_visibility/Remove(mob/remove_from)
	. = ..()
	var/mob/living/carbon/carbon_holder = remove_from
	UnregisterSignal(carbon_holder, COMSIG_CARBON_APPLY_OVERLAY)
	UnregisterSignal(carbon_holder, COMSIG_LIVING_POST_UPDATE_TRANSFORM)
	carbon_holder.remove_alt_appearance("smallsprite_sizecode")
	small_icon = null

/* All the emote code taken from
code\modules\mob\emote.dm */
/datum/emote/jump/jump_animation(mob/user)
	. = ..()
	for(var/datum/action/sizecode_smallsprite/A in user.actions)
		if(!A.small)
			return
		var/original_transform = A.small_icon.transform
		animate(A.small_icon, transform = A.small_icon.transform.Translate(0, 4), time = 0.1 SECONDS, flags = ANIMATION_PARALLEL)
		animate(transform = original_transform, time = 0.1 SECONDS)

/datum/emote/flip/run_emote(mob/user, params , type_override, intentional)
	. = ..()
	for(var/datum/action/sizecode_smallsprite/A in user.actions)
		if(!A.small)
			return
		A.small_icon.do_spin_animation(FLIP_EMOTE_DURATION, 1)

// code\__HELPERS\visual_effects.dm
/image/proc/SpinAnimation(speed = 1 SECONDS, loops = -1, clockwise = TRUE, segments = 3, parallel = TRUE)
	if(!segments)
		return
	var/segment = 360/segments
	if(!clockwise)
		segment = -segment
	//SEND_SIGNAL(src, COMSIG_ATOM_SPIN_ANIMATION, speed, loops, segments, segment)
	do_spin_animation(speed, loops, segments, segment, parallel)

// code\__HELPERS\visual_effects.dm
/image/proc/do_spin_animation(speed = 1 SECONDS, loops = -1, segments = 3, angle = 120, parallel = TRUE)
    var/list/matrices = list()
    for(var/i in 1 to segments-1)
        var/matrix/segment_matrix = matrix(src.transform)
        segment_matrix.Turn(angle*i)
        matrices += segment_matrix
    var/matrix/last = matrix(src.transform)
    matrices += last

    speed /= segments

    animate(src, transform = matrices[1], time = speed, loop = loops, flags = parallel ? ANIMATION_PARALLEL : 0)
    for(var/i in 2 to segments)
        animate(transform = matrices[i], time = speed)

#undef SPRITE_SIZE
#undef LYING_WEST_PIXEL_X
#undef LYING_EAST_PIXEL_X
