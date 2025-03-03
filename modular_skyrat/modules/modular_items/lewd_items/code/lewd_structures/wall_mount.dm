/obj/structure/pillory
	name = "wall pillory"
	desc = "A mount for partially sticking people into a wall."
	can_buckle = TRUE
	anchored = TRUE
	max_buckled_mobs = 1
	buckle_lying = 0
	buckle_prevents_pull = TRUE

///Currently mounted human
var/mob/living/carbon/human/current_mob = null

/obj/structure/pillory/Initialize(mapload)
	LAZYINITLIST(buckled_mobs)
	. = ..()

/obj/structure/wall_mount/Destroy()
	. = ..()
	unbuckle_all_mobs(TRUE)

/obj/structure/pillory/user_buckle_mob(mob/living/M, mob/user, check_loc)
	if (!ishuman(M))
		balloon_alert(user, "[M.p_they()] does not fit!")
		return FALSE

	return ..(M, user, check_loc = FALSE)

/obj/structure/pillory/post_buckle_mob(mob/living/buckled_mob)
	if(LAZYLEN(buckled_mobs))
		if(ishuman(buckled_mobs[1]))
			current_mob = buckled_mobs[1]

	var/mob/living/carbon/human/embedded_mob = buckled_mob

	if(istype(embedded_mob.dna.species))
		embedded_mob.cut_overlays()
		for(var/limb in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_CHEST))
			var/obj/item/bodypart/limb_object = embedded_mob.get_bodypart(limb)
			if(!istype(limb_object))
				return

			embedded_mob.add_overlay(limb_object.get_limb_icon())
			embedded_mob.update_worn_undersuit()
			embedded_mob.update_worn_shoes()
		embedded_mob.remove_overlay(BODY_ADJ_LAYER)
		embedded_mob.add_filter("chest_removal", 1, list("type" = "alpha", "icon" = icon('modular_zubbers/icons/obj/structures/pillory.dmi', "mask")))
	else
		unbuckle_all_mobs()
	..()


/obj/structure/pillory/post_unbuckle_mob(mob/living/unbuckled_mob)
	current_mob = null
	unbuckled_mob.remove_filter("chest_removal")
	unbuckled_mob.regenerate_icons()
	. = ..()

/obj/item/wallframe/pillory
	name = "wall pillory frame"
	desc = "An unmounted pillory. Attack it to a wall to use."
	result_path = /obj/structure/pillory
	pixel_shift = 32

/obj/item/wallframe/pillory/try_build(turf/on_wall, mob/user)
	if(get_dir(user, on_wall) != NORTH)
		balloon_alert(user, "Cannot face direction!")
		return
	. = ..()
