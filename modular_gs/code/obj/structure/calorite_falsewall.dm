/obj/structure/falsewall/calorite            //GS13
	name = "calorite wall"
	desc = "A wall with calorite plating. Burp."
	icon = 'modular_gs/icons/turf/false_walls.dmi'
	fake_icon = 'modular_gs/icons/turf/calorite_wall.dmi'
	icon_state = "calorite_wall-open"
	base_icon_state = "calorite_wall"
	mineral = /obj/item/stack/sheet/mineral/calorite
	walltype = /turf/closed/wall/mineral/calorite
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_CALORITE_WALL + SMOOTH_GROUP_WALLS
	canSmoothWith = SMOOTH_GROUP_CALORITE_WALL
	var/active = null
	var/last_event = 0

/obj/structure/falsewall/calorite/proc/fatten()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/carbon/human/M in orange(3,src))
				M.adjust_fatness(30, FATTENING_TYPE_ITEM)
			last_event = world.time
			active = null
			return
	return

/obj/structure/falsewall/calorite/Bumped(atom/movable/AM)
	fatten()
	..()

/obj/structure/falsewall/calorite/attackby(obj/item/W, mob/user, params)
	fatten()
	return ..()

/obj/structure/falsewall/calorite/attack_hand(mob/user)
	fatten()
	. = ..()