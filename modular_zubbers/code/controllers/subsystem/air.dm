/datum/controller/subsystem/air/
	var/datum/reagent/chosen_goblin_reagent_medicine
	var/datum/reagent/chosen_goblin_reagent_drug
	var/datum/reagent/chosen_goblin_reagent_toxic

/datum/controller/subsystem/air/Initialize()

	. = ..()

	var/list/possible_medicine_reagents = subtypesof(/datum/reagent/medicine)
	while(!chosen_goblin_reagent_medicine && length(possible_medicine_reagents))
		var/datum/reagent/R = pick_n_take(possible_medicine_reagents)
		if(!(initial(R.chemical_flags) & REAGENT_CAN_BE_SYNTHESIZED))
			continue
		chosen_goblin_reagent_medicine = R
	if(!chosen_goblin_reagent_medicine)
		chosen_goblin_reagent_medicine = /datum/reagent/consumable/salt

	var/list/possible_drug_reagents = subtypesof(/datum/reagent/drug)
	while(!chosen_goblin_reagent_drug && length(possible_drug_reagents))
		var/datum/reagent/R = pick_n_take(possible_drug_reagents)
		if(!(initial(R.chemical_flags) & REAGENT_CAN_BE_SYNTHESIZED))
			continue
		chosen_goblin_reagent_drug = R
	if(!chosen_goblin_reagent_drug)
		chosen_goblin_reagent_drug = /datum/reagent/consumable/salt


	var/list/possible_toxic_reagents = subtypesof(/datum/reagent/toxin)
	while(!chosen_goblin_reagent_toxic && length(possible_toxic_reagents))
		var/datum/reagent/R = pick_n_take(possible_toxic_reagents)
		if(!(initial(R.chemical_flags) & REAGENT_CAN_BE_SYNTHESIZED))
			continue
		chosen_goblin_reagent_toxic = R
	if(!chosen_goblin_reagent_toxic)
		chosen_goblin_reagent_toxic = /datum/reagent/consumable/salt

