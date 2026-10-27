/datum/round_event_control/scrubber_overflow
	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_COMMUNAL)

/datum/round_event_control/scrubber_overflow/threatening
	weight = 0
	max_occurrences = 0

/datum/round_event_control/scrubber_overflow/catastrophic
	weight = 0
	max_occurrences = 0

/datum/round_event_control/scrubber_overflow/every_vent
	weight = 0
	max_occurrences = 0

/datum/round_event/scrubber_overflow
	/// Whitelist of reagents we want scrubbers to dispense
	safer_chems = list(/datum/reagent/baldium,
		/datum/reagent/bluespace,
		/datum/reagent/carbon,
		/datum/reagent/colorful_reagent,
		/datum/reagent/concentrated_barbers_aid,
		/datum/reagent/consumable/astrotame,
		/datum/reagent/consumable/char,
		/datum/reagent/consumable/condensedcapsaicin,
		/datum/reagent/consumable/cream,
		/datum/reagent/consumable/ethanol/antifreeze,
		/datum/reagent/consumable/ethanol/sugar_rush,
		/datum/reagent/consumable/ethanol/singulo,
		/datum/reagent/consumable/ethanol/synthanol,
		/datum/reagent/consumable/ethanol/whiskey,
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/ice,
		/datum/reagent/consumable/laughter,
		/datum/reagent/consumable/sugar,
		/datum/reagent/consumable/tinlux,
		/datum/reagent/cryptobiolin,
		/datum/reagent/drug/mushroomhallucinogen,
		/datum/reagent/drug/space_drugs,
		/datum/reagent/fuel,
		/datum/reagent/glitter/random,
		/datum/reagent/confetti,
		/datum/reagent/gravitum,
		/datum/reagent/growthserum,
		/datum/reagent/hair_dye,
		/datum/reagent/hydrogen_peroxide,
		/datum/reagent/lube,
		/datum/reagent/lube/superlube,
		/datum/reagent/medicine/c2/multiver,
		/datum/reagent/medicine/nanite_slurry,
		/datum/reagent/metalgen,
		/datum/reagent/pax,
		/datum/reagent/plastic_polymers,
		/datum/reagent/space_cleaner,
		/datum/reagent/spraytan,
		/datum/reagent/water/salt,
		/datum/reagent/yuck,
	)
	reagents_amount = 40

/datum/round_event/scrubber_overflow/threatening
	reagents_amount = 60

/datum/round_event/scrubber_overflow/catastrophic
	reagents_amount = 80

