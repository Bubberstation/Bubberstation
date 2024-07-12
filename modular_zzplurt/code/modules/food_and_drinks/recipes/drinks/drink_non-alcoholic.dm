//SPLURT drinks

/datum/chemical_reaction/drink/wockyslush
	results = list(/datum/reagent/consumable/wockyslush = 5)
	required_reagents = list(/datum/reagent/toxin/fentanyl = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/lemon_lime = 1)
	mix_message = "That thang bleedin' P!"

/datum/chemical_reaction/drink/orange_creamsicle
    results = list(/datum/reagent/consumable/orange_creamsicle = 4)
    required_reagents = list(/datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/orangejuice = 1)

//Milkshakes
/datum/chemical_reaction/drink/milkshake_base
	results = list(/datum/reagent/consumable/milkshake_base = 3)
	required_reagents = list(
		/datum/reagent/consumable/milk = 1,
		/datum/reagent/consumable/ice = 1,
		/datum/reagent/consumable/cream =1
	)

/* Already exist in nonmodular code
/datum/chemical_reaction/drink/milkshake_vanilla
	results = list(/datum/reagent/consumable/milkshake_vanilla = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base =1,
		/datum/reagent/consumable/vanilla =1
	)

/datum/chemical_reaction/drink/milkshake_choc
	results = list(/datum/reagent/consumable/milkshake_choc = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/coco = 1
	)

/datum/chemical_reaction/drink/milkshake_strawberry
	results = list(/datum/reagent/consumable/milkshake_strawberry = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/strawberryjuice = 1
	)

/datum/chemical_reaction/drink/milkshake_banana
	results = list(/datum/reagent/consumable/milkshake_banana = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/banana = 1
	)

/datum/chemical_reaction/drink/milkshake_berry
	results = list(/datum/reagent/consumable/milkshake_berry = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/berryjuice = 1
	)
*/

/datum/chemical_reaction/drink/milkshake_cola
	results = list(/datum/reagent/consumable/milkshake_cola = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/space_cola = 1
	)

/datum/chemical_reaction/drink/milkshake_gibb
	results = list(/datum/reagent/consumable/milkshake_gibb = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/dr_gibb = 1
	)

/datum/chemical_reaction/drink/milkshake_peach
	results = list(/datum/reagent/consumable/milkshake_peach = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/peachjuice = 1
	)

/datum/chemical_reaction/drink/milkshake_pineapple
	results = list(/datum/reagent/consumable/milkshake_pineapple = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/pineapplejuice = 1
	)

/datum/chemical_reaction/drink/milkshake_melon
	results = list(/datum/reagent/consumable/milkshake_melon = 2)
	required_reagents = list(
		/datum/reagent/consumable/milkshake_base = 1,
		/datum/reagent/consumable/watermelonjuice = 1
	)
