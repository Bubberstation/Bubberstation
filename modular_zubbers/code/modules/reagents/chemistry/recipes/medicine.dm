/datum/chemical_reaction/medicine/xlasyn
	results = list(/datum/reagent/medicine/xlasyn = 2)
	required_reagents = list(/datum/reagent/medicine/c2/synthflesh=1,/datum/reagent/medicine/clonexadone=1,/datum/reagent/toxin/mutagen=1)
	required_catalysts = list(/datum/reagent/iron = 5)
	required_temp = 100
	optimal_temp = 235
	overheat_temp = 200
	optimal_ph_min = 5.5
	optimal_ph_max = 9.5
	determin_ph_range = 3
	temp_exponent_factor = 1
	ph_exponent_factor = 2
	thermic_constant = 10
	H_ion_release = -3.5
	rate_up_lim = 20
	purity_min = 0.3
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_HEALING | REACTION_TAG_ORGAN

/datum/chemical_reaction/medicine/synth_coagulant
	results = list(/datum/reagent/medicine/coagulant/synthetic = 1)
	required_reagents = list(/datum/reagent/medicine/c2/synthflesh=1,/datum/reagent/toxin/formaldehyde=1)
	required_temp = 200
	optimal_temp = 250
	overheat_temp = 400
	optimal_ph_min = 8.5
	optimal_ph_max = 11.5
	determin_ph_range = 3
	temp_exponent_factor = 1
	ph_exponent_factor = 2
	thermic_constant = 8
	H_ion_release = -2
	rate_up_lim = 20
	purity_min = 0.3
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_OTHER

/datum/chemical_reaction/medicine/super_spaceacillin
	results = list(/datum/reagent/medicine/spaceacillin/super = 1)
	required_reagents = list(/datum/reagent/medicine/spaceacillin/super=1,/datum/reagent/toxin/plasma/plasmavirusfood/weak=1,/datum/reagent/toxin/formaldehyde=1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_OTHER
	required_temp = 300
	optimal_temp = 400
	overheat_temp = 500
