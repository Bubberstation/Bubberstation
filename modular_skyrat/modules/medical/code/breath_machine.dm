//Credit to Beestation for the original anesthetic machine code: https://github.com/BeeStation/BeeStation-Hornet/pull/3753

/obj/structure/closet/secure_closet/medical2/Initialize(mapload)
	. = ..()
	new /obj/machinery/breath_machine/anesthetic(loc)
	new /obj/machinery/breath_machine/anesthetic(loc)
	qdel(src)

/obj/machinery/breath_machine
	name = "portable breath machine"
	desc = "A stand on wheels with a digital regulator, similar to an IV drip, that can hold a canister of gas along with a gas mask.<br>Is it N2 for humans and N2O for vox again? Other way? What's O2? I'm not the doctor here."
	icon = 'modular_zubbers/icons/obj/medical/breath_machine.dmi'
	icon_state = "breath_machine"
	anchored = FALSE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	use_power = NO_POWER_USE
	/// The mask attached to the breath machine
	var/obj/item/clothing/mask/breath/machine/attached_mask
	/// the tank attached to the breath machine, by default it does not come with one.
	var/obj/item/tank/attached_tank = null
	/// Is the attached mask currently out?
	var/mask_out = FALSE

/obj/machinery/breath_machine/anesthetic
	attached_tank = new /obj/item/tank/internals/anesthetic

/obj/machinery/breath_machine/examine(mob/user)
	. = ..()

	. += "<b>Right-clicking</b> with a wrench will deconstruct the stand, if there is no tank attached."
	if(mask_out)
		. += "<b>Click</b> on the stand to retract the mask, if the mask is currently out"
	if(attached_tank)
		. += "<b>Alt + Click</b> to remove [attached_tank]."

/obj/machinery/breath_machine/Initialize(mapload)
	. = ..()
	attached_mask = new /obj/item/clothing/mask/breath/machine(src)
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/breath_machine/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return ..()

	if(mask_out)
		to_chat(user, span_warning("There is someone currently attached to the [src]!"))
		return TRUE

	if(attached_tank)
		to_chat(user, span_warning("[attached_tank] must be removed from [src] first!"))
		return TRUE

	new /obj/item/breath_machine_kit(get_turf(src))
	tool.play_tool_sound(user)
	to_chat(user, span_notice("You deconstruct the [src]."))
	qdel(src)
	return TRUE

/obj/machinery/breath_machine/update_overlays()
	. = ..()
	var/static/generic_overlay
	var/static/anesthetic_overlay
	var/static/oxygen_overlay
	var/static/nitrogen_overlay
	var/static/on_overlay
	var/static/off_overlay
	if(isnull(generic_overlay))
		generic_overlay = iconstate2appearance(icon, "tank_generic")
		anesthetic_overlay = iconstate2appearance(icon, "tank_anesthetic")
		oxygen_overlay = iconstate2appearance(icon, "tank_oxygen")
		nitrogen_overlay = iconstate2appearance(icon, "tank_nitrogen")
		on_overlay = iconstate2appearance(icon, "mask_on")
		off_overlay = iconstate2appearance(icon, "mask_off")

	cut_overlays()

	if(attached_tank)
		if(istype(attached_tank, /obj/item/tank/internals/anesthetic))
			add_overlay(anesthetic_overlay)
		else if(istype(attached_tank, /obj/item/tank/internals/oxygen))
			add_overlay(oxygen_overlay)
		else if(istype(attached_tank, /obj/item/tank/internals/nitrogen))
			add_overlay(nitrogen_overlay)
		else
			add_overlay(generic_overlay)

	if(mask_out)
		add_overlay(off_overlay)
	else
		add_overlay(on_overlay)

/obj/machinery/breath_machine/attack_hand(mob/living/user)
	. = ..()
	if(!retract_mask())
		return FALSE
	visible_message(span_notice("[user] retracts [attached_mask] back into [src]."))

/obj/machinery/breath_machine/attackby(obj/item/attacking_item, mob/user, params)
	if(!istype(attacking_item, /obj/item/tank))
		return ..()

	if(attached_tank) // If there is an attached tank, remove it and drop it on the floor
		attached_tank.forceMove(loc)

	attacking_item.forceMove(src) // Put new tank in, set it as attached tank
	visible_message(span_notice("[user] inserts [attacking_item] into [src]."))
	attached_tank = attacking_item
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/breath_machine/click_alt(mob/user)
	if(!attached_tank)
		return CLICK_ACTION_BLOCKING

	attached_tank.forceMove(loc)
	to_chat(user, span_notice("You remove the [attached_tank]."))
	attached_tank = null
	update_appearance(UPDATE_OVERLAYS)
	if(mask_out)
		retract_mask()
	return CLICK_ACTION_SUCCESS

///Retracts the attached_mask back into the machine
/obj/machinery/breath_machine/proc/retract_mask()
	if(!mask_out)
		return FALSE

	if(iscarbon(attached_mask.loc)) // If mask is on a mob
		var/mob/living/carbon/attached_mob = attached_mask.loc
		// Close external air tank
		if (attached_mob.external)
			attached_mob.close_externals()
		attached_mob.transferItemToLoc(attached_mask, src, TRUE)
	else
		attached_mask.forceMove(src)

	mask_out = FALSE
	update_appearance(UPDATE_OVERLAYS)
	return TRUE

/obj/machinery/breath_machine/mouse_drop_dragged(mob/living/carbon/target, mob/user, src_location, over_location, params)
	. = ..()
	if(!istype(target))
		return

	if((!Adjacent(target)) || !(user.Adjacent(target)))
		return FALSE

	if(!attached_tank || mask_out)
		to_chat(user, span_warning("[mask_out ? "The machine is already in use!" : "The machine has no attached tank!"]"))
		return FALSE

	// if we somehow lost the mask, let's just make a brand new one. the wonders of technology!
	if(QDELETED(attached_mask))
		attached_mask = new /obj/item/clothing/mask/breath/machine(src)
		update_appearance(UPDATE_OVERLAYS)

	user.visible_message(span_warning("[user] attemps to attach the [attached_mask] to [target]."), span_notice("You attempt to attach the [attached_mask] to [target]"))
	if(!do_after(user, 5 SECONDS, target))
		return
	if(!target.equip_to_appropriate_slot(attached_mask))
		to_chat(user, span_warning("You are unable to attach the [attached_mask] to [target]!"))
		return

	user.visible_message(span_warning("[user] attaches the [attached_mask] to [target]."), span_notice("You attach the [attached_mask] to [target]"))

	// Open the tank externally
	target.open_internals(attached_tank, is_external = TRUE)
	mask_out = TRUE
	START_PROCESSING(SSmachines, src)
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/breath_machine/process()
	if(!mask_out) // If not on someone, stop processing
		return PROCESS_KILL

	var/mob/living/carbon/carbon_target = attached_mask.loc
	if(get_dist(src, get_turf(attached_mask)) > 1) // If too far away, detach
		to_chat(carbon_target, span_warning("[attached_mask] is ripped off of your face!"))
		retract_mask()
		return PROCESS_KILL

	// Attempt to restart airflow if it was temporarily interrupted after mask adjustment.
	if(attached_tank && istype(carbon_target) && !carbon_target.external && !attached_mask.up)
		carbon_target.open_internals(attached_tank, is_external = TRUE)

/obj/machinery/breath_machine/Destroy()
	if(mask_out)
		retract_mask()

	if(attached_tank)
		attached_tank.forceMove(loc)
		attached_tank = null

	QDEL_NULL(attached_mask)
	return ..()

/// This a special version of the breath mask used for the breath machine.
/obj/item/clothing/mask/breath/machine
	/// What machine is the mask currently attached to?
	var/datum/weakref/attached_machine

/obj/item/clothing/mask/breath/machine/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

	// Make sure we are not spawning outside of a machine
	if(istype(loc, /obj/machinery/breath_machine))
		attached_machine = WEAKREF(loc)

	var/obj/machinery/breath_machine/our_machine
	if(attached_machine)
		our_machine = attached_machine.resolve()

	if(!our_machine)
		attached_machine = null
		if(mapload)
			stack_trace("Abstract, undroppable item [name] spawned at ([loc]) at [AREACOORD(src)] in \the [get_area(src)]. \
				Please remove it. This item should only ever be created by the breath machine.")
		return INITIALIZE_HINT_QDEL

/obj/item/clothing/mask/breath/machine/Destroy()
	attached_machine = null
	return ..()

/obj/item/clothing/mask/breath/machine/dropped(mob/user)
	. = ..()

	if(isnull(attached_machine))
		return

	var/obj/machinery/breath_machine/our_machine = attached_machine.resolve()
	// no machine, then delete it
	if(!our_machine)
		attached_machine = null
		qdel(src)
		return

	if(loc != our_machine) //If it isn't in the machine, then it retracts when dropped
		to_chat(user, span_notice("[src] retracts back into the [our_machine]."))
		our_machine.retract_mask()

/obj/item/clothing/mask/breath/machine/adjust_visor(mob/living/carbon/user)
	. = ..()
	// Air only goes through the mask, so temporarily pause airflow if mask is getting adjusted.
	// Since the mask is NODROP, the only possible user is the wearer
	var/mob/living/carbon/carbon_target = loc
	if(up && carbon_target.external)
		carbon_target.close_externals()

/// A boxed version of the breath Machine. This is what is printed from the medical prolathe.
/obj/item/breath_machine_kit
	name = "breath stand parts kit"
	desc = "Contains all of the parts needed to assemble a portable breath stand. Use in hand to construct."
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/storage/box.dmi'
	icon_state = "plasticbox"

/obj/item/breath_machine_kit/attack_self(mob/user)
	new /obj/machinery/breath_machine(user.loc)

	playsound(get_turf(user), 'sound/items/weapons/circsawhit.ogg', 50, TRUE)
	qdel(src)
