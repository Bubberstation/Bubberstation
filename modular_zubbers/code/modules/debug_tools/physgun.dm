#define TRAIT_PHYSGUN_PAUSE "physgun_pause"
#define PHYSGUN_EFFECTS "physgun_effects"
/obj/item/physic_manipulation_tool
	name = "physic gun"
	desc = "A tool for manipulating physics of objects."
	icon = 'modular_zubbers/icons/obj/equipment/architector_items.dmi'
	icon_state = "physgun_grayscale"
	inhand_icon_state = "physgun_grayscale"
	worn_icon_state = "physgun_grayscale"
	belt_icon_state = "physgun_grayscale"
	worn_icon = 'modular_zubbers/icons/mob/inhands/architector_items_belt.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/architector_items_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/architector_items_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	demolition_mod = 0.5
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	throw_speed = 1
	throw_range = 1
	drop_sound = 'sound/items/handling/tools/screwdriver_drop.ogg'
	pickup_sound = 'modular_zubbers/sound/phystools/physgun_pickup.ogg'

	/// The dragged object
	var/atom/movable/handled_atom
	/// The creature that is using the physgun
	var/mob/living/physgun_user
	/// Datum of the beam between the user and the dragged object
	var/datum/beam/physgun_beam
	/// Color of the physgun
	var/effects_color = COLOR_CARP_BLUE
	/// The effect that is tracking the cursor
	var/atom/movable/screen/fullscreen/cursor_catcher/physgun_catcher

	/// If the physgun is empowered
	var/force_grab = FALSE
	/// Whether the physgun use advanced settings
	var/advanced = FALSE

	var/use_cooldown = 3 SECONDS
	COOLDOWN_DECLARE(grab_cooldown)
	var/datum/looping_sound/gravgen/kinesis/phys_gun/loop_sound

/obj/item/physic_manipulation_tool/Initialize(mapload)
	. = ..()
	loop_sound = new(src)

/obj/item/physic_manipulation_tool/Destroy(force)
	. = ..()
	if(handled_atom)
		release_atom()
	qdel(loop_sound)

/**
 * The control of the dragging.
 */
/obj/item/physic_manipulation_tool/ranged_interact_with_atom(atom/movable/target, mob/living/user, list/modifiers)
	. = ..()
	if(istype(target))
		if(!can_catch(target, user))
			playsound(user, 'modular_zubbers/sound/phystools/physgun_cant_grab.ogg', 100, TRUE)
			return
		if(!COOLDOWN_FINISHED(src, grab_cooldown) && !handled_atom)
			user.balloon_alert(user, "On cooldown!")
			return
		if(!range_check(target, user) && !handled_atom)
			user.balloon_alert(user, "Too far!")
			return
		catch_atom(target, user)
		COOLDOWN_START(src, grab_cooldown, use_cooldown)
		return


/obj/item/physic_manipulation_tool/dropped(mob/user, silent)
	. = ..()
	if(handled_atom)
		release_atom()

/obj/item/physic_manipulation_tool/click_alt(mob/user)
	. = ..()
	var/choised_color = input(usr, "Pick new effect color", "Physgun color") as color|null
	effects_color = choised_color
	color = choised_color
	update_appearance()

/obj/item/physic_manipulation_tool/examine(mob/user)
	. = ..()
	. += span_notice("Express manual:")
	. += span_notice("Use ALT + LMB on the device to pick color.")
	. += span_notice("Use LMB on the object to drag the object.")
	. += span_green("Use RMB while dragging to freeze the object.")
	. += span_red("Use LMB while dragging to release the object.")
	. += span_notice("Use CTRL + LMB while dragging to throw the object.")
	. += span_notice("Use ALT + LMB while dragging to rotate object.")

/**
 * The movement of the dragged object.
 */
/obj/item/physic_manipulation_tool/process(seconds_per_tick)
	if(!physgun_user)
		release_atom()
		return
	if(!range_check(handled_atom, physgun_user))
		release_atom()
		return
	if(physgun_catcher.mouse_params)
		physgun_catcher.calculate_params()
	if(!physgun_catcher.given_turf)
		return
	physgun_user.setDir(get_dir(physgun_user, handled_atom))
	if(handled_atom.loc == physgun_catcher.given_turf)
		if(handled_atom.pixel_x == physgun_catcher.given_x - world.icon_size/2 && handled_atom.pixel_y == physgun_catcher.given_y - world.icon_size/2)
			return
		animate(handled_atom, 0.2 SECONDS, pixel_x = handled_atom.base_pixel_x + physgun_catcher.given_x - world.icon_size/2, pixel_y = handled_atom.base_pixel_y + physgun_catcher.given_y - world.icon_size/2)
		physgun_beam.redrawing()
		return
	animate(handled_atom, 0.2 SECONDS, pixel_x = handled_atom.base_pixel_x + physgun_catcher.given_x - world.icon_size/2, pixel_y = handled_atom.base_pixel_y + physgun_catcher.given_y - world.icon_size/2)
	physgun_beam.redrawing()
	var/turf/turf_to_move = get_step_towards(handled_atom, physgun_catcher.given_turf)
	handled_atom.Move(turf_to_move, get_dir(handled_atom, turf_to_move), 8)
	var/pixel_x_change = 0
	var/pixel_y_change = 0
	var/direction = get_dir(handled_atom, turf_to_move)
	if(direction & NORTH)
		pixel_y_change = world.icon_size/2
	else if(direction & SOUTH)
		pixel_y_change = -world.icon_size/2
	if(direction & EAST)
		pixel_x_change = world.icon_size/2
	else if(direction & WEST)
		pixel_x_change = -world.icon_size/2
	animate(handled_atom, 0.2 SECONDS, pixel_x = handled_atom.base_pixel_x + pixel_x_change, pixel_y = handled_atom.base_pixel_y + pixel_y_change)

/obj/item/physic_manipulation_tool/proc/can_catch(atom/target, mob/user)
	if(target == user)
		return FALSE
	if(!ismovable(target))
		return FALSE
	var/atom/movable/movable_target = target
	if(iseffect(movable_target))
		return FALSE
	if(movable_target.anchored && !HAS_TRAIT(movable_target, TRAIT_PHYSGUN_PAUSE))
		if(!advanced)
			return FALSE
		movable_target.set_anchored(FALSE)
	if(ismob(movable_target))
		if(!isliving(movable_target))
			return FALSE
		var/mob/living/living_target = movable_target
		if(living_target.buckled)
			return FALSE
		if(living_target.client && !advanced)
			return FALSE
	return TRUE

/obj/item/physic_manipulation_tool/proc/range_check(atom/target, mob/user)
	if(!isturf(user.loc))
		return FALSE
	if(!can_see(user, target, 4))
		return FALSE
	return TRUE

/**
 * Signal controller.
 */

/obj/item/physic_manipulation_tool/proc/on_clicked(atom/source, atom/clicked_on, modifiers)
	SIGNAL_HANDLER
	if(!handled_atom || !physgun_user)
		stack_trace("Physgun tried to run its click signal with no linked atoms or users.")
		return
	. = COMSIG_MOB_CANCEL_CLICKON
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(!advanced)
			physgun_user.balloon_alert(physgun_user, "Not enough power!")
			return
		pause_atom(handled_atom)
		return
	else if(LAZYACCESS(modifiers, CTRL_CLICK))
		repulse(handled_atom, physgun_user)
		return
	else if(LAZYACCESS(modifiers, ALT_CLICK))
		rotate_object(handled_atom)
		return
	release_atom()

/obj/item/physic_manipulation_tool/proc/on_living_resist(mob/living)
	SIGNAL_HANDLER
	if(force_grab)
		handled_atom.balloon_alert(handled_atom, "Can't escape!")
		return
	if(handled_atom)
		release_atom()

/**
 * Grabbing atom.
 */

/obj/item/physic_manipulation_tool/proc/catch_atom(atom/movable/target, mob/user)
	if(isliving(target))
		var/mob/living/L = target
		if(force_grab)
			L.SetParalyzed(INFINITY, TRUE)
		if(L.has_status_effect(/datum/status_effect/physgun_pause))
			L.remove_status_effect(/datum/status_effect/physgun_pause)
		target.add_traits(list(TRAIT_HANDS_BLOCKED), REF(src))
		RegisterSignal(target, COMSIG_LIVING_RESIST, PROC_REF(on_living_resist), TRUE)
	target.movement_type = FLYING
	target.add_filter("physgun", 3, list("type" = "outline", "color" = effects_color, "size" = 2))
	physgun_beam = user.Beam(target, "light_beam")
	physgun_beam.beam_color = effects_color
	physgun_catcher = user.overlay_fullscreen("physgun_effect", /atom/movable/screen/fullscreen/cursor_catcher, 0)
	physgun_catcher.assign_to_mob(user)
	handled_atom = target
	handled_atom.plane = handled_atom.plane + 1
	handled_atom.set_density(FALSE)
	physgun_user = user
	loop_sound.start()

	RegisterSignal(user, COMSIG_MOB_CLICKON, PROC_REF(on_clicked), TRUE)
	START_PROCESSING(SSfastprocess, src)

/**
 * Releasing atom.
 */

/obj/item/physic_manipulation_tool/proc/release_atom()
	if(isliving(handled_atom))
		var/mob/living/L = handled_atom
		if(force_grab)
			L.SetParalyzed(0)
		if(L.has_status_effect(/datum/status_effect/physgun_pause))
			L.remove_status_effect(/datum/status_effect/physgun_pause)
		handled_atom.remove_traits(list(TRAIT_HANDS_BLOCKED), REF(src))
		UnregisterSignal(handled_atom, COMSIG_LIVING_RESIST)
	if(HAS_TRAIT(handled_atom, TRAIT_PHYSGUN_PAUSE))
		REMOVE_TRAIT(handled_atom, TRAIT_PHYSGUN_PAUSE, PHYSGUN_EFFECTS)
	handled_atom.movement_type = initial(movement_type)
	STOP_PROCESSING(SSfastprocess, src)
	handled_atom.remove_filter("physgun")
	UnregisterSignal(physgun_catcher, COMSIG_CLICK)
	physgun_catcher = null
	physgun_user.clear_fullscreen("physgun_effect")
	handled_atom.pixel_x = initial(handled_atom.pixel_x)
	handled_atom.pixel_y = initial(handled_atom.pixel_y)
	handled_atom.anchored = initial(handled_atom.anchored)
	handled_atom.density = initial(handled_atom.density)
	handled_atom.plane = initial(handled_atom.plane)
	qdel(physgun_beam)
	physgun_user = null
	handled_atom = null
	loop_sound.stop()

/**
 * Rotating atom.
 */

/obj/item/physic_manipulation_tool/proc/rotate_object(atom/movable/target)
	target.setDir(turn(target.dir,-90))

/**
 * Freezing atom.
 * Freezes the atom in air, blocking any movement.
 */

/obj/item/physic_manipulation_tool/proc/pause_atom(atom/movable/target)
	if(isliving(handled_atom))
		var/mob/living/L = target
		if(force_grab)
			L.apply_status_effect(/datum/status_effect/physgun_pause/admin)
		else
			L.apply_status_effect(/datum/status_effect/physgun_pause)
		REMOVE_TRAIT(L, TRAIT_HANDS_BLOCKED, REF(src))
	ADD_TRAIT(handled_atom, TRAIT_PHYSGUN_PAUSE, PHYSGUN_EFFECTS)
	handled_atom.set_anchored(TRUE)
	STOP_PROCESSING(SSfastprocess, src)
	UnregisterSignal(physgun_catcher, list(COMSIG_CLICK, COMSIG_CLICK_ALT, COMSIG_CLICK_CTRL))
	physgun_catcher = null
	physgun_user.clear_fullscreen("physgun_effect")
	qdel(physgun_beam)
	physgun_user = null
	handled_atom = null
	loop_sound.stop()

/obj/item/physic_manipulation_tool/proc/repulse(atom/movable/target, mob/user)
	release_atom()
	var/turf/target_turf = get_turf_in_angle(get_angle(user, target), get_turf(user), 10)
	target.throw_at(target_turf, range = 9, speed = target.density ? 3 : 4, thrower = user, spin = isitem(target))
	playsound(user, 'modular_zubbers/sound/phystools/physgun_repulse.ogg', 100, TRUE)

/obj/item/physic_manipulation_tool/advanced
	advanced = TRUE
	use_cooldown = 1 SECONDS

/obj/item/physic_manipulation_tool/advanced/admin
	force_grab = TRUE

/datum/looping_sound/gravgen/kinesis/phys_gun
	mid_sounds = list('modular_zubbers/sound/phystools/physgun_hold_loop.ogg' = 1)

/datum/status_effect/physgun_pause
	id = "physgun_pause"
	var/force = FALSE

/datum/status_effect/physgun_pause/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_RESIST, PROC_REF(on_resist), TRUE)
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, REF(src))
	ADD_TRAIT(owner, TRAIT_HANDS_BLOCKED, REF(src))

/datum/status_effect/physgun_pause/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_RESIST)
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, REF(src))
	REMOVE_TRAIT(owner, TRAIT_HANDS_BLOCKED, REF(src))

/datum/status_effect/physgun_pause/proc/on_resist()
	SIGNAL_HANDLER

	if(force)
		owner.balloon_alert("Can't escape!")
		return

	if(!HAS_TRAIT(owner, TRAIT_PHYSGUN_PAUSE))
		return
	REMOVE_TRAIT(owner, TRAIT_PHYSGUN_PAUSE, PHYSGUN_EFFECTS)
	owner.pixel_x = initial(owner.pixel_x)
	owner.pixel_y = initial(owner.pixel_y)
	owner.anchored = initial(owner.anchored)
	owner.density = initial(owner.density)
	owner.movement_type = initial(owner.movement_type)
	owner.remove_status_effect(src)
	owner.remove_filter("physgun")
	owner.plane = initial(owner.plane)

/datum/status_effect/physgun_pause/admin
	id = "physgun_pause_admin"
	force = TRUE
