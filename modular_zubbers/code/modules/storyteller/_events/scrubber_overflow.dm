GLOBAL_LIST_INIT(safe_touch_chems,list(
	/datum/reagent/consumable/salt,
	/datum/reagent/consumable/flour,
	/datum/reagent/blood,
	/datum/reagent/water,
	subtypesof(/datum/reagent/lube),
	/datum/reagent/carbon,
	/datum/reagent/space_cleaner,
	subtypesof(/datum/reagent/carpet),
	/datum/reagent/drying_agent,
	subtypesof(/datum/reagent/glitter),
	/datum/reagent/firefighting_foam,
	/datum/reagent/cellulose,
	/datum/reagent/medicine/dermagen,
	/datum/reagent/medicine/regen_jelly,
	/datum/reagent/baldium,
	/datum/reagent/concentrated_barbers_aid,
	/datum/reagent/barbers_aid,
	/datum/reagent/hair_dye,
	/datum/reagent/water/salt,
	/datum/reagent/medicine/mine_salve,
	/datum/reagent/consumable/tinlux,
	/datum/reagent/consumable/tearjuice,
	/datum/reagent/consumable/condensedcapsaicin,
))

GLOBAL_LIST_INIT(dangerous_touch_chems,list(
	/datum/reagent/consumable/frostoil,
	/datum/reagent/hydrogen_peroxide,
	/datum/reagent/water/holywater,
	/datum/reagent/uranium,
	/datum/reagent/fuel,
	/datum/reagent/ants,
	/datum/reagent/thermite,
	/datum/reagent/clf3,
	subtypesof(/datum/reagent/toxin/acid),
	/datum/reagent/medicine/rezadone,
	/datum/reagent/toxin/plantbgone,
	/datum/reagent/napalm,
	/datum/reagent/medicine/polypyr,
	/datum/reagent/medicine/strange_reagent,
	/datum/reagent/consumable/liquidelectricity,
	/datum/reagent/medicine/c2/synthflesh,
	/datum/reagent/medicine/c2/hercuri,
	/datum/reagent/flightpotion, //Not dangerous, just should be rare :)
))

/datum/round_event/scrubber_overflow/get_overflowing_reagent(dangerous)

	var/result = dangerous ? pick(GLOB.dangerous_touch_chems) : pick(GLOB.safe_touch_chems)
	while(islist(result))
		result = pick(result)

	return result
