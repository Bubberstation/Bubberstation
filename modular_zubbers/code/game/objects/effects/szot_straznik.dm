// Szot Dynamica's reusable answer to the anti-personnel mine. Holds a cell and a capacitor;
// the capacitor decides how hard it goes off, the cell decides how many times it can.

/// Stamina dealt per capacitor rating, indexed 1 to 4
GLOBAL_LIST_INIT(straznik_stamina, list(55, 75, 95, 120))
/// Burn dealt per capacitor rating, indexed 1 to 4
GLOBAL_LIST_INIT(straznik_burn, list(28, 45, 68, 92))
/// Extra burn when running on a lead acid cell, which dumps far harder than it has any right to
#define STRAZNIK_LEAD_ACID_BONUS 25
/// Energy drawn per discharge, scaling with the square of the capacitor rating.
/// The cell answers "how much energy have I got"; the capacitor answers "how violently do I dump it".
/// A bigger capacitor therefore hits harder AND drains faster, so upgrading damage is never free.
#define STRAZNIK_DISCHARGE_COST(tier) (STANDARD_CELL_CHARGE * 0.25 * (tier) * (tier))
/// How long the capacitor takes to come back up after a discharge
#define STRAZNIK_REARM_DELAY (20 SECONDS)
/// How long the victim stays down
#define STRAZNIK_STUN_DURATION (2 SECONDS)

/obj/effect/mine/straznik
	name = "\improper Strażnik Energy Mine"
	desc = "An aging Szot Dynamica energy mine containing a replaceable power cell. When armed, it delivers a violent \
		electrical discharge to anyone unfortunate enough to trigger it. \
		Someone has crudely scratched \"NIESPODZIANKA!\" into the casing with a sharp object."
	icon = 'modular_zubbers/icons/obj/szot_mine.dmi'
	icon_state = "straznik"
	base_icon_state = "straznik"
	arm_delay = 3 SECONDS
	armed = FALSE
	greyscale_config = /datum/greyscale_config/szot_straznik
	greyscale_colors = "#83825E#86CE3E"
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	resistance_flags = INDESTRUCTIBLE
	// it lies flat on the floor, so anything dropped on top of it covers it
	layer = LOW_OBJ_LAYER
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_power = 0.5
	light_on = FALSE
	/// The cell providing the discharge
	var/obj/item/stock_parts/power_store/cell/cell
	/// The capacitor governing how violently that discharge is dumped
	var/obj/item/stock_parts/capacitor/capacitor
	/// Is the maintenance panel open
	var/panel_open = FALSE
	/// Set while turning back into the carried form, so Destroy does not make a second one
	var/converting = FALSE

/obj/effect/mine/straznik/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddElement(/datum/element/gags_recolorable)
	sync_lamp_light()
	update_appearance()

/// Better internals mean a brighter pilot lamp, but even a fully upgraded one stays dimmer than the
/// stock mines, which sit at range 1.6 and power 2.
/obj/effect/mine/straznik/proc/sync_lamp_brightness()
	var/tier = capacitor?.rating || 1
	set_light_range(0.9 + tier * 0.15)
	set_light_power(0.4 + tier * 0.15)

/// The glow follows whatever the lamp has been painted, rather than a hardcoded green
/obj/effect/mine/straznik/proc/sync_lamp_light()
	var/list/parts = splittext(greyscale_colors, "#")
	if(length(parts) >= 3)
		set_light_color("#[parts[3]]")

/obj/effect/mine/straznik/set_greyscale(list/colors, new_config)
	. = ..()
	sync_lamp_light()
	update_appearance()

/// Deliberately does not call parent: the base prints "beeps softly, indicating it is now active",
/// and between the sound, the lamp and the examine text that sentence is doing nothing.
/obj/effect/mine/straznik/now_armed()
	armed = TRUE
	sync_lamp_brightness()
	set_light_on(TRUE)
	playsound(src, 'modular_zubbers/sound/effects/szot/tesla_mine_deploy_beep.ogg', 50, FALSE)
	visible_message(span_danger("\The [src] beeps softly."), vision_distance = COMBAT_MESSAGE_RANGE)
	update_appearance()

/obj/effect/mine/straznik/Destroy()
	// a Strażnik is not consumable. if anything deletes the planted form, the hardware survives.
	if(!converting && !QDELETED(loc))
		var/obj/item/minespawner/straznik/salvage = new(get_turf(src))
		salvage.set_greyscale(greyscale_colors)
		if(cell)
			cell.forceMove(salvage)
			salvage.cell = cell
			cell = null
		if(capacitor)
			capacitor.forceMove(salvage)
			salvage.capacitor = capacitor
			capacitor = null
	QDEL_NULL(cell)
	QDEL_NULL(capacitor)
	return ..()

/obj/effect/mine/straznik/update_overlays()
	. = ..()
	if(armed && isturf(loc))
		. += emissive_appearance(icon, "[base_icon_state]-emissive", src, alpha = 60 + (capacitor?.rating || 1) * 15)

/obj/effect/mine/straznik/examine(mob/user)
	. = ..()
	if(isnull(cell))
		. += span_notice("There is no power cell installed.")
	else
		. += span_notice("The power cell reads [round(cell.percent())]%.")
	if(cell && capacitor)
		var/per_shot = STRAZNIK_DISCHARGE_COST(capacitor.rating)
		. += span_notice("It can discharge approximately [round(cell.charge / per_shot)] more times.")
	. += span_notice("The maintenance panel is [panel_open ? "open" : "screwed shut"].")
	if(panel_open)
		. += span_notice("The capacitor and the power cell can be swapped out by hand.")

/obj/effect/mine/straznik/examine_more(mob/user)
	. = ..()

	. += "The 'Strażnik' was produced in large numbers for CIN forces as a reusable alternative to conventional \
		anti-personnel mines. Its electrical discharge was intended to electrocute intruders rather than making an \
		expensive hole in the facility it was activated in."

	. += "Time has not been especially kind to surviving examples. Most of these mines now contain thoroughly obsolete \
		electrical components, and half dead leaky power cells installed when they entered storage; they have the \
		occasional habit of electrocuting an unwitting farmer or colonist with no way of knowing their home was once \
		a CIN battlefield."

	. += "Fortunately, all the important parts are replaceable, leaving your mind to grapple with the terrifying \
		concept of a reusable landmine."

	return .

/// How much punishment this mine can currently deliver, given what is bolted into it
/obj/effect/mine/straznik/proc/discharge_power()
	var/rating = capacitor?.rating || 1
	var/stamina = GLOB.straznik_stamina[clamp(rating, 1, length(GLOB.straznik_stamina))]
	var/burn = GLOB.straznik_burn[clamp(rating, 1, length(GLOB.straznik_burn))]
	if(istype(cell, /obj/item/stock_parts/power_store/cell/lead))
		burn += STRAZNIK_LEAD_ACID_BONUS
	return list("stamina" = stamina, "burn" = burn)

/obj/effect/mine/straznik/mineEffect(mob/victim)
	if(QDELETED(src) || !armed || !isliving(victim))
		return
	var/mob/living/target = victim
	// draw through use() rather than touching charge directly, so a rigged cell behaves as a rigged cell should
	var/tier = capacitor?.rating || 1
	if(!cell?.use(STRAZNIK_DISCHARGE_COST(tier)))
		visible_message(span_warning("\The [src] clicks flatly and does nothing."))
		disarm()
		return

	playsound(src, 'modular_zubbers/sound/effects/szot/tesla_mine_detonation_chirp.ogg', 70, FALSE)
	playsound(src, 'modular_zubbers/sound/effects/szot/tesla_mine_windup.ogg', 70, FALSE)
	// the show scales with the capacitor, so a quadratic mine visibly throws more than a basic one.
	// arcs lash out at everything nearby, but only whoever stepped on it actually takes the hit.
	var/reach = 1 + round(tier / 2)
	for(var/mob/living/bystander in view(reach, src))
		Beam(bystander, icon = 'icons/effects/beam.dmi', icon_state = "lightning[rand(1, 12)]", time = 0.8 SECONDS)
	for(var/turf/open/floor/scorched in view(reach, src))
		if(!prob(8 + tier * 6))
			continue
		Beam(scorched, icon = 'icons/effects/beam.dmi', icon_state = "lightning[rand(1, 12)]", time = 0.6 SECONDS)
		scorched.burn_tile()
	for(var/burst in 1 to round(tier / 2) + 1)
		Beam(target, icon = 'icons/effects/beam.dmi', icon_state = "lightning[rand(1, 12)]", time = 0.9 SECONDS)
	var/turf/open/floor/underfoot = get_turf(src)
	if(istype(underfoot))
		underfoot.burn_tile()
	do_sparks(3 + tier, TRUE, src)
	target.do_jitter_animation(20 + tier * 10)

	var/list/power = discharge_power()
	playsound(src, 'modular_zubbers/sound/effects/szot/tesla_mine_shock.ogg', 80, FALSE)
	// insulated gloves do not save you from a stun baton and they do not save you from this either.
	// electrocute_act filters everything through gloves and resistances, so the shock call is kept purely
	// for the jitter and the sparks, and the damage is applied directly where nothing can absorb it.
	target.electrocute_act(0, src, siemens_coeff = 0, flags = SHOCK_NOSTUN | SHOCK_SUPPRESS_MESSAGE)
	// a solid hit can leave a burn wound, and a better capacitor makes that likelier
	target.apply_damage(power["burn"], BURN, spread_damage = TRUE, wound_bonus = tier * 8)
	target.adjust_stamina_loss(power["stamina"])
	target.Knockdown(STRAZNIK_STUN_DURATION)

	if(!cell.charge)
		disarm()

/obj/effect/mine/straznik/screwdriver_act(mob/living/user, obj/item/tool)
	if(armed)
		balloon_alert(user, "it's live!")
		return ITEM_INTERACT_BLOCKING
	panel_open = !panel_open
	balloon_alert(user, panel_open ? "panel opened" : "panel closed")
	tool.play_tool_sound(src)
	return ITEM_INTERACT_SUCCESS

/obj/effect/mine/straznik/ranged_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	// the bluespace replacer works at a distance on machines; it should here too
	if(!istype(tool, /obj/item/storage/part_replacer/bluespace))
		return ..()
	var/swapped = swap_internal_part(user, tool)
	return isnull(swapped) ? ..() : swapped

/obj/effect/mine/straznik/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(armed && !istype(tool, /obj/item/storage/part_replacer/bluespace))
		balloon_alert(user, "it's live!")
		return ITEM_INTERACT_BLOCKING
	if(!panel_open)
		// a bluespace replacer reaches inside on its own; anything else needs the housing opened first
		if(istype(tool, /obj/item/storage/part_replacer/bluespace))
			var/swapped = swap_internal_part(user, tool)
			if(!isnull(swapped))
				return swapped
		else if(istype(tool, /obj/item/storage/part_replacer))
			balloon_alert(user, "unscrew the panel first!")
			return ITEM_INTERACT_BLOCKING
		return ..()
	var/swapped = swap_internal_part(user, tool)
	return isnull(swapped) ? ..() : swapped

/// Handles a capacitor, a cell, or a parts replacer being offered to an open mine.
/// Returns null if the tool was none of those, so the caller can fall through.
/obj/effect/mine/straznik/proc/swap_internal_part(mob/living/user, obj/item/tool)
	if(istype(tool, /obj/item/storage/part_replacer))
		var/obj/item/storage/part_replacer/replacer = tool
		var/upgraded = FALSE
		for(var/obj/item/stock_parts/capacitor/spare in replacer.contents)
			if(!capacitor || spare.rating > capacitor.rating)
				if(capacitor)
					replacer.atom_storage.attempt_insert(capacitor, user, override = TRUE)
				replacer.atom_storage.attempt_remove(spare, src)
				capacitor = spare
				upgraded = TRUE
				break
		for(var/obj/item/stock_parts/power_store/cell/spare in replacer.contents)
			if(!cell || spare.maxcharge > cell.maxcharge)
				if(cell)
					replacer.atom_storage.attempt_insert(cell, user, override = TRUE)
				replacer.atom_storage.attempt_remove(spare, src)
				cell = spare
				upgraded = TRUE
				break
		balloon_alert(user, upgraded ? "parts upgraded" : "nothing better")
		if(upgraded)
			// exchange_parts is a machinery proc, so a replacer used on an effect plays nothing by itself
			replacer.play_rped_effect()
			user.Beam(src, icon_state = "rped_upgrade", time = 0.5 SECONDS)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stock_parts/capacitor))
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		if(capacitor)
			user.put_in_hands(capacitor)
		capacitor = tool
		sync_lamp_brightness()
		balloon_alert(user, "capacitor fitted")
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stock_parts/power_store/cell))
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		if(cell)
			user.put_in_hands(cell)
		cell = tool
		balloon_alert(user, "cell fitted")
		return ITEM_INTERACT_SUCCESS

	return null

// the base mine deletes itself on trigger and waits for the victim's next move before firing.
// neither suits a reusable one, so both are replaced.
/obj/effect/mine/straznik/triggermine(atom/movable/triggerer)
	if(triggered || !armed || !presses_the_plate(triggerer))
		return
	triggered = TRUE
	visible_message(span_danger("[icon2html(src, viewers(src))] \The [src] discharges!"))
	mineEffect(triggerer)
	SEND_SIGNAL(src, COMSIG_MINE_TRIGGERED, triggerer)
	// it survives, and brings itself back up once the capacitor recovers
	disarm()
	triggered = FALSE
	addtimer(CALLBACK(src, PROC_REF(attempt_rearm)), STRAZNIK_REARM_DELAY, TIMER_UNIQUE | TIMER_OVERRIDE)

/obj/effect/mine/straznik/on_entered(datum/source, atom/movable/arrived, atom/old_loc)
	if(!armed || !can_trigger(arrived))
		return
	triggermine(arrived)

/// It takes a person's weight to close the plate. Thrown hats, shoved lockers and mice do not.
/obj/effect/mine/straznik/proc/presses_the_plate(atom/movable/candidate)
	if(!isliving(candidate))
		return FALSE
	var/mob/living/stepper = candidate
	return stepper.mob_size >= MOB_SIZE_HUMAN

/// Brings it back online by itself if there is still charge in the cell
/obj/effect/mine/straznik/proc/attempt_rearm()
	if(QDELETED(src) || armed || panel_open)
		return
	if(!cell?.charge || cell.charge < STRAZNIK_DISCHARGE_COST(capacitor?.rating || 1))
		return
	armed = TRUE
	set_light_on(TRUE)
	update_appearance()
	playsound(src, 'modular_zubbers/sound/effects/szot/tesla_mine_deploy_beep.ogg', 40, FALSE)

/// Drops the mine back to a safe state without destroying it
/obj/effect/mine/straznik/proc/disarm()
	armed = FALSE
	set_light_on(FALSE)
	update_appearance()

#undef STRAZNIK_REARM_DELAY
#undef STRAZNIK_LEAD_ACID_BONUS
#undef STRAZNIK_DISCHARGE_COST
#undef STRAZNIK_STUN_DURATION

// The carried form. Arms in hand, deploys where you drop it, and takes its parts with it in both directions.

/obj/item/minespawner/straznik
	resistance_flags = INDESTRUCTIBLE
	name = "\improper Strażnik Energy Mine"
	desc = "An aging Szot Dynamica energy mine containing a replaceable power cell. When armed, it delivers a violent \
		electrical discharge to anyone unfortunate enough to trigger it. \
		Someone has crudely scratched \"NIESPODZIANKA!\" into the casing with a sharp object."
	icon = 'modular_zubbers/icons/obj/szot_mine.dmi'
	icon_state = "straznik"
	base_icon_state = "straznik"
	greyscale_config = /datum/greyscale_config/szot_straznik
	greyscale_colors = "#83825E#86CE3E"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	w_class = WEIGHT_CLASS_SMALL
	mine_type = /obj/effect/mine/straznik
	/// Carried across deployment and recovery, so upgrades are never lost
	var/obj/item/stock_parts/power_store/cell/cell
	/// Ditto
	var/obj/item/stock_parts/capacitor/capacitor
	/// Is the maintenance panel open
	var/panel_open = FALSE

/obj/item/minespawner/straznik/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]-inactive"
	cell = new /obj/item/stock_parts/power_store/cell(src)
	capacitor = new /obj/item/stock_parts/capacitor(src)
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddElement(/datum/element/gags_recolorable)

/obj/item/minespawner/straznik/Destroy()
	QDEL_NULL(cell)
	QDEL_NULL(capacitor)
	return ..()

/obj/item/minespawner/straznik/examine(mob/user)
	. = ..()
	. += span_notice("The power cell reads [cell ? "[round(cell.percent())]%" : "empty"]. It can be swapped out by hand.")
	. += span_notice("A [capacitor ? capacitor.name : "missing capacitor"] is fitted. A better one makes it hit harder.")
	. += span_notice("The maintenance panel is [panel_open ? "open" : "screwed shut"].")

/obj/item/minespawner/straznik/attack_self(mob/user)
	if(!cell?.charge)
		balloon_alert(user, "no charge!")
		return
	if(!capacitor)
		balloon_alert(user, "no capacitor!")
		return
	if(panel_open)
		balloon_alert(user, "close the panel first!")
		return
	playsound(src, 'modular_zubbers/sound/effects/szot/tesla_mine_deploy_beep.ogg', 60, FALSE)
	to_chat(user, span_warning("You press a button marked \"ARM\" on \the [src]. It begins to hum ominously!"))
	active = TRUE
	addtimer(CALLBACK(src, PROC_REF(deploy_mine)), 3 SECONDS)

/obj/item/minespawner/straznik/attack_hand_secondary(mob/user, list/modifiers)
	if(!cell)
		balloon_alert(user, "no cell!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	user.put_in_hands(cell)
	cell = null
	balloon_alert(user, "cell removed")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/minespawner/straznik/screwdriver_act(mob/living/user, obj/item/tool)
	panel_open = !panel_open
	balloon_alert(user, panel_open ? "panel opened" : "panel closed")
	tool.play_tool_sound(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/minespawner/straznik/ranged_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/storage/part_replacer/bluespace))
		return ..()
	var/swapped = swap_internal_part(user, tool)
	return isnull(swapped) ? ..() : swapped

/obj/item/minespawner/straznik/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!panel_open)
		if(istype(tool, /obj/item/storage/part_replacer/bluespace))
			var/swapped = swap_internal_part(user, tool)
			if(!isnull(swapped))
				return swapped
		else if(istype(tool, /obj/item/storage/part_replacer))
			balloon_alert(user, "unscrew the panel first!")
			return ITEM_INTERACT_BLOCKING
		return ..()
	var/swapped = swap_internal_part(user, tool)
	return isnull(swapped) ? ..() : swapped

/// Same servicing as the planted form
/obj/item/minespawner/straznik/proc/swap_internal_part(mob/living/user, obj/item/tool)
	if(istype(tool, /obj/item/storage/part_replacer))
		var/obj/item/storage/part_replacer/replacer = tool
		var/upgraded = FALSE
		for(var/obj/item/stock_parts/capacitor/spare in replacer.contents)
			if(!capacitor || spare.rating > capacitor.rating)
				if(capacitor)
					replacer.atom_storage.attempt_insert(capacitor, user, override = TRUE)
				replacer.atom_storage.attempt_remove(spare, src)
				capacitor = spare
				upgraded = TRUE
				break
		for(var/obj/item/stock_parts/power_store/cell/spare in replacer.contents)
			if(!cell || spare.maxcharge > cell.maxcharge)
				if(cell)
					replacer.atom_storage.attempt_insert(cell, user, override = TRUE)
				replacer.atom_storage.attempt_remove(spare, src)
				cell = spare
				upgraded = TRUE
				break
		balloon_alert(user, upgraded ? "parts upgraded" : "nothing better")
		if(upgraded)
			replacer.play_rped_effect()
			user.Beam(src, icon_state = "rped_upgrade", time = 0.5 SECONDS)
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/stock_parts/capacitor))
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		if(capacitor)
			user.put_in_hands(capacitor)
		capacitor = tool
		balloon_alert(user, "capacitor fitted")
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/stock_parts/power_store/cell))
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		if(cell)
			user.put_in_hands(cell)
		cell = tool
		balloon_alert(user, "cell fitted")
		return ITEM_INTERACT_SUCCESS
	return null

/obj/item/minespawner/straznik/deploy_mine()
	var/obj/effect/mine/straznik/planted = new mine_type(get_turf(src))
	planted.set_greyscale(greyscale_colors)
	if(cell)
		cell.forceMove(planted)
		planted.cell = cell
		cell = null
	if(capacitor)
		capacitor.forceMove(planted)
		planted.capacitor = capacitor
		capacitor = null
	qdel(src)

/// Lifts a safe mine back out of the floor, parts and all
/obj/effect/mine/straznik/attack_hand(mob/user, list/modifiers)
	if(armed)
		balloon_alert(user, "disarming...")
		if(!do_after(user, 5 SECONDS, src))
			return
		disarm()
		balloon_alert(user, "disarmed")
		return
	balloon_alert(user, "lifting mine...")
	if(!do_after(user, 3 SECONDS, src))
		return
	var/obj/item/minespawner/straznik/recovered = new(get_turf(src))
	recovered.set_greyscale(greyscale_colors)
	if(cell)
		cell.forceMove(recovered)
		recovered.cell = cell
		cell = null
	if(capacitor)
		capacitor.forceMove(recovered)
		recovered.capacitor = capacitor
		capacitor = null
	user.put_in_hands(recovered)
	converting = TRUE
	qdel(src)
