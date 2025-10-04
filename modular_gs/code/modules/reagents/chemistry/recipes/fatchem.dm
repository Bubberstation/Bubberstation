//GS13 - fat chems

//WG chem
/datum/chemical_reaction/lipoifier
	results = list(/datum/reagent/consumable/lipoifier = 3)
	required_reagents = list(/datum/reagent/consumable/caramel = 1, /datum/reagent/consumable/nutriment/fat/oil/corn = 1, /datum/reagent/medicine/c2/synthflesh = 1)
	overheat_temp = NO_OVERHEAT
	optimal_ph_min = 2
	optimal_ph_max = 10
	thermic_constant = 0
	H_ion_release = 0
	purity_min = 0
	reaction_flags = REACTION_INSTANT | REACTION_CLEAR_IMPURE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG

// /datum/chemical_reaction/lipolicide // why do we have this here when the regular codebase has this already???
// 	results = list(/datum/reagent/toxin/lipolicide = 3)
// 	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/diethylamine = 1, /datum/reagent/medicine/ephedrine = 1)

//BURP CHEM
/datum/chemical_reaction/fizulphite
	results = list(/datum/reagent/consumable/fizulphite = 5)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/nitrogen = 1, /datum/reagent/oxygen = 3)
	overheat_temp = NO_OVERHEAT
	optimal_ph_min = 2
	optimal_ph_max = 10
	thermic_constant = 0
	H_ion_release = 0
	purity_min = 0
	reaction_flags = REACTION_INSTANT | REACTION_CLEAR_IMPURE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRINK

//ANTI-BURP / ANTI-FULLNESS CHEM
/datum/chemical_reaction/extilphite
	results = list(/datum/reagent/consumable/extilphite = 5)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/hydrogen = 2, /datum/reagent/carbon = 2)
	overheat_temp = NO_OVERHEAT
	optimal_ph_min = 2
	optimal_ph_max = 10
	thermic_constant = 0
	H_ion_release = 0
	purity_min = 0
	reaction_flags = REACTION_INSTANT | REACTION_CLEAR_IMPURE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRINK

// brap chem
/datum/chemical_reaction/flatulose
	results = list(/datum/reagent/consumable/flatulose = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/toxin/bad_food = 1, /datum/reagent/consumable/cream = 1)
	overheat_temp = NO_OVERHEAT
	optimal_ph_min = 2
	optimal_ph_max = 10
	thermic_constant = 0
	H_ion_release = 0
	purity_min = 0
	reaction_flags = REACTION_INSTANT | REACTION_CLEAR_IMPURE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRINK
