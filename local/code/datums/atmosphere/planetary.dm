/datum/atmosphere/gasgiant
	id = GASGIANT_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/hydrogen=20,
	)
	normal_gases = list(
		/datum/gas/hydrogen=10,
		/datum/gas/helium=10,
	)
	restricted_gases = list(
		/datum/gas/bz=0.1,
	)
	restricted_chance = 20

	minimum_pressure = WARNING_LOW_PRESSURE + 10
	maximum_pressure = WARNING_LOW_PRESSURE + 30

	minimum_temp = ICEBOX_MIN_TEMPERATURE + 20
	maximum_temp = (ICEBOX_MIN_TEMPERATURE + 20) * 2
