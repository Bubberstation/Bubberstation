/obj/structure/bibberblub
	icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	max_integrity = 50
	anchored = TRUE

/obj/structure/bibberblub/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/blob/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/items/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/structure/bibberblub/slimy_floor
	name = "Slimy Floor"
	desc = "The floor here is covered in thick goop!"
	icon_state = "Floor"
	density = FALSE
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE

/obj/structure/bibberblub/slimy_floor/vent_hole
	icon_state = "Floor_Vent"

/obj/structure/bibberblub/compost
	name = "Goopy Compost"
	desc = "A hole in the ground that is capable of turning trash into Bibberblub Rations"
	icon_state = "Compost"
	density = FALSE
	layer = LOWER_RUNE_LAYER
	plane = FLOOR_PLANE
	var/processing_trash = FALSE
	var/datum/proximity_monitor/proximity_monitor

/obj/item/food/bibberblub_rations
	name = "Bibberblub Rations"
	desc = "A Nutritionally complete glob of goop. Likely unpalatable to anyone who has tastebuds, which Bibberblubs conveniently lack."
	icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	icon_state = "Rations"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("wet maintainance" = 5, "a vaguely apple-flavored glob of snot" = 1, "someone's vomit, but slimier" = 1, "salted riverbed" = 3)
	foodtypes = GROSS
	w_class = WEIGHT_CLASS_TINY

/obj/structure/bibberblub/compost/Initialize(mapload)
	. = ..()
	proximity_monitor = new(src, 1)

/obj/structure/bibberblub/compost/examine(mob/user)
	. = ..()
	if(processing_trash)
		. += "It seems busy digesting a piece of trash..."

/obj/structure/bibberblub/compost/proc/process_trash()

	var/list/obj/item/trash/trash_list = list()
	for(var/obj/item/trash/junk in loc)
		trash_list += junk
	var/obj/item/trash/to_compost = pick_n_take(trash_list)
	if(!isnull(to_compost) && !processing_trash)
		balloon_alert_to_viewers("Processing Trash!")
		processing_trash = TRUE
		qdel(to_compost)
		addtimer(CALLBACK(src, PROC_REF(finish_composting)), 1 MINUTES)

/obj/structure/bibberblub/compost/proc/finish_composting()
	if(QDELETED(src))
		return
	processing_trash = FALSE
	new /obj/item/food/bibberblub_rations(get_turf(src))
	process_trash()

/obj/structure/bibberblub/compost/HasProximity(atom/movable/proximity_check_mob)
	. = ..()
	process_trash()
