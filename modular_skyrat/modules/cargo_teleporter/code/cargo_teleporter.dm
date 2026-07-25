GLOBAL_LIST_EMPTY(cargo_marks)

/// The stock beacon palette. One swatch per department, so a beacon can be read at a glance from across the room.
GLOBAL_LIST_INIT(cargo_beacon_palette, list(
	"Cargo" = COLOR_CARGO_BROWN,
	"Command" = COLOR_COMMAND_BLUE,
	"Engineering" = COLOR_ENGINEERING_ORANGE,
	"Medical" = COLOR_MEDICAL_BLUE,
	"Science" = COLOR_SCIENCE_PINK,
	"Security" = COLOR_SECURITY_RED,
	"Service" = COLOR_SERVICE_LIME,
))

/// Palette entry that drops the user into the full 24 bit colour picker instead of a stock swatch.
#define CARGO_BEACON_CUSTOM "Custom..."

/// How many beacons a single teleporter can have staked out at once.
#define CARGO_TELEPORTER_MAX_MARKERS 4
/// How long the capacitor takes to recharge between pulls.
#define CARGO_TELEPORTER_COOLDOWN (8 SECONDS)
/// How long the pad takes to line up each object after the first. Short, but it is what keeps the pad from lifting a whole room in one tick.
#define CARGO_TELEPORTER_LIFT_DELAY (0.2 SECONDS)

/obj/item/cargo_teleporter
	name = "cargo teleporter"
	desc = "An item that can deploy a handful of telebeacon markers, allowing them to teleport items to their beacon network afterwards."
	icon = 'modular_skyrat/modules/cargo_teleporter/icons/cargo_teleporter.dmi'
	icon_state = "cargo_tele"
	// no worn_icon_state on purpose. This is how the worn_icons unit test is told so
	worn_icon = 'modular_skyrat/modules/cargo_teleporter/icons/cargo_teleporter.dmi'
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	///the beacons staked out by this teleporter
	var/list/marker_children = list()
	///what colour the next beacon staked out by this teleporter will be painted
	var/beacon_color = COLOR_CARGO_BROWN
	///the tractor beam held open for the duration of a lift
	var/datum/beam/lift_beam
	///timer id for the recharge chime, so we do not stack them
	var/recharge_timer
	///set while a lift is in progress, so a second one cannot start on top of it
	var/lifting = FALSE

	COOLDOWN_DECLARE(use_cooldown)

/obj/item/cargo_teleporter/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_WORN_ICON, INNATE_TRAIT) // it has no worn sprite and does not want one
	update_appearance(UPDATE_OVERLAYS)

/obj/item/cargo_teleporter/Destroy()
	deltimer(recharge_timer)
	QDEL_NULL(lift_beam)
	recall_beacons()
	return ..()

/obj/item/cargo_teleporter/proc/recall_beacons()
	// hand the list off first. Beacons pull themselves out of it as they die, and DM skips entries
	// when a list mutates under a for loop mid-iteration.
	var/list/obj/effect/decal/cleanable/cargo_mark/recalled = marker_children
	marker_children = list()
	QDEL_LIST(recalled)

/obj/item/cargo_teleporter/examine(mob/user)
	. = ..()
	. += span_notice("Use it in your hand to stake out a telebeacon. It supports [CARGO_TELEPORTER_MAX_MARKERS], and has [length(marker_children)] deployed.")
	. += span_notice("[EXAMINE_HINT("Alt-click")] to pick a departmental colour for the next beacon it stakes out, or [EXAMINE_HINT("Ctrl-click")] to recall every beacon it owns.")
	if(COOLDOWN_FINISHED(src, use_cooldown))
		. += span_green("The capacitor light is steady green. It is ready to fire.")
	else
		. += span_warning("The capacitor light is blinking amber. [DisplayTimeText(COOLDOWN_TIMELEFT(src, use_cooldown))] until recharge.")

/obj/item/cargo_teleporter/update_overlays()
	. = ..()
	var/light_state = COOLDOWN_FINISHED(src, use_cooldown) ? "cargo_tele_ready" : "cargo_tele_charging"
	. += mutable_appearance(icon, light_state)
	. += emissive_appearance(icon, light_state, src)

/obj/item/cargo_teleporter/click_alt(mob/user)
	var/picked = tgui_input_list(user, "Paint the next telebeacon", "[src]", GLOB.cargo_beacon_palette + CARGO_BEACON_CUSTOM)
	if(isnull(picked) || QDELETED(src) || !user.is_holding(src))
		return CLICK_ACTION_BLOCKING
	if(picked == CARGO_BEACON_CUSTOM)
		pick_painting_tool_color(user, beacon_color)
		return CLICK_ACTION_SUCCESS
	set_painting_tool_color(GLOB.cargo_beacon_palette[picked])
	balloon_alert(user, "next beacon: [LOWER_TEXT(picked)]")
	return CLICK_ACTION_SUCCESS

/obj/item/cargo_teleporter/set_painting_tool_color(chosen_color)
	. = ..()
	// only the next beacon is painted. Ones already staked out keep their colour.
	beacon_color = chosen_color

/obj/item/cargo_teleporter/item_ctrl_click(mob/user)
	if(!length(marker_children))
		balloon_alert(user, "no beacons out!")
		return CLICK_ACTION_BLOCKING
	balloon_alert(user, "beacons recalled")
	recall_beacons()
	return CLICK_ACTION_SUCCESS

/obj/item/cargo_teleporter/attack_self(mob/user, list/modifiers)
	if(length(marker_children) >= CARGO_TELEPORTER_MAX_MARKERS)
		balloon_alert(user, "beacon limit reached!")
		return
	var/turf/stake_turf = get_turf(src)
	if(locate(/obj/effect/decal/cleanable/cargo_mark) in stake_turf)
		balloon_alert(user, "beacon already here!")
		return
	var/obj/effect/decal/cleanable/cargo_mark/spawned_marker = new(stake_turf)
	spawned_marker.parent_item = src
	spawned_marker.recolor(beacon_color)
	marker_children += spawned_marker
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	to_chat(user, span_notice("You stake out a telebeacon below your feet."))

/obj/item/cargo_teleporter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/effect/decal/cleanable/cargo_mark))
		to_chat(user, span_notice("You recall [interacting_with] using [src]."))
		playsound(interacting_with, 'sound/machines/click.ogg', 50, TRUE)
		qdel(interacting_with)
		return ITEM_INTERACT_SUCCESS

	if(lifting)
		return ITEM_INTERACT_BLOCKING
	if(!COOLDOWN_FINISHED(src, use_cooldown))
		balloon_alert(user, "still recharging!")
		return ITEM_INTERACT_BLOCKING
	if(!length(GLOB.cargo_marks))
		balloon_alert(user, "no beacons deployed!")
		return ITEM_INTERACT_BLOCKING

	var/obj/effect/decal/cleanable/cargo_mark/choice = tgui_input_list(user, "Select which telebeacon to send the items to?", "Telebeacon Selection", GLOB.cargo_marks)
	if(QDELETED(choice) || QDELETED(src) || QDELETED(interacting_with))
		return ITEM_INTERACT_BLOCKING
	if(get_dist(user, interacting_with) > 1 || !user.is_holding(src))
		return ITEM_INTERACT_BLOCKING
	if(lifting || !COOLDOWN_FINISHED(src, use_cooldown))
		return ITEM_INTERACT_BLOCKING

	var/turf/beacon_turf = get_turf(choice)
	var/turf/target_turf = get_turf(interacting_with)
	if(isnull(beacon_turf) || isnull(target_turf))
		return ITEM_INTERACT_BLOCKING
	if(!length(get_liftable_items(target_turf)))
		balloon_alert(user, "nothing to lift!")
		return ITEM_INTERACT_BLOCKING

	lifting = TRUE
	// beam from the user, not src. A held item has no world coordinates, so it anchors to (0,0).
	lift_beam = user.Beam(target_turf, icon_state = "b_beam", beam_color = choice.beacon_color, maxdistance = 2)
	var/lifted = lift_turf(user, target_turf, beacon_turf, choice.beacon_color)
	QDEL_NULL(lift_beam)
	lifting = FALSE

	if(!lifted)
		return ITEM_INTERACT_BLOCKING

	begin_recharge()
	return ITEM_INTERACT_SUCCESS

/// Feeds items to the beacon one at a time. Returns how many made the trip.
/obj/item/cargo_teleporter/proc/lift_turf(mob/living/user, turf/target_turf, turf/beacon_turf, beam_color)
	// the first item is free, every one after costs a do_after, so lifted doubles as the count and
	// the "sent one yet" flag. The turf is snapshotted before the loop starts sleeping.
	var/lifted = 0
	for(var/obj/movable_content as anything in get_liftable_items(target_turf))
		if(lifted && !do_after(user, CARGO_TELEPORTER_LIFT_DELAY, user))
			break
		if(QDELETED(src) || !user.is_holding(src))
			break
		// the world moves while we sleep, so trust nothing until the moment it lifts
		if(QDELETED(movable_content) || movable_content.loc != target_turf || movable_content.anchored)
			continue
		if(!do_teleport(movable_content, beacon_turf, no_effects = TRUE))
			continue
		flash_teleport(movable_content, target_turf, beacon_turf, beam_color)
		lifted++
	return lifted

/// Smears the object out of existence where it stood, and pours it back in where it lands, so things do not simply blink from tile to tile.
/obj/item/cargo_teleporter/proc/flash_teleport(atom/movable/lifted_atom, turf/target_turf, turf/beacon_turf, effect_color)
	new /obj/effect/temp_visual/decoy/cargo_teleport(target_turf, lifted_atom, effect_color)
	new /obj/effect/temp_visual/decoy/cargo_teleport/arriving(beacon_turf, lifted_atom, effect_color)
	playsound(target_turf, 'sound/effects/magic/Disable_Tech.ogg', 30, TRUE)
	playsound(beacon_turf, 'sound/effects/magic/Disable_Tech.ogg', 30, TRUE)

/// Snapshots the objects on a turf worth lifting. /obj typed, so mobs and turfs never come up.
/obj/item/cargo_teleporter/proc/get_liftable_items(turf/target_turf)
	var/list/liftable = list()
	for(var/obj/movable_content in target_turf)
		// items and structures only. Crates and lockers are /obj/structure/closet and are the point.
		if(!istype(movable_content, /obj/item) && !istype(movable_content, /obj/structure))
			continue
		if(movable_content.anchored)
			continue
		liftable += movable_content
	return liftable

/obj/item/cargo_teleporter/proc/begin_recharge()
	COOLDOWN_START(src, use_cooldown, CARGO_TELEPORTER_COOLDOWN)
	update_appearance(UPDATE_OVERLAYS)
	deltimer(recharge_timer)
	recharge_timer = addtimer(CALLBACK(src, PROC_REF(finish_recharge)), CARGO_TELEPORTER_COOLDOWN, TIMER_STOPPABLE)

/// Chimes and greens the light once the capacitor is full.
/obj/item/cargo_teleporter/proc/finish_recharge()
	recharge_timer = null
	update_appearance(UPDATE_OVERLAYS)
	playsound(src, 'sound/machines/ping.ogg', 30, TRUE)
	if(ismob(loc))
		var/mob/holder = loc
		balloon_alert(holder, "ready")

/datum/design/cargo_teleporter
	name = "Cargo Teleporter"
	desc = "A wonderful item that can set markers and teleport things to those markers."
	id = "cargotele"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/cargo_teleporter
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_CARGO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/techweb_node/cargo_teleporter
	id = TECHWEB_NODE_CARGO_TELEPORTER
	display_name = "Cargo Teleporter"
	description = "We can teleport items across long distances, as long as they are not blocked."
	prereq_ids = list(TECHWEB_NODE_BLUESPACE_THEORY)
	design_ids = list(
		"cargotele",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/// The bluespace smear left by a lifted object. Clones its appearance, so a crate smears as a crate.
/obj/effect/temp_visual/decoy/cargo_teleport
	duration = 0.6 SECONDS
	/// how far the smear is squeezed on the horizontal as it goes
	var/smear_width = 0.15
	/// how far the smear is drawn out on the vertical as it goes
	var/smear_height = 1.7

/obj/effect/temp_visual/decoy/cargo_teleport/Initialize(mapload, atom/mimiced_atom, effect_color)
	. = ..()
	if(effect_color)
		add_atom_colour(effect_color, TEMPORARY_COLOUR_PRIORITY)
	play_smear()

/obj/effect/temp_visual/decoy/cargo_teleport/proc/smear_matrix()
	var/matrix/smear = matrix()
	smear.Scale(smear_width, smear_height)
	return smear

/obj/effect/temp_visual/decoy/cargo_teleport/proc/play_smear()
	animate(src, transform = smear_matrix(), alpha = 0, time = duration, easing = SINE_EASING | EASE_IN)

/// The same smear run backwards, for the object resolving at the far end.
/obj/effect/temp_visual/decoy/cargo_teleport/arriving/play_smear()
	transform = smear_matrix()
	alpha = 0
	animate(src, transform = matrix(), alpha = 255, time = duration * 0.4, easing = SINE_EASING | EASE_OUT)
	animate(alpha = 0, time = duration * 0.6)

/obj/effect/decal/cleanable/cargo_mark
	name = "telebeacon"
	desc = "A beacon staked out by a cargo teleporter, which allows targeted teleportation. Can be recalled by the cargo teleporter, or relabelled with a pen."
	icon = 'modular_skyrat/modules/cargo_teleporter/icons/cargo_teleporter.dmi'
	icon_state = "marker"
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	// cleanables merge with their own type on a turf by default, which had beacons quietly eating each other
	mergeable_decal = FALSE
	///the teleporter that staked out this beacon
	var/obj/item/cargo_teleporter/parent_item
	///the colour this beacon was staked out with. Read back by the teleporter to tint the beam and the shimmer.
	var/beacon_color = COLOR_CARGO_BROWN
	///the auto-generated label this beacon was stamped with, restored if someone resets a pen rename
	var/default_name

	light_range = 3
	light_color = COLOR_CARGO_BROWN

/obj/effect/decal/cleanable/cargo_mark/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	var/area/beacon_area = get_area(src)
	default_name = "[beacon_area.name] ([rand(1000, 9999)])"
	name = default_name
	GLOB.cargo_marks += src

/obj/effect/decal/cleanable/cargo_mark/rename_reset()
	name = default_name

/obj/effect/decal/cleanable/cargo_mark/Destroy()
	if(parent_item)
		// not LAZYREMOVE. It nulls the list once it empties, and length(null) is 0, which silently
		// uncaps the beacon limit forever.
		parent_item.marker_children -= src
		parent_item = null
	GLOB.cargo_marks -= src
	return ..()

/// Repaints this beacon and the light it throws.
/obj/effect/decal/cleanable/cargo_mark/proc/recolor(new_color)
	beacon_color = new_color
	add_atom_colour(new_color, FIXED_COLOUR_PRIORITY)
	set_light_color(new_color)

#undef CARGO_TELEPORTER_MAX_MARKERS
#undef CARGO_TELEPORTER_COOLDOWN
#undef CARGO_TELEPORTER_LIFT_DELAY
#undef CARGO_BEACON_CUSTOM
