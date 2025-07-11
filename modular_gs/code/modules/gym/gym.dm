/obj/item/dumbbell
	desc = "A weighty dumbbell, perfect for arm exercise!"
	name = "dumbbell"
	icon = 'modular_gs/icons/obj/dumbbell.dmi'
	icon_state = "pen"
	throwforce = 20
	w_class = WEIGHT_CLASS_BULKY
	throw_speed = 2
	throw_range = 3
	custom_materials = list(/datum/material/iron=10)
	pressure_resistance = 2
	var/reps = 0
	var/using = FALSE

/obj/item/dumbbell/dropped(mob/user, silent)
	reps = 0
	. = ..()

/obj/item/dumbbell/attack_self(mob/user)
	. = ..()
	if(!using)
		using = TRUE
		to_chat(user, "<span>You do a rep with the [src]. YEEEEEAH!!!</span>")
		if(do_after(usr, CLICK_CD_RESIST-reps, 0, usr, 1))
			if(iscarbon(user))
				var/mob/living/carbon/U = user
				U.adjust_fatness(-10, FATTENING_TYPE_WEIGHT_LOSS)
			if(reps < 16)
				reps += 0.4
		else
			to_chat(user, "<span>You couldn't complete the rep. YOU'LL GET IT NEXT TIME CHAMP!!!</span>")
		using = FALSE

/obj/machinery/treadmill
	name = "treadmill"
	desc = "A treadmil, for losing weight!"
	icon = 'icons/obj/recycling.dmi'
	icon_state = "conveyor0"
	circuit = /obj/item/circuitboard/machine/treadmill

	var/fatloss = -10

/obj/machinery/treadmill/Uncross(atom/movable/AM, atom/newloc)
	if(machine_stat & BROKEN)
		return ..()
	if(!isliving(AM))
		return ..()
	var/mob/living/M = AM
	if(M.throwing || (M.movement_type & FLOATING) || M.is_flying()) //Make sure they're not going over it
		return ..()
	if(AM.dir != dir) //Make sure they're going into the treadmill
		return ..()
	if(prob(25))
		playsound(src, "sound/machines/tractor_running.ogg", 25, TRUE, -2) //Rumblin'
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(C.fatness > FATNESS_LEVEL_BARELYMOBILE)
			if(prob(5))
				visible_message(pick(list(	//Really testing the poor thing, huh?
					"\the [src] audibly strains under [C]'s weight...",
					"\the [src] creeaaaaks under [C]'s strain..."
				)))
		C.adjust_fatness(fatloss, FATTENING_TYPE_WEIGHT_LOSS)
	flick("conveyor-1", src)
	return FALSE

/obj/machinery/treadmill/RefreshParts(obj/item/O, mob/user, params)
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		fatloss += M.rating * -10

/obj/machinery/treadmill/attackby(obj/item/O, mob/living/user, params)
	if(default_deconstruction_screwdriver(user, "conveyor0", "conveyor0", O))
		return TRUE

	if(default_deconstruction_crowbar(O))
		return TRUE

	if(default_change_direction_wrench(O))
		return TRUE

	return ..()

/obj/item/circuitboard/machine/treadmill
	name = "Treadmill (Machine Board)"
	build_path = /obj/machinery/treadmill
	req_components = list(/obj/item/stock_parts/manipulator = 1)

/datum/design/treadmill
	name = "Treadmill Board"
	id = "treadmill"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 50)
	build_path = /obj/item/circuitboard/machine/treadmill
	category = list("inital", "Construction")
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/dumbbell
	name = "Dumbbell"
	id = "dumbbell"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/dumbbell
	category = list("initial", "Tools")
/*
/datum/design/treadmill
	name = "Treadmill"
	id = "treadmill"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 5000)
	build_path = /obj/item/conveyor_construct/treadmill
	category = list("initial", "Construction")
*/
