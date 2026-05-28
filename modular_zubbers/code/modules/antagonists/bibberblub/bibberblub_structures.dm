/obj/structure/bibberblub
	name = "Abstract Bibberblub structure"
	desc = "You shouldn't be seeing this."
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
	tastes = list("wet maintainance" = 5, "a vaguely chicken-flavored glob of snot" = 1, "someone's vomit, but slimier" = 1, "salted riverbed" = 3)
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

/obj/structure/bibberblub/blubhole
	name = "Blubhole"
	desc = "A wall of tough slime with a hole in it. A hole perfect for letting Bibberblubs slip through"
	icon_state = "Blubhole"
	max_integrity = 100
	density = TRUE
	opacity = TRUE
	layer = TABLE_LAYER
	plane = FLOOR_PLANE

/obj/structure/bibberblub/blubhole/CanAllowThrough(atom/movable/mover, border_dir)
	// Bibberblubs can freely pass
	if(istype(mover, /mob/living/basic/bibberblub))
		return TRUE

	return ..()

/obj/structure/bibberblub/blubgrowth
	name = "Blubgrowth"
	desc = "A slimy growth that seems to still be growing. The result probably won't be toxic."
	icon_state = "Blubgrowth_1"
	density = FALSE
	layer = MOB_LAYER
	plane = GAME_PLANE
	var/icon_state_common = "Blubgrowth_"
	var/growth_progress = 1

/obj/item/food/bibberblub_rations/fleshy
	name = "Fleshy Bibberblub Rations"
	desc = "A Protein-rich glob of goop. Likely unpalatable to anyone who has tastebuds, which Bibberblubs conveniently lack. Doesn't actually contain any meat."
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 20,)

/obj/structure/bibberblub/blubgrowth/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(advance_growth)), 1 MINUTES)

/obj/structure/bibberblub/blubgrowth/proc/advance_growth()
	growth_progress++
	if(growth_progress > 4)
		finish_growing()
		return
	icon_state = "[icon_state_common][growth_progress]"
	update_appearance()
	addtimer(CALLBACK(src, PROC_REF(advance_growth)), 1 MINUTES)

/obj/structure/bibberblub/blubgrowth/proc/finish_growing()
	new /obj/item/food/bibberblub_rations/fleshy(get_turf(src))
	playsound(src, 'sound/effects/splat.ogg', 100, TRUE)
	qdel(src)


//Technically not structures, but fit here best anyway
/obj/effect/decal/cleanable/bibberblub_spit
	name = "Bibberblub spit"
	desc = "A slimy and slippery mess made by a Bibberblub. Stains like hell."
	icon = 'icons/effects/blood.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")
	beauty = -100
	clean_type = CLEAN_TYPE_BLOOD
	color = "#134b0c"

/obj/effect/decal/cleanable/bibberblub_spit/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	var/datum/component/slippery/slippy_comp = AddComponent(/datum/component/slippery, 8 SECONDS, (NO_SLIP_WHEN_WALKING | SLIDE))
