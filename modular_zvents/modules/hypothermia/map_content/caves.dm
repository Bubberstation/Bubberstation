/obj/structure/sneak_pod
	name = "narrow crevice"
	desc = "A tight squeeze in the frozen rock, barely wide enough to crawl or sidestep through. Moving through it requires careful maneuvering."
	// icon = 'icons/obj/structures.dmi'
	icon_state = "crevice"
	density = TRUE
	opacity = TRUE

	anchored = TRUE
	max_integrity = 200
	armor_type = /datum/armor/none
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/list/crawlers = list()  // List of mobs currently crawling
	var/max_crawlers = 3  // Max small mobs allowed (adjust for balance)
	var/list/crawler_pixel_offsets = list()  // Associative list: mob -> list(x, y, transform)

/obj/structure/sneak_pod/Initialize(mapload)
	. = ..()
	var/list/map = list(
		list(-1, 1, 0), list(0, 1, 0), list(1, 1, 0),
		list(-1, 0, 0), list(0, 0, 0), list(0, 1, 0),
		list(-1, -1, 0), list(0, -1, 0), list(-1, 1, 0)
	)
	AddComponent(/datum/component/seethrough)
	var/datum/component/seethrough/comp = GetComponent(/datum/component/seethrough)
	comp.relative_turf_coords = map
	comp.setup_perimeter(src)

/obj/structure/sneak_pod/Destroy()
	for(var/mob/living/C in crawlers)
		end_crawl(C, forced = TRUE)
	return ..()

/obj/structure/sneak_pod/mouse_drop_receive(mob/living/M, mob/user, params)
	if(M != user)
		return
	if(!can_crawl_into(M, src))
		return
	if(!do_after(user, 5 SECONDS, src))
		user.balloon_alert(user, "Failed to crawl!")
		return
	begin_crawl(M)


/obj/structure/sneak_pod/proc/register_to_crawler(mob/living/crawler)
	RegisterSignal(crawler, COMSIG_MOVABLE_ATTEMPTED_MOVE, PROC_REF(on_crawler_pre_move))
	RegisterSignal(crawler, COMSIG_MOVABLE_MOVED, PROC_REF(on_crawler_moved))
	RegisterSignal(crawler, COMSIG_QDELETING, PROC_REF(on_crawler_qdel))
	RegisterSignal(crawler, COMSIG_LIVING_DEATH, PROC_REF(on_crawler_death))
	RegisterSignal(crawler, COMSIG_LIVING_RESTING, PROC_REF(on_crawler_rest_change))

/obj/structure/sneak_pod/proc/unregister_from_crawler(mob/living/crawler)
	UnregisterSignal(crawler, list(
		COMSIG_MOVABLE_ATTEMPTED_MOVE,
		COMSIG_MOVABLE_MOVED,
		COMSIG_QDELETING,
		COMSIG_LIVING_DEATH,
		COMSIG_LIVING_RESTING
	))

/obj/structure/sneak_pod/proc/begin_crawl(mob/living/crawler, silent = FALSE)
	if(crawler in crawlers)
		return
	crawlers += crawler
	crawler.forceMove(loc)
	crawler.pass_flags |= PASSMOB | PASSTABLE
	ADD_TRAIT(crawler, TRAIT_FLOORED, src)
	register_to_crawler(crawler)
	if(!silent)
		balloon_alert(crawler, "You squeeze into the crevice, crawling forward...")


/obj/structure/sneak_pod/proc/end_crawl(mob/living/crawler, forced = FALSE)
	if(!(crawler in crawlers))
		return
	crawlers -= crawler
	unregister_from_crawler(crawler)
	crawler.pass_flags &= ~(PASSMOB | PASSTABLE)
	REMOVE_TRAIT(crawler, TRAIT_FLOORED, src)

	if(!forced)
		balloon_alert(crawler, "You emerge from the crevice.")



/obj/structure/sneak_pod/proc/on_crawler_pre_move(datum/source, atom/newloc, direction)
	SIGNAL_HANDLER
	var/mob/living/C = source
	if(!(C in crawlers))
		return
	if(can_crawl_into(C, newloc))
		addtimer(CALLBACK(src, PROC_REF(attempt_move), C, newloc), 0)
	else
		end_crawl(C)
	return


/obj/structure/sneak_pod/proc/can_crawl_into(mob/living/C, atom/newloc)
	var/obj/structure/sneak_pod/next_pod
	if(!istype(newloc, /obj/structure/sneak_pod))
		next_pod = locate() in newloc
	else
		next_pod = newloc

	if(!next_pod)
		return FALSE
	if(C.stat != CONSCIOUS)
		return
	if(HAS_TRAIT(C, TRAIT_GIANT))
		C.balloon_alert(C, "I'm too big!")
		return
	var/body_size = 1
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		body_size = H.dna.features["body_size"] || 1
	if(body_size >= 1)
		for(var/mob/living/other in next_pod.crawlers)
			var/other_size = 1
			if(ishuman(other))
				var/mob/living/carbon/human/OH = other
				other_size = OH.dna.features["body_size"] || 1
			if(other_size >= 1)
				balloon_alert(C, "Next crevice is too crowded!")
				return FALSE
	if(length(next_pod.crawlers) >= next_pod.max_crawlers)
		balloon_alert(C, "Next crevice is full!")
		return FALSE
	if(!C.resting)
		balloon_alert(C, "Not resting!")
		return FALSE
	return TRUE

/obj/structure/sneak_pod/proc/attempt_move(mob/living/C, atom/newloc)
	if(!(C in crawlers) || C.stat != CONSCIOUS || !C.resting)
		balloon_alert(C, "Movement interrupted!")
		return
	if(!can_crawl_into(C, newloc))
		balloon_alert(C, "Movement blocked!")
		return
	if(!do_after(C, 1 SECONDS, src, IGNORE_USER_LOC_CHANGE | IGNORE_HELD_ITEM))
		balloon_alert(C, "Movement interrupted!")
		return
	var/obj/structure/sneak_pod/next_pod = locate() in newloc
	if(next_pod)
		C.forceMove(newloc)
		end_crawl(C, TRUE)
		next_pod.begin_crawl(C, TRUE)
	else
		C.forceMove(newloc)
		end_crawl(C)

/obj/structure/sneak_pod/proc/on_crawler_moved(datum/source, atom/oldloc, dir, forced)
	SIGNAL_HANDLER
	var/mob/living/C = source
	if(!(C in crawlers))
		return
	var/obj/structure/sneak_pod/next_pod = locate() in C.loc
	if(next_pod && next_pod != src)
		end_crawl(C, TRUE)
		next_pod.begin_crawl(C)

/obj/structure/sneak_pod/proc/on_crawler_qdel(datum/source)
	SIGNAL_HANDLER
	end_crawl(source, TRUE)

/obj/structure/sneak_pod/proc/on_crawler_death(datum/source)
	SIGNAL_HANDLER
	end_crawl(source, TRUE)

/obj/structure/sneak_pod/proc/on_crawler_rest_change(datum/source, resting)
	SIGNAL_HANDLER
	var/mob/living/C = source
	if(!resting && (C in crawlers))
		balloon_alert(C, "You can't stand up here!")
		C.set_resting(TRUE, TRUE, TRUE)

/obj/structure/sneak_pod/proc/is_still_crawling(mob/living/C)
	return (C in crawlers && C.resting)
