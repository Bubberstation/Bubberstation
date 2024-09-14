// disables ascensions
/datum/heretic_knowledge/New()
	. = ..()

	for (var/datum/heretic_knowledge/ultimate/ascension in next_knowledge)
		next_knowledge -= ascension

/datum/heretic_knowledge/ultimate/New()
	. = ..()

	route = null
