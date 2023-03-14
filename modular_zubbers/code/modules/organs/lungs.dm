//CODERS NOTE. ALL VALUES IN HERE ARE IN KELVIN AND MOLS, NOT CELCIUS OR KPA.\\
//Replacement for Skyrats custom lungs.
/obj/item/organ/internal/lungs/cold
	desc = "A set of lungs that pre-filter and warm air via several self-contained circulatory systems before exposing them to the sensitive lining of mucus within. Very susceptible to heat."
	cold_message = "a chilling - slightly painful and though bearable, an utterly bitter sensation"
	cold_level_1_threshold = 208
	cold_level_2_threshold = 200
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_damage_type = BURN

	hot_message = "the searing heat with every breath you take"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN


/obj/item/organ/internal/lungs/hot
	desc = "A blackened pair of lungs - seemingly adapted with thick mucus membranes to resist harsh heating... Making them more susceptible to freezing as a result."
	cold_message = "the freezing cold with every breath you take"
	cold_level_1_threshold = 256
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BURN

	hot_message = "a slightly twingy, though bearable pain"
	heat_level_1_threshold = 375
	heat_level_2_threshold = 473
	heat_level_3_threshold = 523
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_1
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_1
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_damage_type = BURN

/obj/item/organ/internal/lungs/toxin
	name = "pollution-adapted lungs"
	desc = "A set of lungs almost vaguely similar to the black-frilled lungs of Ashwalkers; capable of scrubbing plasma and carbon dioxide without negative effects - at the cost of resistance to temperature surges."
	safe_plasma_max = 25
	safe_co2_max = 60
	safe_oxygen_max = 50
	safe_nitro_max = 40

	cold_message = "the freezing cold with every breath you take"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BRUTE


	hot_message = "the searing heat with every breath you take"
	heat_level_1_threshold = 310
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/internal/lungs/oxy
	desc = "A set of lungs specifically adapted to low-level, extremophile environments, though more susceptible to internal damage as a result."
	safe_oxygen_min = 8
	safe_oxygen_max = 30
	safe_co2_max = 25
	safe_nitro_max = 50

	hot_message = "the searing heat with every breath you take"
	heat_level_1_threshold = 335
	heat_level_2_threshold = 380
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

	cold_message = "the freezing cold with every breath you take"
	cold_level_1_threshold = 252
	cold_level_2_threshold = 200
	cold_level_3_threshold = 150
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BURN

