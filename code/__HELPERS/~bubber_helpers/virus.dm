/datum/disease/advance/event/admin_details()
	var/list/name_symptoms = list()
	for(var/datum/symptom/S in symptoms)
		name_symptoms += S.name
	return "[name] - sym: [english_list(name_symptoms)] spr:[spreading_modifier] inf:[infectivity] spd:[stage_prob] cure:[cure_chance]"

/datum/disease/advance/proc/symptoms_list()
	var/list/name_symptoms = list()
	for(var/datum/symptom/S in symptoms)
		if(istype(S, /datum/symptom/viraladaptation) || istype(S, /datum/symptom/viralevolution))
			continue
		name_symptoms += S.name
	return english_list(name_symptoms)
