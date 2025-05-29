/// Checks if the mob is able to be teleported.
/obj/machinery/quantumpad/proc/check_mob_teleportability(mob/living/mob_to_check)
	return TRUE

/obj/machinery/quantumpad/supply_only
	name = "supply pad"
	desc = "A modified version of the quantum pad, only able to teleport supplies and livestock."
	circuit = /obj/item/circuitboard/machine/quantumpad/supply_only

/obj/machinery/quantumpad/supply_only/check_mob_teleportability(mob/living/mob_to_check)
	if(istype(mob_to_check, /mob/living/simple_animal))
		return TRUE

	return HAS_TRAIT(mob_to_check, TRAIT_LIVESTOCK)

/obj/item/circuitboard/machine/quantumpad/supply_only
	name = "Supply Pad (Machine Board)"
	build_path = /obj/machinery/quantumpad/supply_only

