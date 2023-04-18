//Hydration
/datum/mood_event/wellhydrated
	description = "I'm gonna burst!"
	mood_change = 4

/datum/mood_event/hydrated
	description = "I have recently had some water."
	mood_change = 2

/datum/mood_event/thirsty
	description = "I'm getting a bit thirsty."
	mood_change = -4

/datum/mood_event/dehydrated
	description = "I'm dehydrated!"
	mood_change = -10

//Urination
/datum/mood_event/piss
	description = "I need to pee."
	mood_change = -4

/datum/mood_event/verypiss
	description = "My bladder is going to explode!"
	mood_change = -8

/datum/mood_event/pissed_self
	description = "I have pissed my pants. This day is ruined."
	mood_change = -8
	timeout = 10 MINUTES

/datum/mood_event/piss_enjoyer
	description = "I love the taste of piss!"
	mood_change = 4
	timeout = 3 MINUTES
