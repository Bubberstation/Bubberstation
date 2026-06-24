/*
 * Laser Sight Items
 *
 * obj/item/laser_sight           — standard Cybersun civilian/security unit
 * obj/item/laser_sight/syndicate — syndicate black-market grade, illegal tech
 *
 * Apply to any item by clicking it with the laser sight in hand.
 * The parent item gains datum/component/laser_sight.
 * Multitool: change beam colour (hex input; "fabulousputin" enables rainbow).
 * Screwdriver: detach, dropping a new laser sight with the saved colour.
 */

// ---- Base item ----

/obj/item/laser_sight
	name = "laser sight"
	desc = "A Cybersun Industries tactical laser sight module. An advanced smart-adhesive compound on the mount \
			permits 'tactical' application to any armament or, frankly, any other item you feel deserves one, \
			regardless of any intended mounting schema such as a picatinny rail or lack thereof. \
			Defaults to a security-red beam; use a multitool to change colour. Use a <b>screwdriver</b> to detach."
	icon = 'modular_zubbers/icons/obj/weapons/guns/laser_sight.dmi'
	icon_state = "laser_sight"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_LPOCKET | ITEM_SLOT_RPOCKET

	/// Saved beam colour, transferred through detach/reattach cycles.
	var/saved_color = "#CB0000"
	/// Saved rainbow state, transferred through detach/reattach cycles.
	var/saved_rainbow = FALSE
	/// Current rainbow hue on the unattached item (0-359), driven by process().
	var/saved_rainbow_hue = 0
	/// Whether this is a syndicate unit; passed into the component.
	var/saved_is_syndicate = FALSE


/obj/item/laser_sight/Initialize(mapload)
	. = ..()
	update_appearance()


/obj/item/laser_sight/update_overlays()
	. = ..()
	var/mutable_appearance/beam = mutable_appearance('modular_zubbers/icons/obj/weapons/guns/laser_sight.dmi', "laser_sight_beam")
	if(saved_rainbow)
		beam.color = laser_sight_standalone_hue_to_rgb(saved_rainbow_hue)
	else
		beam.color = saved_color
	. += beam


/// Drives rainbow colour cycling on the standalone (unattached) item.
/obj/item/laser_sight/process(seconds_per_tick)
	if(!saved_rainbow)
		STOP_PROCESSING(SSfastprocess, src)
		return
	saved_rainbow_hue = (saved_rainbow_hue + 10) % 360
	update_appearance()


/// Attempt to attach the sight to another item via non-combat tool interaction.
/// interact_with_atom fires for items on the floor, in hand, and in containers — unlike afterattack.
/obj/item/laser_sight/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isitem(interacting_with))
		return NONE
	var/obj/item/target_item = interacting_with
	if(target_item == src)
		return NONE
	// Blacklist: items where a laser sight makes no sense or can't be detached.
	if(istype(target_item, /obj/item/storage/backpack) || istype(target_item, /obj/item/mod/module/))
		balloon_alert(user, "doesn't fit")
		return ITEM_INTERACT_BLOCKING
	if(target_item.GetComponent(/datum/component/laser_sight))
		balloon_alert(user, "already has a laser sight")
		return ITEM_INTERACT_BLOCKING
	target_item.AddComponent(/datum/component/laser_sight, saved_color, saved_is_syndicate)
	if(saved_rainbow)
		var/datum/component/laser_sight/comp = target_item.GetComponent(/datum/component/laser_sight)
		if(comp)
			comp.rainbow_mode = TRUE
	playsound(user, 'sound/machines/click.ogg', 50, TRUE)
	balloon_alert(user, "attached")
	qdel(src)
	return ITEM_INTERACT_SUCCESS


/obj/item/laser_sight/attackby(obj/item/tool, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(tool, /obj/item/multitool))
		INVOKE_ASYNC(src, PROC_REF(standalone_change_color), user)
		return
	return ..()


/obj/item/laser_sight/proc/standalone_change_color(mob/user)
	var/mode = tgui_alert(user, "Pick a beam colour method.", "Laser Sight", list("Colour Wheel", "Manual Input", "Cancel"))
	if(isnull(mode) || mode == "Cancel" || QDELETED(src))
		return

	if(mode == "Colour Wheel")
		var/picked = tgui_color_picker(user, "Choose beam colour.", "Laser Sight Colour", saved_color)
		if(isnull(picked) || QDELETED(src))
			return
		saved_rainbow = FALSE
		saved_color = picked
		update_appearance()
		balloon_alert(user, "colour set to [picked]")
		return

	var/input = tgui_input_text(user, "Enter a hex colour or a special code.", "Laser Sight Colour", default = saved_color, max_length = 16)
	if(isnull(input) || QDELETED(src))
		return
	if(LOWER_TEXT(input) == "fabulousputin")
		saved_rainbow = !saved_rainbow
		if(saved_rainbow)
			START_PROCESSING(SSfastprocess, src)
			to_chat(user, span_warning("RNBW_ENGAGE"))
		else
			STOP_PROCESSING(SSfastprocess, src)
			update_appearance()
		return
	saved_rainbow = FALSE
	var/hex = sanitize_hexcolor(input, desired_format = 6, include_crunch = TRUE)
	if(!hex)
		balloon_alert(user, "invalid colour")
		return
	saved_color = hex
	update_appearance()
	balloon_alert(user, "colour set to [hex]")


// ---- Syndicate subtype ----

/obj/item/laser_sight/syndicate
	name = "advanced tactical laser sight"
	desc = "A Cybersun Industries black-market grade tactical laser sight module, precision-calibrated for improved accuracy. \
			Use a <b>screwdriver</b> to detach."
	icon_state = "laser_sight"
	saved_color = "#8B0000"
	saved_is_syndicate = TRUE


// ---- Tracer subtype declared in component file; nothing extra needed here ----


/// Standalone version of the HoxHud hue cycle proc, used by unattached item rainbow mode.
/proc/laser_sight_standalone_hue_to_rgb(hue)
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


// ===============================================================
//  Loadout: Toys
// ===============================================================

/datum/loadout_item/toys/laser_sight
	name = "Laser Sight"
	group = "Tactical Toys"
	item_path = /obj/item/laser_sight


// ===============================================================
//  Cargo: Security (no access requirement — not dangerous on its own)
// ===============================================================

/datum/supply_pack/goody/laser_sight_single
	name = "Laser Sight"
	desc = "A Cybersun Industries tactical laser sight module. Adheres to any item."
	cost = PAYCHECK_CREW * 1
	crate_name = "laser sight"
	contains = list(/obj/item/laser_sight)


/datum/supply_pack/security/laser_sight_team
	name = "Laser Sight Team Pack (×6)"
	desc = "Six Cybersun Industries tactical laser sight modules. Enough to equip a full security response team."
	cost = PAYCHECK_CREW * 5
	crate_name = "laser sight team crate"
	contains = list(/obj/item/laser_sight = 6)


// ===============================================================
//  Uplink: Syndicate version
// ===============================================================

/datum/uplink_item/device_tools/laser_sight_syndie
	name = "Advanced Tactical Laser Sight"
	desc = "A black-market Cybersun precision laser sight, calibrated for a more significant accuracy improvement than the standard unit."
	item = /obj/item/laser_sight/syndicate
	cost = 1
	surplus = 60
	uplink_item_flags = SYNDIE_ILLEGAL_TECH | SYNDIE_TRIPS_CONTRABAND
