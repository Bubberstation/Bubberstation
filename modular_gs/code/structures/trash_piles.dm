/obj/structure/trash_pile
	name = "trash pile"
	desc = "A pile of trash, perhaps something of use can be found?"
	icon = 'GainStation13/icons/obj/trash_piles.dmi'
	icon_state = "randompile"

	anchored = TRUE
	density = FALSE
	layer = BELOW_OBJ_LAYER

	var/hide_person_time = 30
	var/hide_item_time = 15

	var/list/used_players = list()

	var/busy = FALSE

/obj/structure/trash_pile/Initialize()
	. = ..()
	icon_state = "pile[rand(1,11)]"

/obj/structure/trash_pile/Destroy()
	for(var/atom/movable/AM in src)
		AM.forceMove(src.loc)
	. = ..()

/obj/structure/trash_pile/attack_hand(mob/user)
	if(busy)
		return
	busy = TRUE
	var/turf/T = get_turf(src)
	if(contents.len) //There's something hidden
		var/atom/A = contents[contents.len] //Get the most recent hidden thing
		if(istype(A, /mob/living))
			var/mob/living/M = A
			to_chat(user,"<span class='notice'>You found someone in the trash!</span>")
			eject_mob(M)
			busy = FALSE
		else if (istype(A, /obj/item))
			var/obj/item/I = A
			to_chat(user,"<span class='notice'>You found something!</span>")
			I.forceMove(src.loc)
			busy = FALSE
	else
		if(user in used_players)
			to_chat(user, "<span class='notice'>You already have looted [src].</span>")
			busy = FALSE
			return
		if(!do_after(user, rand(2 SECONDS, 4 SECONDS), FALSE, src))
			busy = FALSE
			return
		for(var/i=0, i<rand(1,4), i++)
			var/itemtype = pickweight(GLOB.maintenance_loot)
			new itemtype(T)
		used_players += user
		busy = FALSE

/obj/structure/trash_pile/proc/can_hide_item(obj/item/I)
	if(contents.len > 10)
		return FALSE
	return TRUE

/obj/structure/trash_pile/attackby(obj/item/I, mob/user, params)
	if(user.a_intent == INTENT_HELP)
		if(can_hide_item(I))
			to_chat(user,"<span class='notice'>You begin to stealthily hide [I] in the [src].</span>")
			if(do_mob(user, user, hide_item_time))
				if(src.loc)
					if(user.transferItemToLoc(I, src))
						to_chat(user,"<span class='notice'>You hide [I] in the trash.</span>")
					else
						to_chat(user, "<span class='warning'>\The [I] is stuck to your hand, you cannot put it in the trash!</span>")
		else
			to_chat(user,"<span class='warning'>The [src] is way too full to fit [I].</span>")
		return

	. = ..()

/obj/structure/trash_pile/MouseDrop_T(atom/movable/O, mob/user)
	if(user == O && iscarbon(O))
		dive_in_pile(user)
		return
	. = ..()

/obj/structure/trash_pile/proc/eject_mob(var/mob/living/M)
	M.forceMove(src.loc)
	to_chat(M,"<span class='warning'>You've been found!</span>")
	playsound(M.loc, 'sound/machines/chime.ogg', 50, FALSE, -5)
	M.do_alert_animation(M)

/obj/structure/trash_pile/proc/do_dive(mob/user)
	if(contents.len)
		for(var/mob/M in contents)
			to_chat(user,"<span class='warning'>There's someone in the trash already!</span>")
			eject_mob(M)
			return FALSE
	return TRUE

/obj/structure/trash_pile/proc/dive_in_pile(mob/user)
	user.visible_message("<span class='warning'>[user] starts diving into [src].</span>", \
								"<span class='notice'>You start diving into [src]...</span>")
	var/adjusted_dive_time = hide_person_time
	if(user.restrained()) //hiding takes twice as long when restrained.
		adjusted_dive_time *= 2

	if(do_mob(user, user, adjusted_dive_time))
		if(src.loc) //Checking if structure has been destroyed
			if(do_dive(user))
				to_chat(user,"<span class='notice'>You hide in the trashpile.</span>")
				user.forceMove(src)

/obj/structure/trash_pile/container_resist(mob/user)
	user.forceMove(src.loc)

/obj/structure/trash_pile/relaymove(mob/user)
	container_resist(user)
