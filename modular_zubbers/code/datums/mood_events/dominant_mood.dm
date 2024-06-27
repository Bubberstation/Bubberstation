/datum/mood_event/dominant/good_boy
	description = span_nicegreen("I feel like a good THING!")
	mood_change = 2
	timeout = 3 MINUTES

/datum/mood_event/dominant/need
	description = span_warning("I need someone to make me a good THING!")
	mood_change = -1
	timeout = 3 MINUTES

/datum/mood_event/dominant/add_effects(param)
	. = ..()
	var/mob/living/carbon/human/actual_owner = owner
	var/good_x = "pet"
	switch(actual_owner.gender)
		if(MALE)
			good_x = "boy"
		if(FEMALE)
			good_x = "girl"
	description = replacetextEx(description, "THING", good_x)
