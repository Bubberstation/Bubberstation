// Atmos types used for planetary airs
/datum/atmosphere/lavaland
	id = LAVALAND_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen = 7,
		/datum/gas/nitrogen = 12,
	)
	normal_gases = list(
		/datum/gas/oxygen = 10,
		/datum/gas/nitrogen = 12,
		/datum/gas/carbon_dioxide = 9,
	)
	restricted_gases = list(
		/datum/gas/plasma = 0.1,
		/datum/gas/bz = 1.2,
		/datum/gas/miasma = 1.2,
		/datum/gas/water_vapor = 0.1,
	)
	restricted_chance = 0

/datum/atmosphere/icemoon
	id = ICEMOON_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen = 7,
		/datum/gas/nitrogen = 12,
	)
	normal_gases = list(
		/datum/gas/oxygen = 10,
		/datum/gas/nitrogen = 12,
		/datum/gas/carbon_dioxide = 9,
	)
	restricted_gases = list(
		/datum/gas/plasma = 0.1,
		/datum/gas/water_vapor = 0.1,
		/datum/gas/miasma = 1.2,
	)
	restricted_chance = 0

