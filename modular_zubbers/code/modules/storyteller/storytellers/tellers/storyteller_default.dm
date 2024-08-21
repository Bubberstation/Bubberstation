/datum/storyteller/default
	name = "Default Andy"
	desc = "Default Andy is the default Storyteller, and the comparison point for every other Storyteller. Best for an average, varied experience."
	welcome_text = "AAA"
	antag_divisor = 8


/datum/storyteller/default/New(...)
	welcome_text = pick(
		"If I chopped you up in a meat grinder...",
		"Life is pain.",
		"Brush your teeth if you wanna not go to fuckin' jail."
	)
	. = ..()
