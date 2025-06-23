/obj/structure/flora/ash/cacti
	can_uproot = TRUE

/obj/structure/flora/ash/cacti/uproot(mob/living/user)
	. = ..()
	qdel(GetComponent(/datum/component/caltrop))

/obj/structure/flora/ash/cacti/replant(mob/living/user)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = 3, max_damage = 6, probability = 70)

