/*
	MICRO GENERATOR REPLICA
*/
/obj/item/scrap/micro_generator
	icon_state = "micro_generator"
	name = "\improper NTHI generator replica"
	desc = "A micro-sized replica of the generators the Power Recovery team work with. With real fuel-loading action!"
	force = 5
	pickup_sound = 'sound/items/handling/materials/metal_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/metal_drop.ogg'
	/// Has this generator become active?
	var/active = FALSE
	/// How much fuel have we inserted?
	var/inserted_fuel = 0
	/// Do we have a piece of fuel attached?
	var/attached_fuel = FALSE
	/// Do we have a battery attached?
	var/attached_battery = FALSE
	/// Soundloop for this generator
	var/datum/looping_sound/generator/soundloop
	/// Path to the fuel type for this generator.
	var/fuel_path = /obj/item/scrap/plasilicate_fuel_replica
	/// Path to the battery type for this generator.
	var/battery_path = /obj/item/scrap/battery_replica

/obj/item/scrap/micro_generator/randomize_credit_cost()
	return rand(33, 99)

/obj/item/scrap/micro_generator/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_unwielded = 5, force_wielded = 5)
	soundloop = new(src, active)
	set_light(1, 0.75, NONSENSICAL_VALUE)

/obj/item/scrap/micro_generator/Destroy(force)
	QDEL_NULL(soundloop)
	return ..()


/obj/item/scrap/micro_generator/examine(mob/user)
	. = ..()
	if(inserted_fuel < 4)
		. += span_warning("Looks like it needs more fuel...")
	if(attached_fuel)
		. += span_notice("It has a piece of fuel attached; ready to be inserted.")
		. += span_notice("Use the generator in-hand to insert it.")
	if(attached_battery)
		. += span_notice("It has a battery attached.")
	else
		. += span_warning("It's missing it's battery...")
	if(inserted_fuel >= 4 && attached_battery && !active) // Inserted the battery last; laugh at they
		. += span_warning("Someone needs to kickstart it... maybe there's something to pull?")
	if(active)
		. += span_notice("This generator's active - honest work has been achieved.")


/obj/item/scrap/micro_generator/update_overlays()
	. = ..()
	if(attached_fuel)
		. += "micro_generator-fuel"
	if(attached_battery)
		. += "micro_generator-battery"
	if(active)
		. += "micro_generator-on"


/obj/item/scrap/micro_generator/attackby(obj/item/O, mob/user, params)
	if(istype(O, fuel_path) && attached_fuel == FALSE && inserted_fuel < 4)
		qdel(O)
		balloon_alert_to_viewers("Fuel Attached")
		attached_fuel = TRUE
		playsound(src, 'sound/items/handling/gas_tank/gas_tank_drop.ogg', 75)
	else if(istype(O, battery_path) && attached_battery == FALSE)
		qdel(O)
		balloon_alert_to_viewers("Battery Attached")
		attached_battery = TRUE
		playsound(src, 'sound/items/baton/stun_baton_inactive_drop.ogg', 75)
	update_appearance()

/obj/item/scrap/micro_generator/attack_self(mob/living/user, list/modifiers)
	if(!user)
		return
	insertfuel(user)
	if(inserted_fuel >= 4 && attached_battery && !active) // TURN ON THE LIGHTS!!
		active = TRUE
		soundloop.start()
		set_light(2, 0.75, LIGHT_COLOR_INTENSE_RED)
		vend_reward()
	update_appearance()

/obj/item/scrap/micro_generator/proc/insertfuel(mob/living/user)
	if(attached_fuel)
		playsound(src, 'sound/vehicles/mecha/hydraulic.ogg', 25)
		balloon_alert_to_viewers("Inserting Fuel...")
		if(do_after(user, 10 SECONDS, src))
			attached_fuel = 0
			balloon_alert_to_viewers("Fuel Inserted")
			inserted_fuel += 1
			playsound(src, 'sound/items/handling/gas_tank/gas_tank_drop.ogg', 100)
			if(inserted_fuel < 4 && attached_battery) /// Loaded battery; but not enough fuel
				playsound(src, 'sound/machines/generator/generator_end.ogg', 100)

/obj/item/scrap/micro_generator/proc/vend_reward()
	var/list/possible_rewards = /obj/item/scrap_chunk::tier2_reward
	possible_rewards |= /obj/item/scrap_chunk::tier3_reward
	for(var/i in 1 to 3)
		var/picked_reward = pick_n_take(possible_rewards)
		new picked_reward(get_turf(src))
	visible_message(span_notice("The [src] swings open a compartment; releasing a reward!"))
	playsound(src, pick(list('sound/machines/coindrop.ogg', 'sound/machines/coindrop2.ogg')), 40, TRUE)

/*
	Plasilicate-Wrapped Fuel Replica
*/
/obj/item/scrap/plasilicate_fuel_replica
	icon_state = "plasilicate_fuel_replica"
	name = "plasilicate-wrapped fuel replica"
	desc = "A micro-sized replica of the fuel the Power Recovery team work with. Thankfully; not as bulky as the real thing." // Not two-handed
	pickup_sound = /obj/item/stack/sheet/mineral/plasma::pickup_sound
	drop_sound = /obj/item/stack/sheet/mineral/plasma::drop_sound

/obj/item/scrap/plasilicate_fuel_replica/randomize_credit_cost()
	return rand(1, 15)

/*
	Double-Wrapped Battery Replica
*/
/obj/item/scrap/battery_replica
	icon_state = "doublewrapped_battery_replica"
	name = "double-wrapped lead-acid battery replica"
	desc = "A micro-sized replica of the battery the Power Recovery team work with. Almost certainly doesn't actually hold a charge."
	pickup_sound = /obj/item/stock_parts/power_store/cell/lead::pickup_sound
	drop_sound = /obj/item/stock_parts/power_store/cell/lead::drop_sound

/obj/item/scrap/battery_replica/randomize_credit_cost()
	return rand(1, 15)
