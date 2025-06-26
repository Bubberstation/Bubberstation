/obj/structure/statue/calorite
	icon = 'modular_gs/icons/obj/statue.dmi'
	max_integrity = 400
	custom_materials = list(/datum/material/calorite = SHEET_MATERIAL_AMOUNT*5)

/obj/structure/statue/calorite/fatty
	name = "Fatty statue"
	desc = "A statue of a well-rounded fatso."
	icon_state = "fatty"
	var/active = null
	var/last_event = 0
	var/datum/proximity_monitor/proximity_monitor

/obj/structure/statue/calorite/fatty/Initialize(mapload)
	. = ..()
	proximity_monitor = new(src, 1, FALSE)
	proximity_monitor.set_host(src, src)
	// RegisterSignal(src, COMSIG_MOVABLE_CROSS, .proc/on_crossed)

/obj/structure/statue/calorite/fatty/proc/beckon()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/carbon/human/M in orange(3,src))
				to_chat(M, "<span class='warning'>You feel the statue calling to you, urging you to touch it...</span>")
			last_event = world.time
			active = null
			return
	return

/obj/structure/statue/calorite/fatty/proc/statue_fatten(mob/living/carbon/M, touch = TRUE)
	if(!M.adjust_fatness(20, FATTENING_TYPE_ITEM))
		to_chat(M, "<span class='warning'>Nothing happens.</span>")
		return

	if (!touch)
		to_chat(M, "<span class='warning'>As you bump into the statue, you feel your clothes getting tighter around you...</span>")
		return

	if(M.fatness < FATNESS_LEVEL_FATTER)
		to_chat(M, "<span class='warning'>The moment your hand meets the statue, you feel a little warmer...</span>")
	else if(M.fatness < FATNESS_LEVEL_OBESE)
		to_chat(M, "<span class='warning'>Upon each poke of the statue, you feel yourself get a little heavier.</span>")
	else if(M.fatness < FATNESS_LEVEL_EXTREMELY_OBESE)
		to_chat(M, "<span class='warning'>With each touch you keep getting fatter... But the fatter you grow, the more enticed you feel to poke the statue.</span>")
	else if(M.fatness < FATNESS_LEVEL_BARELYMOBILE)
		to_chat(M, "<span class='warning'>The world around you blur slightly as you focus on prodding the statue, your waistline widening further...</span>")
	else if(M.fatness < FATNESS_LEVEL_IMMOBILE)
		to_chat(M, "<span class='warning'>A whispering voice gently compliments your massive body, your own mind begging to touch the statue.</span>")
	else
		to_chat(M, "<span class='warning'>You can barely reach the statue past your floor-covering stomach! And yet, it still calls to you...</span>")

/obj/structure/statue/calorite/fatty/Bumped(atom/movable/AM)
	beckon()
	if(istype(AM, /mob/living/carbon))
		statue_fatten(AM, FALSE)
	..()

/obj/structure/statue/calorite/fatty/HasProximity(atom/movable/entity)
	beckon()

/obj/structure/statue/calorite/fatty/Moved(atom/movable/AM)
	beckon()
	..()

/obj/structure/statue/calorite/fatty/attackby(obj/item/W, mob/living/carbon/M, params)
	statue_fatten(M)

/obj/structure/statue/calorite/fatty/attack_hand(mob/living/carbon/M)
	statue_fatten(M)

/obj/structure/statue/calorite/fatty/attack_paw(mob/living/carbon/M)
	statue_fatten(M)