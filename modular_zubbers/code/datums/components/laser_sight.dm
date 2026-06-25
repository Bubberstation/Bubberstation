/**
 * Laser Sight Component
 *
 * Attaches to any item. While held in the active hand and toggled on,
 * draws a coloured beam from the holder toward their cursor,
 * visible to all nearby players as a world-side tracer.
 */

/// Freefire accuracy improvement for the standard version (degrees of spread removed)
#define LASER_SIGHT_ACCURACY_STANDARD 5
/// Freefire accuracy improvement for the syndicate version
#define LASER_SIGHT_ACCURACY_SYNDIE 12

/// Ticks each world-side tracer lives between process cycles.
#define LASER_SIGHT_TRACER_LIFE 3

#define LASER_SIGHT_RAINBOW_MAGIC "fabulousputin"

/datum/component/laser_sight
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/laser_color = "#CB0000"
	var/rainbow_mode = FALSE
	var/rainbow_hue = 0
	var/laser_active = TRUE
	/// How many degrees of bonus spread to cancel on fire.
	var/accuracy_bonus = LASER_SIGHT_ACCURACY_STANDARD
	var/is_syndicate = FALSE
	var/beam_was_visible = FALSE

	/// Fullscreen cursor tracker object attached to the holder's client.
	var/atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher/cursor_tracker
	/// The action datum currently granted to the holder.
	var/datum/action/item_action/toggle_laser_sight/laser_action
	/// Weakref to the mob currently holding this item.
	var/datum/weakref/holder_ref
	var/list/obj/effect/projectile/tracer/live_tracers


/datum/component/laser_sight/Initialize(start_color = "#CB0000", start_is_syndicate = FALSE)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	if(istext(start_color))
		laser_color = start_color
	if(start_is_syndicate)
		is_syndicate = TRUE
		accuracy_bonus = LASER_SIGHT_ACCURACY_SYNDIE
	live_tracers = list()


/datum/component/laser_sight/Destroy(force)
	stop_laser()
	live_tracers = null
	return ..()


/datum/component/laser_sight/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(on_item_interaction))
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_THROW, PROC_REF(on_pre_throw))
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_IMPACT, PROC_REF(on_pre_impact))

	// Parent may already be in hand when the component is added (e.g. attaching to a held item).
	var/obj/item/item_parent = parent
	var/mob/holder = item_parent.loc
	if(ismob(holder))
		var/slot = holder.get_slot_by_item(item_parent)
		if(slot & ITEM_SLOT_HANDS)
			start_laser(holder)


/datum/component/laser_sight/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_ITEM_EQUIPPED,
		COMSIG_ITEM_DROPPED,
		COMSIG_ATOM_EXAMINE,
		COMSIG_ATOM_ITEM_INTERACTION,
		COMSIG_MOVABLE_PRE_THROW,
		COMSIG_MOVABLE_PRE_IMPACT,
	))


/datum/component/laser_sight/proc/on_equipped(obj/item/source, mob/user, slot)
	SIGNAL_HANDLER

	if(!(slot & ITEM_SLOT_HANDS))
		stop_laser()
		return
	start_laser(user)


/datum/component/laser_sight/proc/on_dropped(obj/item/source, mob/user)
	SIGNAL_HANDLER

	stop_laser()


/datum/component/laser_sight/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/obj/item/parent_item = parent
	var/grade = is_syndicate ? "tactical " : ""
	if(rainbow_mode)
		examine_list += span_notice("\The [parent_item] has a [grade]laser sight attached. Its beam is rapidly changing colors; you can hear music playing faintly from inside it.")
	else
		examine_list += span_notice("\The [parent_item] has a [grade]laser sight attached.")
	examine_list += span_notice("Use a <b>screwdriver</b> to detach it.")


/// Multitool opens the colour picker; screwdriver detaches.
/datum/component/laser_sight/proc/on_item_interaction(datum/source, mob/living/user, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER

	if(istype(tool, /obj/item/screwdriver))
		detach_sight(user)
		return NONE


// ---- Laser lifecycle ----

/datum/component/laser_sight/proc/start_laser(mob/living/user)
	if(!user?.client)
		return
	if(cursor_tracker)
		stop_laser()

	holder_ref = WEAKREF(user)
	var/obj/item/item_parent = parent
	laser_action = item_parent.add_item_action(/datum/action/item_action/toggle_laser_sight)
	cursor_tracker = user.overlay_fullscreen("laser_sight", /atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher, 0)
	cursor_tracker.assign_to_mob(user)
	RegisterSignal(user, COMSIG_MOB_FIRED_GUN, PROC_REF(on_fired_gun))
	RegisterSignal(user.client, COMSIG_CLIENT_MOUSEDRAG, PROC_REF(on_mouse_drag))
	START_PROCESSING(SSfastprocess, src)


/datum/component/laser_sight/proc/stop_laser()
	var/mob/user = holder_ref?.resolve()
	if(user)
		UnregisterSignal(user, COMSIG_MOB_FIRED_GUN)
		if(cursor_tracker)
			user.clear_fullscreen("laser_sight")
		if(user.client)
			UnregisterSignal(user.client, COMSIG_CLIENT_MOUSEDRAG)
		if(beam_was_visible)
			playsound(user, 'sound/items/night_vision_on.ogg', 30, TRUE, -3, frequency = -1)

	beam_was_visible = FALSE
	cursor_tracker = null
	holder_ref = null

	STOP_PROCESSING(SSfastprocess, src)
	clear_live_tracers()

	if(laser_action)
		var/obj/item/item_parent = parent
		item_parent.remove_item_action(laser_action)
		laser_action = null


/datum/component/laser_sight/proc/clear_live_tracers()
	if(!length(live_tracers))
		return
	for(var/obj/effect/projectile/tracer/t as anything in live_tracers)
		qdel(t)
	live_tracers.Cut()


// ---- Processing ----

/datum/component/laser_sight/process(seconds_per_tick)
	var/mob/user = holder_ref?.resolve()
	if(!user?.client)
		stop_laser()
		return

	var/gun_is_active = (user.get_active_held_item() == parent)
	// Ghost the cursor tracker when it should not be intercepting mouse events.
	if(cursor_tracker)
		cursor_tracker.mouse_opacity = (laser_active && gun_is_active) ? MOUSE_OPACITY_ICON : MOUSE_OPACITY_TRANSPARENT
	if(!laser_active || !gun_is_active)
		clear_live_tracers()
		if(beam_was_visible)
			beam_was_visible = FALSE
			playsound(user, 'sound/items/night_vision_on.ogg', 30, TRUE, -3, frequency = -1)
		return

	if(rainbow_mode)
		rainbow_hue = (rainbow_hue + 10) % 360
		laser_color = hue_to_rgb(rainbow_hue)
		laser_action?.build_all_button_icons(force = TRUE)

	cursor_tracker?.calculate_params()
	var/turf/origin = get_turf(user)
	var/turf/target = cursor_tracker?.given_turf
	// Transient condition: beam has no valid target this tick.
	// Silently drop the beam rather than playing the power-off sound.
	if(!origin || !target || origin == target || target.z != origin.z)
		clear_live_tracers()
		return

	if(!beam_was_visible)
		beam_was_visible = TRUE
		playsound(user, 'sound/items/night_vision_on.ogg', 30, TRUE, -3)

	clear_live_tracers()
	draw_beam(origin, target)


/**
 * Places a single scaled+rotated tracer spanning from origin to target.
 * Visible to all players in range as a world object.
 */
/datum/component/laser_sight/proc/draw_beam(turf/origin, turf/target)
	// Clip beam at the first dense obstruction between origin and target.
	var/turf/clipped = target
	var/list/line = get_line(origin, target)
	for(var/turf/T as anything in line)
		if(T == origin)
			continue
		if(T.density)
			clipped = T
			break
		var/blocked = FALSE
		for(var/obj/O in T)
			if(O.density && !istype(O, /obj/item))
				blocked = TRUE
				break
		if(!blocked)
			for(var/mob/M in T)
				if(M.density)
					blocked = TRUE
					break
		if(blocked)
			clipped = T
			break
	target = clipped

	var/origin_px = 0
	var/origin_py = 0
	var/target_px = cursor_tracker.given_x
	var/target_py = cursor_tracker.given_y

	var/DX = (ICON_SIZE_X * target.x + target_px) - (ICON_SIZE_X * origin.x + origin_px)
	var/DY = (ICON_SIZE_Y * target.y + target_py) - (ICON_SIZE_Y * origin.y + origin_py)

	if(!DX && !DY)
		return

	var/angle = get_angle_raw(
		origin.x, origin.y, origin_px, origin_py,
		target.x, target.y, target_px, target_py,
	)
	var/pixel_length = sqrt(DX ** 2 + DY ** 2)
	var/scaling = pixel_length / ICON_SIZE_X

	// Midpoint in world-pixel space, then decomposed into tile + sub-tile offset
	var/mid_world_x = (ICON_SIZE_X * origin.x + origin_px + ICON_SIZE_X * target.x + target_px) * 0.5
	var/mid_world_y = (ICON_SIZE_Y * origin.y + origin_py + ICON_SIZE_Y * target.y + target_py) * 0.5
	var/mid_tile_x = round(mid_world_x / ICON_SIZE_X)
	var/mid_tile_y = round(mid_world_y / ICON_SIZE_Y)

	var/turf/mid_turf = locate(mid_tile_x, mid_tile_y, origin.z)
	if(!mid_turf)
		return

	var/mid_px = round(mid_world_x - ICON_SIZE_X * mid_tile_x)
	var/mid_py = round(mid_world_y - ICON_SIZE_Y * mid_tile_y)

	var/matrix/M = matrix()
	M.Scale(1, scaling)
	M.Turn(angle)

	var/obj/effect/projectile/tracer/laser_sight_beam/beam = new(mid_turf)
	beam.color = laser_color
	beam.pixel_x = mid_px
	beam.pixel_y = mid_py
	beam.transform = M
	beam.plane = ABOVE_LIGHTING_PLANE
	QDEL_IN(beam, LASER_SIGHT_TRACER_LIFE)
	live_tracers += beam


// ---- Accuracy ----

/datum/component/laser_sight/proc/on_fired_gun(mob/user, obj/item/gun/gun_fired, target, params, zone_override, list/bonus_spread_values)
	SIGNAL_HANDLER

	if(!laser_active || user.get_active_held_item() != parent)
		return
	bonus_spread_values[MIN_BONUS_SPREAD_INDEX] -= accuracy_bonus
	bonus_spread_values[MAX_BONUS_SPREAD_INDEX] -= accuracy_bonus


// ---- Colour picker ----

/datum/component/laser_sight/proc/change_color(mob/user)
	if(!user.can_perform_action(parent, NEED_DEXTERITY))
		return

	var/mode = tgui_alert(user, "Pick a beam colour method.", "Laser Sight", list("Colour Wheel", "Manual Input", "Cancel"))
	if(isnull(mode) || mode == "Cancel" || QDELETED(src) || QDELETED(parent))
		return
	if(mode == "Colour Wheel")
		var/picked = tgui_color_picker(user, "Choose beam colour.", "Laser Sight Colour", laser_color)
		if(isnull(picked) || QDELETED(src) || QDELETED(parent))
			return
		rainbow_mode = FALSE
		laser_color = picked
		laser_action?.build_all_button_icons(force = TRUE)
		user.balloon_alert(user, "colour set to [picked]")
		return

	var/msg = "Enter a hex colour (e.g. #ff0000) for the laser beam."
	if(is_syndicate)
		msg += " Psst: there may be hidden configuration options."
	var/input = tgui_input_text(user, msg, "Laser Sight Colour", default = laser_color, max_length = 16)
	if(isnull(input) || QDELETED(src) || QDELETED(parent))
		return
	if(LOWER_TEXT(input) == LASER_SIGHT_RAINBOW_MAGIC)
		rainbow_mode = !rainbow_mode
		if(rainbow_mode)
			to_chat(user, span_warning("RNBW_ENGAGE"))
		laser_action?.build_all_button_icons(force = TRUE)
		return

	rainbow_mode = FALSE
	var/hex = sanitize_hexcolor(input, desired_format = 6, include_crunch = TRUE)
	if(!hex)
		user.balloon_alert(user, "invalid colour")
		return
	laser_color = hex
	laser_action?.build_all_button_icons(force = TRUE)
	user.balloon_alert(user, "colour set to [hex]")


// ---- Detach ----

/datum/component/laser_sight/proc/detach_sight(mob/user)
	if(!user.can_perform_action(parent, NEED_DEXTERITY))
		return

	var/saved = laser_color
	var/saved_rainbow = rainbow_mode
	var/saved_syndie = is_syndicate

	user.balloon_alert(user, "detached laser sight")
	stop_laser()

	var/obj/item/laser_sight/dropped = new(get_turf(parent))
	dropped.saved_color = saved
	dropped.saved_rainbow = saved_rainbow
	dropped.saved_is_syndicate = saved_syndie

	qdel(src)


// ---- Throw mechanics: laser guidance on non-firearms ----

/// Range bonus multiplier for laser-guided non-firearm throws.
#define LASER_THROW_RANGE_MULT 2

/datum/component/laser_sight/proc/on_pre_throw(atom/movable/source, list/throw_args)
	SIGNAL_HANDLER
	if(isgun(parent))
		return
	var/atom/throw_target = throw_args[1]
	// Laser guidance special case: direct deposit into disposal bins, bypassing throw physics entirely.
	// This avoids the "bounces off rim" message since the throw never resolves normally.
	if(istype(throw_target, /obj/machinery/disposal))
		INVOKE_ASYNC(src, PROC_REF(laser_deposit), throw_args[4], throw_target)
		return COMPONENT_CANCEL_THROW
	// Non-bin throw: boost range.
	throw_args[2] = round(throw_args[2] * LASER_THROW_RANGE_MULT)


/// Called when a laser-guided non-firearm is thrown directly at a disposal bin.
/// Cancels the normal throw and deposits the item cleanly.
/datum/component/laser_sight/proc/laser_deposit(mob/thrower, obj/machinery/disposal/bin)
	var/obj/item/item_parent = parent
	item_parent.visible_message(span_notice("The laser sight accurately guides [item_parent] into [bin], wow!"))
	item_parent.forceMove(bin)


/// Fires before hitby() runs on the impact target.
/// If the target is a disposal bin, skip normal impact (suppressing the bounce message)
/// and directly deposit the item.
/datum/component/laser_sight/proc/on_pre_impact(atom/movable/source, atom/hit_atom, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER
	if(!istype(hit_atom, /obj/machinery/disposal))
		return
	INVOKE_ASYNC(src, PROC_REF(laser_deposit), throwingdatum?.get_thrower(), hit_atom)
	return COMPONENT_MOVABLE_IMPACT_NEVERMIND


/datum/component/laser_sight/proc/on_mouse_drag(client/source, atom/src_object, atom/over_object, turf/src_location, turf/over_location, src_control, over_control, params)
	SIGNAL_HANDLER
	if(!cursor_tracker)
		return
	var/datum/position/pos = mouse_absolute_datum_map_position_from_client(source)
	if(pos?.valid())
		var/turf/from_pos = locate(pos.x, pos.y, pos.z)
		if(from_pos)
			cursor_tracker.given_turf = from_pos
			cursor_tracker.given_x = pos.pixel_x
			cursor_tracker.given_y = pos.pixel_y
			return
	if(over_location)
		cursor_tracker.given_turf = over_location


// ---- HoxHud-style hue cycling ----

/// Converts a hue (0-359) at full saturation and value to an RGB hex string.
/datum/component/laser_sight/proc/hue_to_rgb(hue)
	var/sector = floor(hue / 60)
	var/f = (hue % 60) / 60
	var/rise = round(f * 255)
	var/fall = round((1 - f) * 255)
	switch(sector)
		if(0) return rgb(255, rise, 0)
		if(1) return rgb(fall, 255, 0)
		if(2) return rgb(0, 255, rise)
		if(3) return rgb(0, fall, 255)
		if(4) return rgb(rise, 0, 255)
		if(5) return rgb(255, 0, fall)
	return rgb(255, 0, 0)


/obj/effect/projectile/tracer/laser_sight_beam
	name = "laser sight"
	icon = 'modular_zubbers/icons/obj/weapons/guns/laser_sight_beam.dmi'
	icon_state = "beam"
	blend_mode = BLEND_ADD
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT


// ---- Cursor catcher subtype ----

/atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher
	show_when_dead = TRUE

/atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher/Click(location, control, params)
	var/list/modifiers = params2list(params)
	var/obj/item/held = owner?.get_active_held_item()

	// Ctrl-click: find the best target at the click location so grab/pull works.
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		var/atom/target = null
		for(var/mob/M in location)
			target = M
			break
		if(!target)
			for(var/obj/O in location)
				target = O
				break
		if(owner)
			owner.ClickOn(target || location, params)
		return

	// Right-click or any other modifier: normal click chain handles scope,
	// shift-examine, alt-click, etc.
	if(LAZYACCESS(modifiers, RIGHT_CLICK) || LAZYACCESS(modifiers, SHIFT_CLICK) || LAZYACCESS(modifiers, ALT_CLICK) || LAZYACCESS(modifiers, MIDDLE_CLICK) || !istype(held, /obj/item/gun))
		..()
		return

	// Plain left-click with gun in active hand: fire at the actual click location.
	if(location)
		INVOKE_ASYNC(held, TYPE_PROC_REF(/obj/item/gun, fire_gun), location, owner)

/// Only our player's client has this screen object, so no usr check needed.
/atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher/MouseMove(location, control, params)
	mouse_params = params
	calculate_params()


// ---- Toggle action ----

/datum/action/item_action/toggle_laser_sight
	name = "Toggle Laser Sight"
	desc = "Enable or disable the attached laser sight beam."
	button_icon = 'modular_zubbers/icons/obj/weapons/guns/laser_sight.dmi'
	button_icon_state = "laser_sight"
	check_flags = AB_CHECK_CONSCIOUS
	/// Tracked beam overlay on the button so we can cut it before re-applying.
	var/mutable_appearance/button_beam_overlay


/datum/action/item_action/toggle_laser_sight/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/component/laser_sight/comp = target.GetComponent(/datum/component/laser_sight)
	if(!comp)
		return
	comp.laser_active = !comp.laser_active
	var/state_msg = comp.laser_active ? "laser on" : "laser off"
	owner.balloon_alert(owner, state_msg)


/// Applies the coloured beam overlay on top of the housing icon.
/// Called by build_all_button_icons; also called manually when laser_color changes.
/datum/action/item_action/toggle_laser_sight/apply_button_overlay(atom/movable/screen/movable/action_button/current_button, force)
	. = ..()
	// Cut the previous beam overlay so colour changes replace rather than stack.
	if(button_beam_overlay)
		current_button.cut_overlay(button_beam_overlay)
		button_beam_overlay = null
	var/datum/component/laser_sight/comp = target?.GetComponent(/datum/component/laser_sight)
	if(!comp)
		return
	var/beam_color = comp.laser_color
	button_beam_overlay = mutable_appearance('modular_zubbers/icons/obj/weapons/guns/laser_sight.dmi', "laser_sight_beam")
	button_beam_overlay.color = beam_color
	button_beam_overlay.plane = FLOAT_PLANE
	button_beam_overlay.layer = FLOAT_LAYER
	current_button.add_overlay(button_beam_overlay)


#undef LASER_SIGHT_ACCURACY_STANDARD
#undef LASER_THROW_RANGE_MULT
#undef LASER_SIGHT_ACCURACY_SYNDIE
#undef LASER_SIGHT_TRACER_LIFE
#undef LASER_SIGHT_RAINBOW_MAGIC
