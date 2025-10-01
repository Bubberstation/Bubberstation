//GS13 Port - stuckage code
/obj/machinery/door/airlock
	var/datum/proximity_monitor/proximity_monitor

/obj/machinery/door/airlock/Initialize(mapload)
	. = ..()
	proximity_monitor = new(src, 0, FALSE)
	proximity_monitor.set_host(src, src)

/obj/machinery/door/airlock/HasProximity(atom/movable/proximity_check_mob)
	if (!istype(proximity_check_mob, /mob/living/carbon))
		return
	
	var/mob/living/carbon/fatty = proximity_check_mob

	if (isnull(fatty.client))
		return

	if (isnull(fatty.client.prefs))
		return

	var/stuckage_weight = fatty.client.prefs.read_preference(/datum/preference/numeric/helplessness/stuckage)
	var/chance_to_get_stuck = fatty.client.prefs.read_preference(/datum/preference/numeric/helplessness/stuckage_custom)

	if (stuckage_weight == 0)
		return

	if(chance_to_get_stuck && fatty.fatness > stuckage_weight)
		if(prob(chance_to_get_stuck))
			fatty.doorstuck = 1
			fatty.visible_message("<span class'danger'>[fatty] gets stuck in the doorway!</span>")
			to_chat(fatty, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
			fatty.Stun(55, ignore_canstun = TRUE)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/machinery/door/, AsyncDoorstuckCall), fatty), 55)
		return

	if(fatty.fatness > (stuckage_weight * 2))
		if(rand(1, 3) == 1)
			fatty.doorstuck = 1
			fatty.visible_message("<span class'danger'>[fatty] gets stuck in the doorway!</span>")
			to_chat(fatty, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
			fatty.Stun(100, ignore_canstun = TRUE)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/machinery/door/, AsyncDoorstuckCall), fatty), 100)
			//sleep(100)
		return

	if(fatty.fatness > stuckage_weight)
		if(rand(1, 5) == 1)
			fatty.doorstuck = 1
			fatty.visible_message("<span class'danger'>[fatty] gets stuck in the doorway!</span>")
			to_chat(fatty, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
			fatty.Stun(55, ignore_canstun = TRUE)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/machinery/door/, AsyncDoorstuckCall), fatty), 55)
			//sleep(55)
			return
		if(rand(1, 5) == 5)
			to_chat(fatty, "<span class='danger'>With great effort, you manage to squeeze your massive form through  \the [src]. It's a tight fit, but you successfully navigate the narrow opening, barely avoiding getting stuck.</span>")
			return

	if(fatty.fatness > (stuckage_weight / 2))
		if(rand(1, 5) == 1)
			fatty.visible_message("<span class'danger'>[fatty]'s hips brush against the doorway...</span>")
			to_chat(fatty, "<span class='danger'>As you pass through  \the [src], you feel a slight brushing against your hips. The [src] frame accommodates your form, but it's a close fit..</span>")
			return

	return

// /obj/machinery/door/airlock/Crossed(mob/living/carbon/L)
// 	if(!istype(L))
// 		return ..()

// 	var/stuckage_weight = L?.client?.prefs?.stuckage
// 	if(isnull(stuckage_weight) || (stuckage_weight < 10))
// 		return ..() // They aren't able to get stuck

// 	var/chance_to_get_stuck = L?.client?.prefs?.stuckage_chance * 100
// 	if(chance_to_get_stuck && L.fatness > stuckage_weight)
// 		if(prob(chance_to_get_stuck))
// 			L.doorstuck = 1
// 			L.visible_message("<span class'danger'>[L] gets stuck in the doorway!</span>")
// 			to_chat(L, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
// 			L.Stun(55, updating = TRUE, ignore_canstun = TRUE)
// 			addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/machinery/door/airlock/, AsyncDoorstuckCall), L), 55)
// 		return ..()


// 	if(L.fatness > (stuckage_weight * 2))
// 		if(rand(1, 3) == 1)
// 			L.doorstuck = 1
// 			L.visible_message("<span class'danger'>[L] gets stuck in the doorway!</span>")
// 			to_chat(L, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
// 			L.Stun(100, updating = TRUE, ignore_canstun = TRUE)
// 			addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/machinery/door/airlock/, AsyncDoorstuckCall), L), 100)
// 			//sleep(100)
// 		return ..()

// 	else if(L.fatness > stuckage_weight)
// 		if(rand(1, 5) == 1)
// 			L.doorstuck = 1
// 			L.visible_message("<span class'danger'>[L] gets stuck in the doorway!</span>")
// 			to_chat(L, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
// 			L.Stun(55, updating = TRUE, ignore_canstun = TRUE)
// 			addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/machinery/door/airlock/, AsyncDoorstuckCall), L), 55)
// 			//sleep(55)
// 			return ..()
// 		if(rand(1, 5) == 5)
// 			to_chat(L, "<span class='danger'>With great effort, you manage to squeeze your massive form through  \the [src]. It's a tight fit, but you successfully navigate the narrow opening, barely avoiding getting stuck.</span>")
// 			return ..()

// 	else if(L.fatness > (stuckage_weight / 2))
// 		if(rand(1, 5) == 1)
// 			L.visible_message("<span class'danger'>[L]'s hips brush against the doorway...</span>")
// 			to_chat(L, "<span class='danger'>As you pass through  \the [src], you feel a slight brushing against your hips. The [src] frame accommodates your form, but it's a close fit..</span>")
// 			return ..()

// 	return ..()
/*
/obj/structure/mineral_door/Crossed(mob/living/carbon/L)
	if(!istype(L))
		return ..()

	var/stuckage_weight = L?.client?.prefs?.stuckage
	if(isnull(stuckage_weight) || (stuckage_weight < 10))
		return ..() // They aren't able to get stuck

	if(L.fatness > (stuckage_weight * 2))
		if(rand(1, 3) == 1)
			L.doorstuck = 1
			L.visible_message("<span class'danger'>[L] gets stuck in the doorway!</span>")
			to_chat(L, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
			L.Stun(100, updating = TRUE, ignore_canstun = TRUE)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/structure/mineral_door/, AsyncDoorstuckCall), L), 100)
			//sleep(100)
		return ..()

	else if(L.fatness > stuckage_weight)
		if(rand(1, 5) == 1)
			L.doorstuck = 1
			L.visible_message("<span class'danger'>[L] gets stuck in the doorway!</span>")
			to_chat(L, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
			L.Stun(55, updating = TRUE, ignore_canstun = TRUE)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/structure/mineral_door/, AsyncDoorstuckCall), L), 55)
			//sleep(55)
			return ..()
		if(rand(1, 5) == 5)
			to_chat(L, "<span class='danger'>With great effort, you manage to squeeze your massive form through  \the [src]. It's a tight fit, but you successfully navigate the narrow opening, barely avoiding getting stuck.</span>")
			return ..()

	else if(L.fatness > (stuckage_weight / 2))
		if(rand(1, 5) == 1)
			L.visible_message("<span class'danger'>[L]'s hips brush against the doorway...</span>")
			to_chat(L, "<span class='danger'>As you pass through  \the [src], you feel a slight brushing against your hips. The [src] frame accommodates your form, but it's a close fit..</span>")
			return ..()

	return ..()

*/
// Callback proc to replace sleep function
/obj/machinery/door/proc/AsyncDoorstuckCall(mob/living/carbon/L)
	L.doorstuck = 0
	L.Knockdown(1)

// Callback proc to replace sleep function
// /obj/structure/mineral_door/proc/AsyncDoorstuckCall(mob/living/carbon/L)
// 	L.doorstuck = 0
// 	L.Knockdown(1)
