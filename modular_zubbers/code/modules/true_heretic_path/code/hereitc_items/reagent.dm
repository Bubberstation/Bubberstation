/datum/reagent/medicine/omnizine/healing_juice
	name = "Healing Juice"
	description = "This is just a mix of apple juice and Omnizine. Concentrated, from concentrate. What will those scientists think of next?"
	metabolization_rate = 1 * REAGENTS_METABOLISM
	healing = 1
	ph = 6
	overdose_threshold = 15
	color = "#C20000"

/datum/chemical_reaction/medicine/healing_juice
	results = list(/datum/reagent/medicine/omnizine/healing_juice = 1)
	required_reagents = list(/datum/reagent/medicine/omnizine = 2, /datum/reagent/consumable/applejuice = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_BRUTE |REACTION_TAG_BURN | REACTION_TAG_TOXIN | REACTION_TAG_OXY