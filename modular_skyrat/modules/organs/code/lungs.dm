/obj/item/organ/internal/lungs/cold
	name = "cold-adapted lungs"
	icon = 'modular_skyrat/modules/organs/icons/lungs.dmi'
	desc = "A set of lungs adapted to low temperatures, though they are more susceptible to high temperatures"
	icon_state = "lungs_cold"
	safe_oxygen_min = 7 // icebox/lavaland have lower pressure
	safe_co2_max = 21
	cold_level_1_threshold = 177.15
	cold_level_2_threshold = 140.15
	cold_level_3_threshold = 110.15
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	heat_level_1_threshold = 337.15
	heat_level_2_threshold = 387.15
	heat_level_3_threshold = 913.15
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2

/obj/item/organ/internal/lungs/hot
	name = "heat-adapted lungs"
	icon = 'modular_skyrat/modules/organs/icons/lungs.dmi'
	desc = "A set of lungs adapted to high temperatures, though they are more susceptible to low temperatures"
	icon_state = "lungs_heat"
	safe_oxygen_min = 7 // icebox/lavaland have lower pressure
	safe_co2_max = 21
	cold_level_1_threshold = 271.15
	cold_level_2_threshold = 240.15
	cold_level_3_threshold = 170.15
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2
	heat_level_1_threshold = 373.15
	heat_level_2_threshold = 473.15
	heat_level_3_threshold = 1200.15
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_1
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_2

/obj/item/organ/internal/lungs/toxin
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

/obj/item/organ/internal/lungs/oxy
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
