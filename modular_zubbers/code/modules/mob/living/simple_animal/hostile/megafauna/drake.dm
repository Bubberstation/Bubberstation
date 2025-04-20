/mob/living/simple_animal/hostile/megafauna/dragon
	faction = list(FACTION_ASHWALKER,FACTION_MINING)

/mob/living/simple_animal/hostile/megafauna/dragon/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

/mob/living/simple_animal/hostile/megafauna/dragon/proc/on_move(atom/source, atom/new_loc)
	SIGNAL_HANDLER
	for(var/obj/item/food/meat/slab/drakebait in view(src, 1.5)) //Checks if the bait is on, or is next to the Ashdrake
		qdel(drakebait)// bait is kil
		new /obj/item/stack/sheet/animalhide/ashdrake(get_turf(src))
		visible_message(span_notice("[src] accepts your offering."), span_notice("The drake consumes the meat."))
