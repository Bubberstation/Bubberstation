#define ADAPTIVE_TOLERANCE 2

/obj/item/organ/lungs/adaptive
	name = "debug-adaptive lungs"
	desc = "if you have these, or see these, someone fucked up"
	icon = 'modular_skyrat/modules/organs/icons/lungs.dmi'
	icon_state = "lungs_cold"
	safe_oxygen_min = 7
	safe_co2_max = 14
	/// The type of air mix (hot/cold) that we are tuned for
	var/air_mix = null

/obj/item/organ/lungs/adaptive/cold
	name = "cold-adapted lungs"
	desc = "A set of lungs adapted to low temperatures, though they are more susceptible to high temperatures"
	icon_state = "lungs_cold"
	air_mix = ICEMOON_DEFAULT_ATMOS
	cold_level_1_threshold = 177.15
	cold_level_2_threshold = 140.15
	cold_level_3_threshold = 110.15
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	heat_level_1_threshold = 337.15
	heat_level_2_threshold = 387.15
	heat_level_3_threshold = 913.15
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2

/obj/item/organ/lungs/adaptive/hot
	name = "heat-adapted lungs"
	desc = "A set of lungs adapted to high temperatures, though they are more susceptible to low temperatures"
	icon_state = "lungs_heat"
	air_mix = LAVALAND_DEFAULT_ATMOS
	cold_level_1_threshold = 271.15
	cold_level_2_threshold = 240.15
	cold_level_3_threshold = 170.15
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2
	heat_level_1_threshold = 373.15
	heat_level_2_threshold = 473.15
	heat_level_3_threshold = 1200.15
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_1
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_2

/obj/item/organ/lungs/adaptive/Initialize(mapload)
	var/datum/gas_mixture/immutable/planetary/mix = SSair.planetary[air_mix]

	if(!mix?.total_moles()) // this typically means we don't have the respective cold/hot z-level, like if we're using the LOWMEMORYMODE define
		return ..()

	// Take a "breath" of the air
	var/datum/gas_mixture/breath = mix.remove(mix.total_moles() * BREATH_PERCENTAGE)

	var/list/breath_gases = breath.gases

	breath.assert_gases(
		/datum/gas/oxygen,
		/datum/gas/plasma,
		/datum/gas/carbon_dioxide,
		/datum/gas/nitrogen,
		/datum/gas/bz,
		/datum/gas/miasma,
	)

	var/oxygen_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/oxygen][MOLES])
	var/plasma_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/plasma][MOLES])
	var/carbon_dioxide_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/carbon_dioxide][MOLES])
	var/bz_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/bz][MOLES])
	var/miasma_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/miasma][MOLES])

	safe_oxygen_min = floor(min(safe_oxygen_min, oxygen_pp - ADAPTIVE_TOLERANCE))

	// Increase plasma tolerance based on amount in base air
	safe_plasma_max += plasma_pp

	// In case we roll a very unlucky set of atmos, make sure you don't die unexpectedly
	safe_co2_max = ceil(max(safe_co2_max, carbon_dioxide_pp + ADAPTIVE_TOLERANCE * 2))

	// The lung tolerance against restricted gases is also increased the amount in the base air
	BZ_trip_balls_min += bz_pp
	BZ_brain_damage_min += bz_pp
	if(miasma_pp)
		suffers_miasma = FALSE

	return ..()

/obj/item/organ/lungs/toxin
	name = "toxin-adapted lungs"
	icon = 'modular_skyrat/modules/organs/icons/lungs.dmi'
	desc = "A set of lungs adapted to toxic environments, though more susceptible to extreme temperatures."
	icon_state = "lungs_toxin"
	safe_plasma_max = 27
	safe_co2_max = 27
	cold_level_2_threshold = 240.15
	cold_level_3_threshold = 170.15
	heat_level_2_threshold = 387.15
	heat_level_3_threshold = 913.15

/obj/item/organ/lungs/oxy
	name = "low-oxygen-adapted lungs"
	icon = 'modular_skyrat/modules/organs/icons/lungs.dmi'
	desc = "A set of lungs adapted to lower-pressure environments, though more susceptible to extreme temperatures."
	icon_state = "lungs_toxin"
	safe_oxygen_min = 4
	safe_co2_max = 21
	cold_level_2_threshold = 240.15
	cold_level_3_threshold = 170.15
	heat_level_2_threshold = 387.15
	heat_level_3_threshold = 913.15

#undef ADAPTIVE_TOLERANCE
