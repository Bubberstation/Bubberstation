
// second fallback just in case the map is missing both the curator display case and codex gigas
/datum/job/curator/after_spawn(mob/living/spawned, client/player_client)
	mind_traits += (TRAIT_BLOODSUCKER_HUNTER)
	. = ..()
	var/obj/item/book/kindred/book_to_spawn = locate() in SSpoints_of_interest.get_other_pois()
	if(book_to_spawn)
		return
	book_to_spawn = new(get_turf(spawned))
	if(iscarbon(spawned))
		var/mob/living/carbon/carbon_spawned = spawned
		// Not suspicious but convenient in this case
		carbon_spawned.equip_conspicuous_item(book_to_spawn, FALSE)
