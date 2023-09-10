/datum/disease/advance/floorfood
	copy_type = /datum/disease/advance
	var/list/possible_symptoms = list( //Not a static list because pick_n_take wouldn't work.
		/datum/symptom/fever,
		/datum/symptom/chills,
		/datum/symptom/dizzy,
		/datum/symptom/headache,
		/datum/symptom/itching,
		/datum/symptom/viraladaptation,
		/datum/symptom/viralevolution,
		/datum/symptom/vomit,
		/datum/symptom/undead_adaptation,
		/datum/symptom/inorganic_adaptation,
		/datum/symptom/heal/metabolism,
		/datum/symptom/heal/plasma
	)

/datum/disease/advance/floorfood/New()

	var/max_symptoms = rand(3,4)

	var/regex/vowel = regex("\[aeiou\]","i")
	var/regex/consonant = regex("\[^aeiou\]","i") //I am considering y a consonant in this case.
	var/use_vowel = !prob(80) //Code optimization
	name = ""

	for(var/i in 1 to max_symptoms)
		var/datum/symptom/chosen_symptom = pick_n_take(possible_symptoms)
		if(chosen_symptom)
			var/datum/symptom/S = new chosen_symptom
			symptoms += S
			for(var/j in 1 to rand(2,4))
				var/chosen_letter = use_vowel ? vowel.Find(S.name) : consonant.Find(S.name)
				if(chosen_letter)
					name = "[name][chosen_letter]"
					use_vowel = !use_vowel

	if(!name)
		name = "Coder's disease"
	else
		name = "[capitalize(name)]'s disease"

	Refresh()




