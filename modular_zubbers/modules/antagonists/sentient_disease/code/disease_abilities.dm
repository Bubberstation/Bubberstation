// NEW SYMPTOM
/datum/disease_ability/symptom/mild/hidden
	name = "Adaption" //Symptom to increase Sentient Virus base Stealth+Resistance
	symptoms = list(/datum/symptom/hidden)
	cost = 0 //Cost is 0 because the virus will already have this by default.
	required_total_points = 0 //Available at start if refunded.
	start_with = TRUE //Starts the virus with the symptom. For balancing reasons.
	short_desc = "Hightens your stealth and resistance."
	long_desc = "An adaptation that allows for greater stealth and resistance."

// Overrides
/datum/disease_ability/action/infect
	cost = 0
	required_total_points = 0
	start_with = TRUE

/datum/disease_ability/symptom/medium
	required_total_points = 6

/datum/disease_ability/symptom/powerful
	required_total_points = 10
