#define LASER_SIGHT_ACCURACY_STANDARD 5
#define LASER_SIGHT_ACCURACY_SYNDIE 12
#define LASER_SIGHT_RAINBOW_MAGIC "fabulousputin"
/// Ticks each tracer object persists before being deleted.
#define LASER_SIGHT_TRACER_LIFE 3
/// Throw range multiplier for laser-guided non-firearms.
#define LASER_THROW_RANGE_MULT 2
/// Tiny fire_delay reduction (deciseconds) on a gun parent to offset the laser's redirect overhead.
/// Not a real buff: it just pays back the ~1 tick the async fire path costs.
#define LASER_SIGHT_FIRE_DELAY_OFFSET 1
/// Per-tick easing fraction for the drawn beam endpoint (1 = no smoothing, lower = smoother/slower).
/// Just takes the visual edge off cursor jumps; aim and fire still use the exact tracked turf.
#define LASER_SIGHT_BEAM_SMOOTHING 0.6

/// Attaches to any item. While held in the active hand with the laser toggled on, draws a coloured
/// beam toward the holder's cursor each process tick and shows a matching cursor reticle. Tracking
/// and firing follow the scope component's proven pattern: a HUD_PLANE cursor catcher tracks the
/// cursor on hover, and gun fire is redirected to the tracked turf via COMSIG_GUN_TRY_FIRE.
/datum/component/laser_sight
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/laser_color = "#CB0000"
	var/rainbow_mode = FALSE
	var/rainbow_hue = 0
	var/laser_active = TRUE
	var/accuracy_bonus = LASER_SIGHT_ACCURACY_STANDARD
	var/is_syndicate = FALSE
	var/beam_was_visible = FALSE
	/// Colour the cursor reticle was last baked at, so we only regenerate on change.
	var/reticle_color
	/// TRUE while the holder holds left-click on a full-auto gun.
	var/holding_fire = FALSE
	/// world.time of the next permitted self-driven autofire shot.
	var/next_autofire_at = 0
	/// TRUE while any left-click is held. While held we stop recomputing the tracked turf from the
	/// catcher's (now stale) MouseMove params and let the drag handler drive it instead.
	var/mouse_held = FALSE
	/// The movable picked up under the cursor at mouse-down, for laser drag relocation.
	var/atom/movable/drag_source
	/// TRUE once a held drag that began on a movable has moved; relocates on release and suppresses
	/// the click shot that the engine fires when a catcher drag collapses into a click.
	var/dragging_object = FALSE
	/// The gun parent's fire_delay before we applied the offset, so we can restore it on detach.
	/// Null means we never touched it (non-gun parent).
	var/original_fire_delay = null
	/// Last drawn beam endpoint in world pixels, for easing the next frame toward the new cursor.
	var/last_beam_wx = 0
	var/last_beam_wy = 0
	var/beam_smoothing_primed = FALSE

	var/atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher/cursor_tracker
	var/datum/action/item_action/toggle_laser_sight/laser_action
	var/datum/weakref/holder_ref
	/// Active tracer objects drawn this tick.
	var/list/obj/effect/projectile/tracer/laser_sight_beam/live_tracers


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
	return ..()


/datum/component/laser_sight/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(on_item_interaction))
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_THROW, PROC_REF(on_pre_throw))
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_IMPACT, PROC_REF(on_pre_impact))
	if(isgun(parent))
		RegisterSignal(parent, COMSIG_GUN_TRY_FIRE, PROC_REF(on_gun_fire))
		var/obj/item/gun/gun_parent = parent
		original_fire_delay = gun_parent.fire_delay
		gun_parent.fire_delay = max(0, gun_parent.fire_delay - LASER_SIGHT_FIRE_DELAY_OFFSET)

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
		COMSIG_GUN_TRY_FIRE,
	))
	if(isgun(parent) && !isnull(original_fire_delay))
		var/obj/item/gun/gun_parent = parent
		gun_parent.fire_delay = original_fire_delay
		original_fire_delay = null


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
		examine_list += span_notice("\The [parent_item] has a [grade]laser sight attached. Its beam color is <font color='[laser_color]'>[laser_color]</font>.")
	examine_list += span_notice("Use a <b>screwdriver</b> to detach it.")


/datum/component/laser_sight/proc/on_item_interaction(datum/source, mob/living/user, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER

	if(istype(tool, /obj/item/screwdriver))
		detach_sight(user)
		return NONE


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
	cursor_tracker.owner_component = src
	RegisterSignal(user, COMSIG_MOB_FIRED_GUN, PROC_REF(on_fired_gun))
	RegisterSignal(user.client, COMSIG_CLIENT_MOUSEDRAG, PROC_REF(on_mouse_drag))
	RegisterSignal(user.client, COMSIG_CLIENT_MOUSEDOWN, PROC_REF(on_mouse_down))
	RegisterSignal(user.client, COMSIG_CLIENT_MOUSEUP, PROC_REF(on_mouse_up))
	START_PROCESSING(SSfastprocess, src)


/datum/component/laser_sight/proc/stop_laser()
	clear_live_tracers()
	holding_fire = FALSE

	var/mob/user = holder_ref?.resolve()
	if(user)
		UnregisterSignal(user, COMSIG_MOB_FIRED_GUN)
		if(cursor_tracker)
			user.clear_fullscreen("laser_sight")
		if(user.client)
			UnregisterSignal(user.client, list(COMSIG_CLIENT_MOUSEDRAG, COMSIG_CLIENT_MOUSEDOWN, COMSIG_CLIENT_MOUSEUP))
			clear_reticle(user.client)
		if(beam_was_visible)
			playsound(user, 'sound/items/night_vision_on.ogg', 30, TRUE, -3, frequency = -1)

	beam_was_visible = FALSE
	reticle_color = null
	cursor_tracker = null
	holder_ref = null

	STOP_PROCESSING(SSfastprocess, src)

	if(laser_action)
		var/obj/item/item_parent = parent
		item_parent.remove_item_action(laser_action)
		laser_action = null


/datum/component/laser_sight/proc/clear_live_tracers()
	for(var/obj/effect/projectile/tracer/laser_sight_beam/T in live_tracers)
		if(!QDELETED(T))
			qdel(T)
	live_tracers.Cut()


/// Bakes the cursor reticle to the current beam colour and applies it to the client.
/datum/component/laser_sight/proc/update_reticle(client/cli)
	if(!cli)
		return
	var/icon/baked = icon('modular_zubbers/icons/effects/mouse_pointers/laser_reticle.dmi')
	baked.Blend(laser_color, ICON_MULTIPLY)
	cli.mouse_override_icon = baked
	cli.mouse_pointer_icon = baked
	reticle_color = laser_color


/datum/component/laser_sight/proc/clear_reticle(client/cli)
	if(!cli)
		return
	cli.mouse_override_icon = null
	cli.mouse_pointer_icon = null
	reticle_color = null


/// TRUE if the held gun is a true full-auto weapon (carries the automatic_fire component).
/datum/component/laser_sight/proc/gun_is_full_auto()
	if(!isgun(parent))
		return FALSE
	var/obj/item/gun/G = parent
	return !isnull(G.GetComponent(/datum/component/automatic_fire))


/datum/component/laser_sight/process(seconds_per_tick)
	var/mob/user = holder_ref?.resolve()
	if(!user?.client)
		stop_laser()
		return

	var/gun_is_active = (user.get_active_held_item() == parent)
	// While scoped the view is offset toward the scope's own cursor tracker, which our flat tracker
	// can't follow, so shut the laser off for the duration rather than draw a wrong beam.
	var/suppressed = (!laser_active || !gun_is_active || HAS_TRAIT(user, TRAIT_USER_SCOPED))
	if(cursor_tracker)
		cursor_tracker.mouse_opacity = (!suppressed) ? MOUSE_OPACITY_ICON : MOUSE_OPACITY_TRANSPARENT

	if(suppressed)
		clear_live_tracers()
		holding_fire = FALSE
		beam_smoothing_primed = FALSE
		if(reticle_color)
			clear_reticle(user.client)
		if(beam_was_visible)
			beam_was_visible = FALSE
			playsound(user, 'sound/items/night_vision_on.ogg', 30, TRUE, -3, frequency = -1)
		return

	// Recompute the tracked turf from the catcher's MouseMove params on hover only. While a button
	// is held MouseMove stops firing (MouseDrag takes over), so those params are stale; recomputing
	// from them would snap the aim back to the press point and lock both the beam and the shot.
	if(cursor_tracker && !mouse_held)
		cursor_tracker.calculate_params()

	// Keep the cursor reticle in sync with the beam colour (covers rainbow mode too).
	if(laser_color != reticle_color)
		update_reticle(user.client)

	if(rainbow_mode)
		rainbow_hue = (rainbow_hue + 10) % 360
		laser_color = hue_to_rgb(rainbow_hue)
		laser_action?.build_all_button_icons(force = TRUE)

	var/turf/origin = get_turf(user)
	var/turf/target = cursor_tracker?.given_turf
	// Only act once we have a real cursor position (mouse has moved at least once).
	if(!cursor_tracker?.mouse_params || !origin || !target || origin == target || target.z != origin.z)
		clear_live_tracers()
		beam_smoothing_primed = FALSE
		return

	// Self-driven full-auto: native automatic_fire can't engage while our tracker sits on top of
	// the map, so we pace the shots ourselves at the gun's own delay while left-click is held.
	if(holding_fire && isgun(parent))
		if(world.time >= next_autofire_at)
			var/obj/item/gun/G = parent
			var/datum/component/automatic_fire/auto = G.GetComponent(/datum/component/automatic_fire)
			var/delay = auto ? auto.autofire_shot_delay : 0.3 SECONDS
			delay = max(world.tick_lag, delay - LASER_SIGHT_FIRE_DELAY_OFFSET)
			user.face_atom(target)
			G.fire_gun(target, user)
			next_autofire_at = world.time + delay

	if(!beam_was_visible)
		beam_was_visible = TRUE
		playsound(user, 'sound/items/night_vision_on.ogg', 30, TRUE, -3)

	var/mob/living/living_user = user
	if(living_user?.combat_mode)
		user.face_atom(target)

	clear_live_tracers()
	draw_beam(origin, target)


/datum/component/laser_sight/proc/draw_beam(turf/origin, turf/target)
	var/origin_px = 0
	var/origin_py = 0
	var/target_px = cursor_tracker.given_x - ICON_SIZE_X / 2
	var/target_py = cursor_tracker.given_y - ICON_SIZE_Y / 2

	var/turf/clipped = target
	for(var/turf/T as anything in get_line(origin, target))
		if(T == origin)
			continue
		if(T.density)
			clipped = T
			break
		var/blocked = FALSE
		for(var/obj/O in T)
			if(O.density && O.opacity && !istype(O, /obj/item) && !(O.pass_flags_self & (PASSGLASS|PASSWINDOW)))
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

	if(clipped != target)
		target_px = 0
		target_py = 0

	var/origin_wx = origin.x * ICON_SIZE_X + origin_px
	var/origin_wy = origin.y * ICON_SIZE_Y + origin_py
	var/true_wx = clipped.x * ICON_SIZE_X + target_px
	var/true_wy = clipped.y * ICON_SIZE_Y + target_py

	// Ease the DRAWN endpoint toward the true one so cursor jumps look a touch smoother. This is
	// purely cosmetic: firing and drag still use the exact tracked turf, never this eased point.
	if(beam_smoothing_primed)
		last_beam_wx += (true_wx - last_beam_wx) * LASER_SIGHT_BEAM_SMOOTHING
		last_beam_wy += (true_wy - last_beam_wy) * LASER_SIGHT_BEAM_SMOOTHING
	else
		last_beam_wx = true_wx
		last_beam_wy = true_wy
		beam_smoothing_primed = TRUE
	var/target_wx = last_beam_wx
	var/target_wy = last_beam_wy

	var/DX = target_wx - origin_wx
	var/DY = target_wy - origin_wy
	var/beam_length = sqrt(DX ** 2 + DY ** 2)
	if(beam_length == 0)
		return

	// Same convention as get_angle_raw, computed from the eased world-pixel delta.
	var/Angle
	if(!DY)
		Angle = (DX >= 0) ? 90 : 270
	else
		Angle = arctan(DX / DY)
		if(DY < 0)
			Angle += 180
		else if(DX < 0)
			Angle += 360

	var/mid_wx = (origin_wx + target_wx) / 2
	var/mid_wy = (origin_wy + target_wy) / 2
	var/mid_x = round(mid_wx / ICON_SIZE_X)
	var/mid_y = round(mid_wy / ICON_SIZE_Y)
	var/mid_px = mid_wx - mid_x * ICON_SIZE_X
	var/mid_py = mid_wy - mid_y * ICON_SIZE_Y

	var/turf/mid_turf = locate(clamp(mid_x, 1, world.maxx), clamp(mid_y, 1, world.maxy), origin.z)
	if(!mid_turf)
		return

	var/matrix/M = matrix()
	M.Scale(1, beam_length / ICON_SIZE_Y)
	M.Turn(Angle)

	var/obj/effect/projectile/tracer/laser_sight_beam/beam = new(mid_turf)
	beam.color = laser_color
	beam.pixel_x = mid_px
	beam.pixel_y = mid_py
	beam.transform = M

	beam.add_overlay(emissive_appearance(beam.icon, beam.icon_state, beam, effect_type = EMISSIVE_NO_BLOOM))

	QDEL_IN(beam, LASER_SIGHT_TRACER_LIFE)
	live_tracers += beam


/datum/component/laser_sight/proc/on_fired_gun(mob/user, obj/item/gun/gun_fired, target, params, zone_override, list/bonus_spread_values)
	SIGNAL_HANDLER

	if(!laser_active || user.get_active_held_item() != parent)
		return
	bonus_spread_values[MIN_BONUS_SPREAD_INDEX] -= accuracy_bonus
	bonus_spread_values[MAX_BONUS_SPREAD_INDEX] -= accuracy_bonus


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


/datum/component/laser_sight/proc/detach_sight(mob/user)
	if(!user.can_perform_action(parent, NEED_DEXTERITY))
		return

	var/saved = laser_color
	var/saved_rainbow = rainbow_mode
	var/saved_hue = rainbow_hue
	var/saved_syndie = is_syndicate

	user.balloon_alert(user, "detached laser sight")
	stop_laser()

	var/obj/item/laser_sight/dropped = new(get_turf(parent))
	dropped.saved_color = saved
	dropped.saved_rainbow = saved_rainbow
	dropped.saved_rainbow_hue = saved_hue
	dropped.saved_is_syndicate = saved_syndie
	// Rebuild the item's coloured beam overlay from the carried color; the item handles its own
	// appearance via update_overlays(), so we must NOT tint the whole housing with color = ....
	dropped.update_appearance()

	qdel(src)


/datum/component/laser_sight/proc/on_gun_fire(obj/item/gun/source, mob/living/user, atom/target, flag, params)
	SIGNAL_HANDLER
	if(target != cursor_tracker)
		return NONE
	var/turf/dest = cursor_tracker?.given_turf
	if(!dest)
		return NONE
	INVOKE_ASYNC(source, TYPE_PROC_REF(/obj/item/gun, fire_gun), dest, user)
	return COMPONENT_CANCEL_GUN_FIRE

/datum/component/laser_sight/proc/on_pre_throw(atom/movable/source, list/throw_args)
	SIGNAL_HANDLER
	if(isgun(parent))
		return
	var/turf/aim = cursor_tracker?.given_turf
	if(aim)
		var/obj/machinery/disposal/D = locate(/obj/machinery/disposal) in aim
		if(D)
			INVOKE_ASYNC(src, PROC_REF(laser_deposit), throw_args[4], D)
			return COMPONENT_CANCEL_THROW
		throw_args[1] = aim
	else
		if(istype(throw_args[1], /obj/machinery/disposal))
			INVOKE_ASYNC(src, PROC_REF(laser_deposit), throw_args[4], throw_args[1])
			return COMPONENT_CANCEL_THROW
	throw_args[2] = round(throw_args[2] * LASER_THROW_RANGE_MULT)


/datum/component/laser_sight/proc/laser_deposit(mob/thrower, obj/machinery/disposal/bin)
	var/obj/item/item_parent = parent
	item_parent.visible_message(span_notice("The laser sight accurately guides [item_parent] into [bin], wow!"))
	item_parent.forceMove(bin)


/datum/component/laser_sight/proc/on_pre_impact(atom/movable/source, atom/hit_atom, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER
	if(!istype(hit_atom, /obj/machinery/disposal))
		return
	INVOKE_ASYNC(src, PROC_REF(laser_deposit), throwingdatum?.get_thrower(), hit_atom)
	return COMPONENT_MOVABLE_IMPACT_NEVERMIND


/// While left-click is held, MouseMove stops firing and MouseDrag takes over; keep the tracked
/// turf current so full-auto follows the cursor during a held burst. If the drag began on a
/// movable, treat it as a laser drag (relocate on release) rather than sweep fire.
/datum/component/laser_sight/proc/on_mouse_drag(client/source, atom/src_object, atom/over_object, turf/src_location, turf/over_location, src_control, over_control, params)
	SIGNAL_HANDLER
	if(!cursor_tracker)
		return
	if(drag_source)
		dragging_object = TRUE
		holding_fire = FALSE // this is a drag of an object, not a sweep-fire
	var/datum/position/pos = mouse_absolute_datum_map_position_from_client(source)
	if(pos?.valid())
		var/turf/from_pos = locate(pos.x, pos.y, pos.z)
		if(from_pos)
			cursor_tracker.given_turf = from_pos
			return
	if(isturf(over_location))
		cursor_tracker.given_turf = over_location


/// Resolves the exact turf under the cursor from a click's screen-loc using integer tile math
/// (no half-tile rounding like calculate_params does), so drag pickup and fire hit the right tile
/// even near view edges. Returns null if the params carry no screen-loc.
/datum/component/laser_sight/proc/resolve_cursor_turf(client/cli, params)
	if(!cli)
		return null
	var/list/modifiers = params2list(params)
	var/screen_loc = LAZYACCESS(modifiers, SCREEN_LOC)
	if(!screen_loc)
		return null
	var/turf/eye_turf = get_turf(cli.eye)
	if(!eye_turf)
		return null
	var/list/parts = splittext(screen_loc, ",")
	if(length(parts) < 2)
		return null
	var/list/part_x = splittext(parts[1], ":")
	var/list/part_y = splittext(parts[2], ":")
	var/sx = text2num(part_x[1])
	var/sy = text2num(part_y[1])
	if(isnull(sx) || isnull(sy))
		return null
	var/list/viewsize = getviewsize(cli.view)
	var/cox = round((viewsize[1] - 1) / 2)
	var/coy = round((viewsize[2] - 1) / 2)
	return locate(eye_turf.x + (sx - 1 - cox), eye_turf.y + (sy - 1 - coy), eye_turf.z)


/datum/component/laser_sight/proc/on_mouse_down(client/source, atom/object, atom/location, control, params)
	SIGNAL_HANDLER
	// New press: clear last drag state so a stale flag can't suppress this click's shot.
	dragging_object = FALSE
	drag_source = null
	var/mob/user = holder_ref?.resolve()
	if(!user || user.get_active_held_item() != parent || !laser_active)
		return
	// ANY held button freezes hover tracking (MouseMove stops, MouseDrag takes over). Mark it so
	// process() won't recompute the tracked turf from the now-stale params and lock the aim. This
	// must run for right-click and modifier-clicks too, not just plain left-click.
	mouse_held = TRUE
	// Resolve the tracked turf from THIS click's screen-loc so it's exact (integer tiles), not the
	// half-tile-rounded value calculate_params produces and not up to a tick stale.
	if(cursor_tracker)
		var/turf/precise = resolve_cursor_turf(source, params)
		if(precise)
			cursor_tracker.given_turf = precise
		else
			cursor_tracker.mouse_params = params
			cursor_tracker.calculate_params()
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK) || LAZYACCESS(modifiers, CTRL_CLICK) || LAZYACCESS(modifiers, ALT_CLICK) || LAZYACCESS(modifiers, MIDDLE_CLICK) || LAZYACCESS(modifiers, RIGHT_CLICK))
		return // routed by the catcher's Click; no drag pickup or auto-fire for modifier/right clicks
	// Remember a movable under the cursor so a subsequent drag can relocate it.
	drag_source = cursor_tracker ? movable_under_cursor() : null
	// In throw mode the click is a throw, not a trigger pull; arming the loop here would fire
	// the gun the player is trying to throw.
	var/mob/living/living_user = user
	if(isliving(user) && living_user.throw_mode)
		return
	if(gun_is_full_auto())
		holding_fire = TRUE
		next_autofire_at = world.time


/datum/component/laser_sight/proc/on_mouse_up(client/source, atom/object, atom/location, control, params)
	SIGNAL_HANDLER
	holding_fire = FALSE
	mouse_held = FALSE
	if(dragging_object && drag_source)
		laser_relocate(drag_source, cursor_tracker?.given_turf)
	drag_source = null
	// dragging_object stays set so the engine's drag-as-click shot is suppressed; the next
	// mouse-down clears it.


/// The best movable to grab with a laser drag on the tracked turf: a non-self mob, else an item,
/// else an unanchored object. Returns null over empty/anchored-only ground (so it stays a fire).
/datum/component/laser_sight/proc/movable_under_cursor()
	var/turf/aim = cursor_tracker?.given_turf
	if(!aim)
		return null
	for(var/mob/M in aim)
		if(M != holder_ref?.resolve())
			return M
	for(var/obj/item/I in aim)
		if(I.mouse_opacity)
			return I
	for(var/obj/O in aim)
		if(O.mouse_opacity && !O.anchored && !istype(O, /obj/structure/cable) && !istype(O, /obj/machinery/atmospherics))
			return O
	return null


/// Laser "tractor": relocate a grabbed movable to the destination turf. Kept deliberately simple
/// and forgiving so it behaves the same for loose items, lockers, and mobs.
/datum/component/laser_sight/proc/laser_relocate(atom/movable/source, turf/dest)
	if(QDELETED(source) || !isturf(dest) || get_turf(source) == dest)
		return
	if(source.anchored)
		return
	if(dest.density)
		return
	if(isliving(source))
		var/mob/living/M = source
		if(M.buckled || M.anchored)
			return
	source.forceMove(dest)


/// Converts a hue value (0-359) at full saturation and value to an RGB hex string.
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
	icon = 'modular_zubbers/icons/obj/weapons/guns/laser_sight_beam.dmi'
	icon_state = "beam"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_ADD
	plane = ABOVE_LIGHTING_PLANE


/// Tracks the cursor on HUD_PLANE (inherited) exactly like the scope catcher. The only additions
/// are click routing (because this catcher is always up while the gun is held, so it must hand
/// modifier-clicks and non-gun clicks back to the world) and suppression of the click shot for
/// full-auto guns, which fire through the component's held-fire loop instead.
/atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher
	show_when_dead = TRUE
	/// The component that owns us, for reading drag/fire state.
	var/datum/component/laser_sight/owner_component

/// Best meaningful atom on the tracked turf for routed clicks: a non-self mob first, otherwise
/// the visually topmost object by (plane, layer), the same thing the player believes they clicked.
/// Contents order is insertion order, which is how a recharger's table used to win over the
/// recharger itself. include_items = FALSE keeps loose floor items (spent casings) from hijacking
/// a shot into a pickup.
/atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher/proc/best_target_on(turf/aim, include_items = TRUE)
	if(!aim)
		return null
	for(var/mob/M in aim)
		if(M != owner)
			return M
	var/obj/best
	for(var/obj/O in aim)
		if(!O.mouse_opacity)
			continue
		if(!include_items && isitem(O))
			continue
		if(istype(O, /obj/structure/cable) || istype(O, /obj/machinery/atmospherics))
			continue
		if(!best || O.plane > best.plane || (O.plane == best.plane && O.layer > best.layer))
			best = O
	return best

/atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher/Click(location, control, params)
	if(usr != owner)
		return
	// A laser drag that ends collapses into a click here (engine treats catcher->catcher as a
	// click); the relocation already happened on mouse-up, so don't also fire.
	if(owner_component?.dragging_object)
		return
	// given_turf was resolved exactly at mouse-down (screen-loc). Don't recompute from the catcher's
	// rounded MouseMove params here or the click can land a tile off from the beam.
	var/turf/aim = given_turf
	if(!aim)
		return
	var/list/modifiers = params2list(params)
	var/stripped = strip_position_params(params)
	var/mob/living/lowner = owner

	// Throw mode escapes everything below, including the full-auto swallow, or holding a WT-550
	// makes the gun unthrowable. ClickOn handles the actual throw.
	if(lowner?.throw_mode)
		owner.ClickOn(best_target_on(aim) || aim, stripped)
		return

	var/obj/item/held = owner.get_active_held_item()
	var/is_gun = isgun(held)
	var/plain_click = !LAZYACCESS(modifiers, RIGHT_CLICK) && !LAZYACCESS(modifiers, CTRL_CLICK) && !LAZYACCESS(modifiers, SHIFT_CLICK) && !LAZYACCESS(modifiers, ALT_CLICK) && !LAZYACCESS(modifiers, MIDDLE_CLICK)

	if(is_gun && plain_click)
		owner.face_atom(aim) // clicking to fire turns you, even out of combat mode
		var/obj/item/gun/G = held
		// Full-auto guns fire through the held-fire loop; swallow the click shot.
		if(G.GetComponent(/datum/component/automatic_fire))
			return
		// Shot targeting: a mob if one's there, else the topmost non-item object (recharger
		// insertion, table placement), else the bare turf. Loose items are excluded at EVERY
		// range because ejected casings land at your feet; without this, point-blank shots
		// turn into hot-casing juggling. The projectile still hits turf contents naturally.
		var/atom/shot_target = best_target_on(aim, include_items = FALSE)
		owner.ClickOn(shot_target || aim, stripped)
		return

	// Modifier clicks, right-clicks, and non-gun items act on the topmost real atom under the
	// cursor. Positional params are stripped: they're catcher-relative, and a projectile reads
	// screen-loc for its angle, which is why routed shots used to fly off-axis.
	if(is_gun)
		owner.face_atom(aim)
	owner.ClickOn(best_target_on(aim) || aim, stripped)


/// Removes catcher-relative positional keys so a routed click aims by target tile, not by the
/// fullscreen catcher's screen-loc. Keeps the button/modifier flags intact.
/atom/movable/screen/fullscreen/cursor_catcher/laser_sight_catcher/proc/strip_position_params(params)
	var/list/modifiers = params2list(params)
	modifiers -= SCREEN_LOC
	modifiers -= ICON_X
	modifiers -= ICON_Y
	modifiers -= VIS_X
	modifiers -= VIS_Y
	return list2params(modifiers)


/datum/action/item_action/toggle_laser_sight
	name = "Toggle Laser Sight"
	desc = "Enable or disable the attached laser sight beam."
	button_icon = 'modular_zubbers/icons/obj/weapons/guns/laser_sight.dmi'
	button_icon_state = "laser_sight"
	check_flags = AB_CHECK_CONSCIOUS
	var/mutable_appearance/button_beam_overlay


/datum/action/item_action/toggle_laser_sight/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/component/laser_sight/comp = target.GetComponent(/datum/component/laser_sight)
	if(!comp)
		return
	comp.laser_active = !comp.laser_active
	owner.balloon_alert(owner, comp.laser_active ? "laser on" : "laser off")


/datum/action/item_action/toggle_laser_sight/apply_button_overlay(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	. = ..()
	if(button_beam_overlay)
		current_button.cut_overlay(button_beam_overlay)
		button_beam_overlay = null
	var/datum/component/laser_sight/comp = target?.GetComponent(/datum/component/laser_sight)
	if(!comp)
		return
	button_beam_overlay = mutable_appearance('modular_zubbers/icons/obj/weapons/guns/laser_sight.dmi', "laser_sight_beam")
	button_beam_overlay.color = comp.laser_color
	button_beam_overlay.plane = FLOAT_PLANE
	button_beam_overlay.layer = FLOAT_LAYER
	current_button.add_overlay(button_beam_overlay)


#undef LASER_SIGHT_ACCURACY_STANDARD
#undef LASER_SIGHT_ACCURACY_SYNDIE
#undef LASER_THROW_RANGE_MULT
#undef LASER_SIGHT_RAINBOW_MAGIC
#undef LASER_SIGHT_TRACER_LIFE
