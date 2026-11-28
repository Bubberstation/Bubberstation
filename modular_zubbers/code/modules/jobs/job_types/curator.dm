/datum/outfit/job/curator
	skillchips = list(/obj/item/skillchip/xenoarch_magnifier)

/datum/job/curator
	description = "Read and write books and hand them to people, stock bookshelves, report on station news, and hunt vampires."
	required_languages = null
	akula_outfit = /datum/outfit/akula
	alt_titles = list(
		"Curator",
		"Adventurer",
		"Archivist",
		"Conservator",
		"Journalist",
		"Librarian",
		"Historian",
		"Archaeologist",
		"Professor",
		"Veteran Adventurer"
	)

// second fallback just in case the map is missing both the curator display case and codex gigas
/datum/job/curator/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(spawned.mind)
		ADD_TRAIT(spawned.mind, TRAIT_OCCULTIST, JOB_TRAIT)
		spawned.mind.teach_crafting_recipe(/datum/crafting_recipe/hardened_stake)
		spawned.mind.teach_crafting_recipe(/datum/crafting_recipe/silver_stake)
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
