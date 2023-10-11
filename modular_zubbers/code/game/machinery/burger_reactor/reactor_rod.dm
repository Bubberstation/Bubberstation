/obj/item/tank/rbmk2_rod
	name = "\improper RB-MK2 reactor rod"
	desc = "A rod for the RB-MK2 reactor. Usually filled with tritium."
	icon = 'modular_zubbers/icons/obj/equipment/burger_reactor.dmi'
	icon_state = "platform_rod"
	inhand_icon_state = null
	pixel_y = -16
	worn_icon_state = null
	tank_holder_icon_state = null
	flags_1 = CONDUCT_1
	slot_flags = null //they have no straps!
	force = 8

/obj/item/tank/rbmk2_rod/preloaded/populate_gas()
	air_contents.assert_gas(/datum/gas/tritium)
	air_contents.assert_gas(/datum/gas/water_vapor)
	air_contents.gases[/datum/gas/tritium][MOLES] = 60
	air_contents.gases[/datum/gas/water_vapor][MOLES] = 10

/obj/item/tank/rbmk2_rod/atom_destruction(damage_flag)

	if(!loc || !istype(loc,/obj/machinery/power/rbmk2))
		return ..()

	var/obj/machinery/power/rbmk2/M = loc
	M.stored_rod = null
	M.active = FALSE
	M.jammed = FALSE
	src.forceMove(get_turf(M))
	radiation_pulse(M,min(M.last_tritium_consumption*100,GAS_REACTION_MAXIMUM_RADIATION_PULSE_RANGE),threshold = RAD_FULL_INSULATION)
	var/explosion_strength = min(M.last_tritium_consumption*5,10)
	explosion(M, devastation_range = 1 + explosion_strength*0.1, heavy_impact_range = 1 + explosion_strength*0.2, light_impact_range = 3 + explosion_strength*0.5, flash_range = 4 + explosion_strength)
	. = ..()
	if(!QDELETED(M))
		qdel(M) //Don't know why it'd live after this, but just in case.
