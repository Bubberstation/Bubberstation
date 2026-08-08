/datum/outfit/job/curator
	skillchips = list(/obj/item/skillchip/xenoarch_magnifier)

// second fallback just in case the map is missing both the curator display case and codex gigas
/datum/job/curator/after_spawn(mob/living/spawned, client/player_client)
	mind_traits += (TRAIT_BLOODSUCKER_HUNTER)
	. = ..()
	var/list/points_of_interest = SSpoints_of_interest.get_other_pois()
	var/obj/item/book/kindred/book_to_spawn
	for(var/poi in points_of_interest)
		var/thing = points_of_interest[poi]
		if(istype(thing, /obj/item/book/kindred))
			return
	book_to_spawn = new(get_turf(spawned))
	if(iscarbon(spawned))
		var/mob/living/carbon/carbon_spawned = spawned
		// Not suspicious but convenient in this case
		carbon_spawned.equip_conspicuous_item(book_to_spawn, FALSE)
