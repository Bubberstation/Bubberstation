/mob/living/basic/bot/firebot
	desc = "A little fire extinguishing bot. He looks rather anxious. Giving him a piece of <b>hot ice</b> would be quite an upgrade."

/mob/living/basic/bot/firebot/hotice_upgrade
	desc = "A little fire extinguishing bot. Looks like he's holding a piece of <b>hot ice</b>! His foam will bring air temperature toward 20C."
	light_color = "#8cdeff"

/mob/living/basic/bot/firebot/hotice_upgrade/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return (exposed_temperature > FIREBOT_HOTICE_TLV_TEMP_WARN_MAX || exposed_temperature < FIREBOT_HOTICE_TLV_TEMP_WARN_MIN)

/mob/living/basic/bot/firebot/hotice_upgrade/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	if(!COOLDOWN_FINISHED(src, foam_cooldown))
		return
	var/datum/effect_system/fluid_spread/foam/firefighting_freon/foam = new
	foam.set_up(5, holder = src, location = loc)
	foam.start()

	COOLDOWN_START(src, foam_cooldown, 8 SECONDS)

/mob/living/basic/bot/firebot/hotice_upgrade/update_overlays()
	. = ..()
	var/mutable_appearance/hot_ice = mutable_appearance('modular_zubbers/icons/mob/silicon/aibots.dmi', "firebot_hotice", BELOW_MOB_LAYER - 0.02)
	. += hot_ice

//Interaction to upgrade standard firebot by giving it hot ice
/mob/living/basic/bot/firebot/attackby(obj/item/given_item, mob/living/carbon/human/user, list/modifiers, list/attack_modifiers)
	if(!istype(given_item, /obj/item/stack/sheet/hot_ice))
		return ..()
	var/obj/item/stack/sheet/hot_ice/ice = given_item
	balloon_alert(user, "inserted")
	to_chat(user, span_warning("You give a piece of hot ice to the firebot. He seems rather happy! His foam will now bring air temperature toward 20C."))
	var/atom/movable/to_move = ice.split_stack(1)
	to_move.forceMove(src)
	src.change_mob_type(/mob/living/basic/bot/firebot/hotice_upgrade, delete_old_mob = TRUE)
	update_appearance()

// freon firefighting foam
/// A variant of firefighting foam for firebot upgrade, atop of usual plasma removal and bringing temperature down, it will also raise the temperature up to 20C and wont leave plasma stains on floor
/obj/effect/particle_effect/fluid/foam/firefighting_freon
	name = "freon firefighting foam"
	lifetime = 10 //doesn't last as long as normal foam
	allow_duplicate_results = FALSE
	slippery_foam = FALSE

/obj/effect/particle_effect/fluid/foam/firefighting_freon/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/atmos_sensitive)
	src.add_atom_colour("#00fff7", FIXED_COLOUR_PRIORITY)

/obj/effect/particle_effect/fluid/foam/firefighting_freon/process()
	..()

	var/turf/open/location = loc
	if(!istype(location))
		return

	var/obj/effect/hotspot/hotspot = locate() in location
	if(hotspot && location.air)
		QDEL_NULL(hotspot)

	var/datum/gas_mixture/air = location.air
	var/list/gases = air.gases
	if (gases[/datum/gas/plasma])
		var/scrub_amt = min(30, gases[/datum/gas/plasma][MOLES]) //Absorb some plasma
		gases[/datum/gas/plasma][MOLES] -= scrub_amt

	if (air.temperature > T20C)
		air.temperature = max(air.temperature / 2 , T20C)
	if (air.temperature < T20C)
		air.temperature = min(air.temperature * 2 , T20C)
	air.garbage_collect()
	location.air_update_turf(FALSE, FALSE)

/// A factory which produces firefighting_freon foam
/datum/effect_system/fluid_spread/foam/firefighting_freon
	effect_type = /obj/effect/particle_effect/fluid/foam/firefighting_freon
