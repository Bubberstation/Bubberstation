
//Hemophage / Vampire drinks

/datum/chemical_reaction/drink/venetianwaltz
	results = list(/datum/reagent/consumable/ethanol/venetianwaltz = 9)
	required_reagents = list(/datum/reagent/consumable/caramel = 1, /datum/reagent/consumable/ethanol/creme_de_cacao = 2, /datum/reagent/consumable/ethanol/amaretto = 3, /datum/reagent/blood = 3)

/datum/chemical_reaction/drink/cranberrycadillac
	results = list(/datum/reagent/consumable/ethanol/cranberrycadillac = 5)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/ethanol/champagne = 2, /datum/reagent/consumable/ethanol/cognac = 1, /datum/reagent/blood = 1)
	required_temp = 373.15 //Roughly the temp to boil sugar to make sugar crystals
	mix_message = "The sugar melts then crystalizes around the blood, making candy rocks..."

/datum/chemical_reaction/drink/jubokko
	results = list(/datum/reagent/consumable/ethanol/jubokko = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/sake = 1, /datum/reagent/consumable/ethanol/yuyake = 1, /datum/reagent/blood = 3)

/datum/chemical_reaction/drink/moroccocoffin
	results = list(/datum/reagent/consumable/ethanol/moroccocoffin = 4)
	required_reagents = list(/datum/reagent/consumable/icecoffee = 2, /datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/blood = 1)

/datum/chemical_reaction/drink/batouttahell
	results = list(/datum/reagent/consumable/ethanol/batouttahell = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/absinthe = 1, /datum/reagent/consumable/ethanol/brave_bull = 6, /datum/reagent/blood = 3)
