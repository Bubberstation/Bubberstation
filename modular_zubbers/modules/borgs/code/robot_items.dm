/**
 * Cargoborg specific items
 *
 * Refer to modular_skyrat/modules/cargoborg/code/robot_items.dm for original definitions
 */

// Override the mail clamp to be able to dispense into mail chutes
/obj/item/borg/hydraulic_clamp/mail/pre_attack(atom/attacked_atom, mob/living/silicon/robot/user, params)
	var/obj/machinery/disposal/delivery_chute/chute = attacked_atom
	if(istype(attacked_atom, /obj/structure/plasticflaps))	// If we attacked flaps, try locating the chute under them
		var/obj/structure/plasticflaps/flaps = attacked_atom
		chute = locate(/obj/machinery/disposal/delivery_chute) in flaps.loc.contents
	if(!istype(chute))	// This is one way to say we didn't attack a chute or flaps over a chute
		return ..()

	if(!istype(user) || !user.Adjacent(attacked_atom) || !COOLDOWN_FINISHED(src, clamp_cooldown) || in_use)
		return

	// Not enough charge
	if(user?.cell.charge < charge_cost)
		balloon_alert(user, "low charge!")
		return

	user.cell.use(charge_cost)
	in_use = TRUE
	COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

	if(!contents.len)
		in_use = FALSE
		return

	var/extraction_index = selected_item_index ? selected_item_index : contents.len
	var/atom/movable/extracted_item = contents[extraction_index]
	selected_item_index = 0

	if (unloading_time > 0.5 SECONDS) // Chat spam reduction
		balloon_alert(user, "unloading")
	playsound(src, clamp_sound, clamp_sound_volume, FALSE, -5)
	COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

	if(!do_after(user, unloading_time, attacked_atom))
		in_use = FALSE
		return

	chute.place_item_in_disposal(extracted_item)
	visible_message(span_notice("[src.loc] unloads [extracted_item] from [src]."))
	log_silicon("[user] unloaded [extracted_item] onto [chute] ([AREACOORD(chute)]).")
	in_use = FALSE
	return
/**
 * Cargoborg specific items
 *
 * Refer to modular_skyrat/modules/cargoborg/code/robot_items.dm for original definitions
 */

// Override the mail clamp to be able to dispense into mail chutes
/obj/item/borg/hydraulic_clamp/mail/pre_attack(atom/attacked_atom, mob/living/silicon/robot/user, params)
	var/obj/machinery/disposal/delivery_chute/chute = attacked_atom
	if(istype(attacked_atom, /obj/structure/plasticflaps))	// If we attacked flaps, try locating the chute under them
		var/obj/structure/plasticflaps/flaps = attacked_atom
		chute = locate(/obj/machinery/disposal/delivery_chute) in flaps.loc.contents
	if(!istype(chute))	// This is one way to say we didn't attack a chute or flaps over a chute
		return ..()

	if(!istype(user) || !user.Adjacent(attacked_atom) || !COOLDOWN_FINISHED(src, clamp_cooldown) || in_use)
		return

	// Not enough charge
	if(user?.cell.charge < charge_cost)
		balloon_alert(user, "low charge!")
		return

	user.cell.use(charge_cost)
	in_use = TRUE
	COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

	if(!contents.len)
		in_use = FALSE
		return

	var/extraction_index = selected_item_index ? selected_item_index : contents.len
	var/atom/movable/extracted_item = contents[extraction_index]
	selected_item_index = 0

	if (unloading_time > 0.5 SECONDS) // Chat spam reduction
		balloon_alert(user, "unloading")
	playsound(src, clamp_sound, clamp_sound_volume, FALSE, -5)
	COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

	if(!do_after(user, unloading_time, attacked_atom))
		in_use = FALSE
		return

	chute.place_item_in_disposal(extracted_item)
	visible_message(span_notice("[src.loc] unloads [extracted_item] from [src]."))
	log_silicon("[user] unloaded [extracted_item] onto [chute] ([AREACOORD(chute)]).")
	in_use = FALSE
	return


/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg
	max_mod_capacity = 100

//Research borg stuff
/obj/item/inducer/cyborg/sci
	icon = 'icons/obj/tools.dmi'
	icon_state = "inducer-sci"

//TODO: Get this actualy working
//Personal shielding for the combat module.
/obj/item/borg/combat/shield
	name = "personal shielding"
	desc = "A powerful experimental module that turns aside or absorbs incoming attacks at the cost of charge."
	icon = 'icons/obj/signs.dmi'
	icon_state = "shock"
	var/shield_level = 0.5			//Percentage of damage absorbed by the shield.
	var/active = 1					//If the shield is on
	var/flash_count = 0				//Counter for how many times the shield has been flashed
	var/overload_threshold = 3		//Number of flashes it takes to overload the shield
	var/shield_refresh = 15 SECONDS	//Time it takes for the shield to reboot after destabilizing
	var/overload_time = 0			//Stores the time of overload
	var/last_flash = 0				//Stores the time of last flash

/obj/item/borg/combat/shield/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/borg/combat/shield/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/borg/combat/shield/attack_self(mob/user)
	. = ..()
	if(.)
		return
	set_shield_level()

/obj/item/borg/combat/shield/process(delta_time)
	if(active)
		if(flash_count && (last_flash + shield_refresh < world.time))
			flash_count = 0
			last_flash = 0
	else if(overload_time + shield_refresh < world.time)
		active = 1
		flash_count = 0
		overload_time = 0

		var/mob/living/user = src.loc
		user.visible_message("<span class='danger'>[user]'s shield reactivates!</span>", "<span class='danger'>Your shield reactivates!.</span>")
		user.update_icon()

/obj/item/borg/combat/shield/proc/adjust_flash_count(var/mob/living/user, amount)
	if(active)			//Can't destabilize a shield that's not on
		flash_count += amount

		if(amount > 0)
			last_flash = world.time
			if(flash_count >= overload_threshold)
				overload(user)

/obj/item/borg/combat/shield/proc/overload(var/mob/living/user)
	active = 0
	user.visible_message("<span class='danger'>[user]'s shield destabilizes!</span>", "<span class='danger'>Your shield destabilizes!.</span>")
	user.update_icon()
	overload_time = world.time

/obj/item/borg/combat/shield/verb/set_shield_level()
	set name = "Set shield level"
	set category = "Object"
	set src in range(0)

	var/N = input("How much damage should the shield absorb?") in list("10","20","30","40","50","60")
	if (N)
		shield_level = text2num(N)/100

//This is used to unlock other borg covers.
/obj/item/card/robot //This is not a child of id cards, as to avoid dumb typechecks on computers.
	name = "access code transmission device"
	icon_state = "data_1"
	desc = "A circuit grafted onto the bottom of an ID card.  It is used to transmit access codes into other robot chassis, \
	allowing you to lock and unlock other robots' panels."

	var/dummy_card = null
	var/dummy_card_type = /obj/item/card/id/science/roboticist/dummy_cyborg

/obj/item/card/robot/Initialize(mapload)
	. = ..()
	dummy_card = new dummy_card_type(src)

/obj/item/card/robot/Destroy()
	qdel(dummy_card)
	dummy_card = null
	..()

/obj/item/card/robot/GetID()
	return dummy_card


