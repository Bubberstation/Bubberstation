//Hemophage drinks

/datum/chemical_reaction/drink/blood_tea
	results = list(/datum/reagent/consumable/icetea/blood_tea = 2) //Results in 2u instead of 3
	required_reagents = list(/datum/reagent/consumable/icetea = 1, /datum/reagent/blood = 2)

/datum/chemical_reaction/drink/blood_coffee
	results = list(/datum/reagent/consumable/coffee/blood_coffee = 2) //Results in 2u instead of 3
	required_reagents = list(/datum/reagent/consumable/coffee = 1, /datum/reagent/blood = 2)

/datum/chemical_reaction/drink/intraverde
	results = list(/datum/reagent/consumable/intraverde = 5)
	required_reagents = list(/datum/reagent/consumable/melon_soda = 1, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/blood = 2)

//Ethereal Drinks

/datum/chemical_reaction/drink/blumpkin_compot
	results = list(/datum/reagent/consumable/blumpkin_compot = 9)
	required_reagents = list(/datum/reagent/consumable/blumpkinjuice = 4, /datum/reagent/consumable/berryjuice = 2, /datum/reagent/consumable/hakka_mate = 2,/datum/reagent/consumable/sugar = 1)
	required_temp = 373.15 //Boil to make stew...
	mix_message = "The mixture reaches a boil, and begins to generate an electric charge..."
