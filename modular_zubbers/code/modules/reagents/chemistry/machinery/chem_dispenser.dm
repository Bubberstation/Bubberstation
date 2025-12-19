/obj/machinery/chem_dispenser
	/// Emagged dispenser reagents
	var/static/list/default_emagged_reagents = list(
		/datum/reagent/toxin/carpotoxin,
		/datum/reagent/consumable/frostoil,
		/datum/reagent/toxin/histamine,
		/datum/reagent/medicine/morphine,
		/datum/reagent/toxin/plasma,
		/datum/reagent/drug/space_drugs,
	)
	/// Tier 2 dispenser reagents
	var/static/list/default_upgrade_reagents = list(
		/datum/reagent/ammonia,
		/datum/reagent/ash,
		/datum/reagent/fuel/oil,
		/datum/reagent/phenol,
	)
	/// Tier 3 dispenser reagents
	var/static/list/default_upgrade2_reagents = list(
		/datum/reagent/acetone,
		/datum/reagent/diethylamine,
	)
	/// Tier 4 dispenser reagents
	var/static/list/default_upgrade3_reagents = list(
		/datum/reagent/medicine/mine_salve,
		/datum/reagent/medicine/mutadone,
		/datum/reagent/toxin,
	)

/obj/machinery/chem_dispenser/drinks
	/// Tier 2 drink dispenser reagents
	var/static/list/drink_upgrade_reagents = list(
		/datum/reagent/consumable/applejuice,
		/datum/reagent/consumable/berryjuice,
		/datum/reagent/consumable/pumpkinjuice,
		/datum/reagent/consumable/vanilla,
	)
	/// Tier 3 drink dispenser reagents
	var/static/list/drink_upgrade2_reagents = list(
		/datum/reagent/consumable/banana,
		/datum/reagent/consumable/blumpkinjuice,
	)
	/// Tier 4 drink dispenser reagents
	var/static/list/drink_upgrade3_reagents = list(
		/datum/reagent/consumable/peachjuice,
		/datum/reagent/consumable/watermelonjuice,
	)
