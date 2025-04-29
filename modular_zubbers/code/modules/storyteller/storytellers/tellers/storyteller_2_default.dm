/datum/storyteller/default
	name = "Default Andy (Medium Chaos)"
	desc = "Default Andy is the default Storyteller, and the comparison point for every other Storyteller. \
	More frequent events than Chill, but less frequent events than Gamer. Best for an average, varied experience."
	welcome_text = "If I chopped you up in a meat grinder..."

	storyteller_type = STORYTELLER_TYPE_ALWAYS_AVAILABLE
	antag_divisor = 8

	tag_multipliers = list(
		TAG_CHAOTIC = 0.7,
		TAG_BIG_THREE = 0,
	)
