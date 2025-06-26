/turf/closed/wall/mineral/calorite //GS13
	name = "calorite wall"
	desc = "A wall with calorite plating. Burp."
	icon = 'modular_gs/icons/turf/calorite_wall.dmi'
	// icon_state = "calorite"
	icon_state = "calorite-0"
	base_icon_state = "calorite"
	sheet_type = /obj/item/stack/sheet/mineral/calorite
	canSmoothWith = list(/turf/closed/wall/mineral/calorite, /obj/structure/falsewall/calorite)
	var/active = null
	var/last_event = 0

/turf/closed/wall/mineral/calorite/proc/fatten()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/carbon/human/M in orange(3,src))
				M.adjust_fatness(30, FATTENING_TYPE_ITEM)
			last_event = world.time
			active = null
			return
	return

/turf/closed/wall/mineral/calorite/Bumped(atom/movable/AM)
	fatten()
	..()

/turf/closed/wall/mineral/calorite/attackby(obj/item/W, mob/user, params)
	fatten()
	return ..()

/turf/closed/wall/mineral/calorite/attack_hand(mob/user)
	fatten()
	. = ..()