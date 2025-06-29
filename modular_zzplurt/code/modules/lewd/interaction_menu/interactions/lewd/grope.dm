/datum/interaction/lewd/grope_ass
	name = "Grope Ass"
	description = "Grope their ass."
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	message = list(
		"gropes %TARGET%'s ass",
		"squeezes %TARGET%'s butt",
		"fondles %TARGET%'s rear",
		"grabs %TARGET%'s ass cheeks"
	)
	user_messages = list(
		"You feel %TARGET%'s soft ass in your hand",
		"The firmness of %TARGET%'s butt feels nice in your palm",
		"You squeeze %TARGET%'s plump rear"
	)
	target_messages = list(
		"You feel %USER%'s hand groping your ass",
		"%USER%'s fingers squeeze your butt cheeks",
		"The warmth of %USER%'s palm presses against your rear"
	)
	sound_range = 1
	sound_use = FALSE
	user_pleasure = 0
	target_pleasure = 0
	user_arousal = 3
	target_arousal = 3
