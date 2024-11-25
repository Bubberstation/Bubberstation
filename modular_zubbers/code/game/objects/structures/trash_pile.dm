/obj/structure/trash_pile
	name = "trash pile"
	desc = "A heap of dense garbage. Perhaps there is something interesting inside?"
	icon = 'modular_skyrat/master_files/icons/obj/trash_piles.dmi'
	icon_state = "randompile"
	density = TRUE
	anchored = TRUE
	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT
	pass_flags = LETPASSTHROW

	max_integrity = 50

	var/hide_person_time = 3 SECONDS
	var/hide_item_time = 1 SECONDS

	var/list/searched_by_ckeys = list() //Assoc list of people who searched this trash pile (value is 1), or started searching (value is 0)

	var/trash_delay = 0.5 SECONDS
	var/funny_sound_delay = 0.2 SECONDS

	COOLDOWN_DECLARE(trash_cooldown)
	COOLDOWN_DECLARE(funny_sound_cooldown)

	var/static/list/funny_sounds = list( //Assoc list of funny sounds (funny sound to weight)
		'sound/effects/adminhelp.ogg' = 1,
		'sound/effects/footstep/clownstep1.ogg' = 5,
		'sound/effects/footstep/clownstep2.ogg' = 5,
		'sound/effects/footstep/meowstep1.ogg' = 1,
		'sound/effects/blob/attackblob.ogg' = 10,
		'sound/effects/bang.ogg' = 10,
		'sound/effects/bin/bin_close.ogg' = 20,
		'sound/effects/bin/bin_open.ogg' = 20,
		'sound/effects/boing.ogg' = 5,
		'sound/effects/cartoon_sfx/cartoon_splat.ogg' = 1,
		'sound/effects/cashregister.ogg' = 1,
		'sound/effects/glass/glassbash.ogg' = 50,
		'sound/effects/glass/glassbr1.ogg' = 20,
		'sound/effects/glass/glassbr2.ogg' = 20,
		'sound/effects/glass/glassbr3.ogg' = 20,
		'sound/effects/grillehit.ogg' = 20,
		'sound/effects/hit_on_shattered_glass.ogg' = 20,
		'sound/effects/jingle.ogg' = 50,
		'sound/effects/meatslap.ogg' = 50,
		'sound/effects/quack.ogg' = 20,
		'sound/effects/rustle/rustle1.ogg' = 100,
		'sound/effects/rustle/rustle2.ogg' = 100,
		'sound/effects/rustle/rustle3.ogg' = 100,
		'sound/effects/rustle/rustle4.ogg' = 100,
		'sound/effects/rustle/rustle5.ogg' = 100,
	)

/obj/structure/trash_pile/Destroy()

	var/turf/T = get_turf(src)

	if(T)
		for(var/atom/movable/M in contents)
			M.forceMove(T)

	. = ..()

/obj/structure/trash_pile/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 12)
	icon_state = pick(
		"pile1",
		"pile2",
		"pilechair",
		"piletable",
		"pilevending",
		"brtrashpile",
		"microwavepile",
		"rackpile",
		"boxfort",
		"trashbag",
		"brokecomp",
	)

/obj/structure/trash_pile/attack_hand(mob/living/user)

	if(user in contents)
		eject_mob(user)
		return

	if(!ishuman(user) || user.combat_mode || !user.ckey)
		return ..()

	user.visible_message("[user] searches through \the [src]...", span_notice("You search through \the [src]..."))

	playsound(get_turf(src), pick('sound/effects/rustle/rustle1.ogg','sound/effects/rustle/rustle2.ogg','sound/effects/rustle/rustle3.ogg','sound/effects/rustle/rustle4.ogg','sound/effects/rustle/rustle5.ogg'), 50)

	var/content_length = length(contents)
	if(content_length) //Something hidden inside (mob/item)
		var/atom/hidden_atom = contents[content_length] // Get the most recent hidden thing
		if(!do_after(user,3 SECONDS, target = src,  extra_checks = CALLBACK(src,PROC_REF(throw_trash),user)))
			if(!isnum(searched_by_ckeys[user.ckey]))
				searched_by_ckeys[user.ckey] = 0
			return
		else
			if(!isnum(searched_by_ckeys[user.ckey]))
				searched_by_ckeys[user.ckey] = 0
		if(istype(hidden_atom, /mob/living))
			var/mob/living/hidden_mob = hidden_atom
			balloon_alert(user, "someone is inside!")
			eject_mob(hidden_mob)
		else if (istype(hidden_atom, /obj/item))
			var/obj/item/hidden_item = hidden_atom
			balloon_alert(user, "found something!")
			hidden_item.forceMove(get_turf(src))
		return

	if(!do_after(user,3 SECONDS, target = src,  extra_checks = CALLBACK(src,PROC_REF(throw_trash),user)))
		if(!isnum(searched_by_ckeys[user.ckey]))
			searched_by_ckeys[user.ckey] = 0
		return

	if(searched_by_ckeys[user.ckey])
		balloon_alert(user, "empty...")
		return TRUE
	var/obj/item/spawned_item = prob(25) ? pick_weight_recursive(GLOB.common_loot) : pick_weight_recursive(GLOB.trash_pile_loot)
	spawned_item = new spawned_item(get_turf(src))
	if(spawned_item)
		balloon_alert(user, "found [spawned_item.name]!")
	else
		balloon_alert(user, "found nothing...")

	searched_by_ckeys[user.ckey] = 1

/obj/structure/trash_pile/attackby(obj/item/attacking_item, mob/living/user, params)

	if(user in contents)
		eject_mob(user)
		return

	if(user.combat_mode)
		return ..()

	if(length(contents) >= 10)
		balloon_alert(user, "it's full!")
		return

	balloon_alert(user, "hiding item...")
	if(!do_after(user, hide_item_time, user))
		return

	if(QDELETED(src))
		return

	if(user.transferItemToLoc(attacking_item, src))
		balloon_alert(user, "item hidden!")

/obj/structure/trash_pile/mouse_drop_receive(atom/movable/dropped_atom, mob/user, params)

	if(user != dropped_atom || !iscarbon(dropped_atom))
		return ..()

	var/mob/living/carbon/dropped_mob = dropped_atom
	if(!(dropped_mob.mobility_flags & MOBILITY_MOVE))
		return

	user.visible_message(
		span_warning("[user] starts diving into [src]."),
		span_notice("You start diving into [src]...")
	)

	var/adjusted_dive_time = hide_person_time
	if(HAS_TRAIT(user, TRAIT_RESTRAINED)) // hiding takes twice as long when restrained.
		adjusted_dive_time *= 2

	if(!do_after(user, adjusted_dive_time, user))
		return

	if(QDELETED(src))
		return

	for(var/mob/hidden_mob in contents)
		balloon_alert(user, "someone is inside!")
		eject_mob(hidden_mob)
		return

	user.forceMove(src)

/obj/structure/trash_pile/container_resist_act(mob/user)
	user.forceMove(src.loc)

/obj/structure/trash_pile/relaymove(mob/user)
	container_resist_act(user)

/obj/structure/trash_pile/proc/throw_trash(mob/user)

	if(QDELETED(src) || QDELETED(user)) //Check if valid.
		return FALSE

	if(isnum(searched_by_ckeys[user.ckey])) //Don't spawn trash!
		return TRUE

	var/turf/T = get_turf(user)
	if(get_dist(T,src) > 1) //Distance check for TK fuckery
		return TRUE

	if(COOLDOWN_FINISHED(src, trash_cooldown))
		COOLDOWN_START(src, trash_cooldown, trash_delay*0.5 + rand()*trash_delay) // x0.5 to x1.5
		var/obj/item/spawned_item
		if(length(GLOB.one_of_a_kind_loot) && prob(0.1)) //1 in 1000
			spawned_item = pick_n_take(GLOB.one_of_a_kind_loot)
		else
			spawned_item = pick_weight_recursive(GLOB.trash_loot)
		spawned_item = new spawned_item(T)
		var/turf/throw_at = get_ranged_target_turf_direct(src, user, 7, rand(-60,60))
		if(spawned_item.safe_throw_at(throw_at, rand(2,4), rand(1,3), user, spin = TRUE))
			playsound(T, 'sound/items/weapons/punchmiss.ogg', 10)

	if(COOLDOWN_FINISHED(src,funny_sound_cooldown))
		COOLDOWN_START(src, funny_sound_cooldown, funny_sound_delay*0.5 + rand()*funny_sound_delay) // x0.5 to x1.5
		playsound(T,pick_weight(funny_sounds), 25)

	return TRUE

/obj/structure/trash_pile/proc/eject_mob(mob/living/hidden_mob)
	var/turf/T = get_turf(src)
	hidden_mob.forceMove(T)
	playsound(T, 'sound/machines/chime.ogg', 50, FALSE, -5)
	hidden_mob.do_alert_animation(hidden_mob)
	return TRUE
