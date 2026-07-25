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
	var/regex/consonant = regex("\[^aeiou'\]","i") //I am considering y a consonant in this case. Also this can include spaces and other special stuff.
	var/regex/acceptable_characters = regex("\[^\\w\]","i")

	var/use_vowel = !prob(80) //Code optimization
	name = ""

	for(var/i in 1 to max_symptoms)
		var/datum/symptom/chosen_symptom = pick_n_take(possible_symptoms)
		if(!chosen_symptom)
			continue
		var/datum/symptom/S = new chosen_symptom
		symptoms += S
		var/chosen_letter_pos = 1
		for(var/j in 1 to rand(2,4))
			chosen_letter_pos = use_vowel ? vowel.Find(S.name,chosen_letter_pos) : consonant.Find(S.name,chosen_letter_pos)
			if(!chosen_letter_pos)
				chosen_letter_pos = 1
				break
			var/chosen_letter = copytext(S.name,chosen_letter_pos,chosen_letter_pos+1)
			if(chosen_letter)
				name = "[name][chosen_letter]"
				use_vowel = !use_vowel

	if(name)
		name = acceptable_characters.Replace(name,"")

	if(!name)
		name = "Coder's Disease"
	else
		if(!use_vowel) //Last letter was a vowel
			name = "[name]sis"
		else //Last letter was a consonant
			name = "[name]ia"
		name = capitalize(LOWER_TEXT(trim(name)))

	var/existed = SSdisease.archive_diseases[src.GetDiseaseID()]

	Refresh()
	if(!existed)
		AssignName(name)


/datum/disease/advance/floorfood/miasma
	possible_symptoms = list(
		/datum/symptom/choking,
		/datum/symptom/asphyxiation,
		/datum/symptom/confusion,
		/datum/symptom/cough,
		/datum/symptom/disfiguration,
		/datum/symptom/dizzy,
		/datum/symptom/fever,
		/datum/symptom/flesh_eating,
		/datum/symptom/hallucigen,
		/datum/symptom/headache,
		/datum/symptom/itching,
		/datum/symptom/undead_adaptation,
		/datum/symptom/viraladaptation,
		/datum/symptom/viralevolution,
		/datum/symptom/vomit
	)
