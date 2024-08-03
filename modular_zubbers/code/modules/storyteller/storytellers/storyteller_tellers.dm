/datum/storyteller/guide
	name = "The Guide"
	desc = "The Guide is the default Storyteller, and the comparison point for every other Storyteller. Best for an average, varied experience."
	antag_divisor = 8

/datum/storyteller/sleeper
	name = "The Sleeper"
	desc = "The Sleeper will be light on events compared to the Guide, especially so on ones involving combat or destruction. Best for more chill rounds."
	guarantees_roundstart_crewset = FALSE
	tag_multipliers = list(TAG_COMBAT = 0.1, TAG_DESTRUCTIVE = 0.3)
	antag_divisor = 32

/datum/storyteller/jester
	name = "The Jester"
	desc = "The Jester will create the most events overall, with higher chances of repeating. Best for the most hectic rounds."
	event_repetition_multiplier = 0.8
	population_min = 35
	antag_divisor = 8

/datum/storyteller/warrior
	name = "The Warrior"
	desc = "The Warrior will create more antag-focused events than the Guide, but will spawn less events overall than the Jester. Best for more hectic rounds with a dash of combat."
	tag_multipliers = list(TAG_COMBAT = 1.5)
	population_min = 35
	antag_divisor = 5

/datum/storyteller/demoman
	name = "The DemoMan"
	desc = "The Demoman will focus on impactful environmental events, best for hectic shifts with relatively normal antagonists."
	welcome_text = "What makes me a good demoman?"
	tag_multipliers = list(TAG_DESTRUCTIVE = 2.5) // You asked and I delivered. Destructiveness increased
	population_min = 25
	antag_divisor = 10

/datum/storyteller/ghost
	name = "The Ghost"
	desc = "The Ghost is the absence of a Storyteller. It will not spawn a single event of any sort, or run any Antagonists. Best for rounds where the population is so low that not even the Sleeper is low enough."
	disable_distribution = TRUE
	population_max = 40
	antag_divisor = 32
