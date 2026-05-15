/obj/item/toy/crayon/proc/can_claim_for_gang(mob/user, atom/target, datum/antagonist/gang/user_gang)
	var/area/A = get_area(target)
	if(!A || (!is_station_level(A.z)))
		to_chat(user, span_warning("[A] is unsuitable for tagging."))
		return FALSE

	var/spraying_over = FALSE
	for(var/obj/effect/decal/cleanable/crayon/gang/G in target)
		spraying_over = TRUE

	for(var/obj/machinery/power/apc in target)
		to_chat(user, span_warning("You can't tag an APC."))
		return FALSE

	var/obj/effect/decal/cleanable/crayon/gang/occupying_gang = territory_claimed(A, user)
	if(occupying_gang && !spraying_over)
		if(occupying_gang.my_gang == user_gang.my_gang)
			to_chat(user, span_danger("[A] has already been tagged by our gang!"))
		else
			to_chat(user, span_danger("[A] has already been tagged by a gang! You must find and spray over the old tag instead!"))
		return FALSE

	// stolen from oldgang lmao
	return TRUE

/obj/item/toy/crayon/proc/tag_for_gang(mob/user, atom/target, datum/antagonist/gang/user_gang)
	for(var/obj/effect/decal/cleanable/crayon/old_marking in target)
		qdel(old_marking)

	var/area/territory = get_area(target)

	var/obj/effect/decal/cleanable/crayon/gang/tag = new /obj/effect/decal/cleanable/crayon/gang(target)
	tag.my_gang = user_gang.my_gang
	tag.icon_state = "[user_gang.gang_id]_tag"
	tag.name = "[tag.my_gang.name] gang tag"
	tag.desc = "Looks like someone's claimed this area for [tag.my_gang.name]."
	to_chat(user, span_notice("You tagged [territory] for [tag.my_gang.name]!"))

/obj/item/toy/crayon/proc/territory_claimed(area/territory, mob/user)
	for(var/obj/effect/decal/cleanable/crayon/gang/G in GLOB.gang_tags)
		if(get_area(G) == territory)
			return G



//Gang Handler's helper procs to count who has more territory
/datum/gang_handler/proc/get_territory_counts()
	var/list/counts = list()
	var/list/seen_areas = list() //failsafe to prevent double-tagged areas from counting twice

	for(var/obj/effect/decal/cleanable/crayon/gang/tag_decal in GLOB.gang_tags)
		var/area/territory = get_area(tag_decal)
		if(!territory || seen_areas[territory])
			continue

		seen_areas[territory] = TRUE

		if(!counts[tag_decal.my_gang])
			counts[tag_decal.my_gang] = 0

		counts[tag_decal.my_gang]++

	return counts

/datum/gang_handler/proc/get_territory_percentage(datum/team/gang/family)
	var/list/counts = get_territory_counts()
	if(!counts.len || !counts[family])
		return 0

	var/total = 0
	for(var/territory in counts)
		total += counts[territory]

	if(!total)
		return 0

	return round((counts[family] / total) * 100, 0.1)

/datum/gang_handler/proc/has_most_territory(datum/team/gang/family)
	var/list/counts = get_territory_counts()
	if(!counts[family])
		return FALSE

	var/my_count = counts[family]

	for(var/datum/team/gang/other in counts)
		if(other == family)
			continue
		if(counts[other] >= my_count)
			return FALSE

	return TRUE
