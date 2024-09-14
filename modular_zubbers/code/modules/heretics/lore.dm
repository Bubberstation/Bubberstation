// disables ascensions
/datum/heretic_knowledge/New()
	. = ..()

	for (var/next in next_knowledge)
		if (ispath(next, /datum/heretic_knowledge/ultimate))
			next_knowledge -= next
