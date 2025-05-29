/datum/nanite_rule/fatness
	name = "BFI"
	desc = "Checks the host's BFI."

	var/threshold = 50
	var/above = TRUE

/datum/nanite_rule/fatness/check_rule()
	if(iscarbon(program.host_mob))
		var/mob/living/carbon/C = program.host_mob
		var/BFI = C.fatness_real
		if(above)
			if(BFI >= threshold)
				return TRUE
		else
			if(BFI < threshold)
				return TRUE
		return FALSE
	else
		return FALSE

/datum/nanite_rule/fatness/display()
	return "[name] [above ? ">" : "<"] [threshold]"

/datum/nanite_program/sensor/fat_sensor
	name = "BFI Sensor"
	desc = "The nanites receive a signal when the host's BFI is below or exceeds a certain amount."
	can_rule = TRUE
	var/spent = FALSE

/datum/nanite_program/sensor/fat_sensor/register_extra_settings()
	. = ..()
	extra_settings[NES_FATNESS] = new /datum/nanite_extra_setting/number(0, 0, 3440, "BFI")
	extra_settings[NES_DIRECTION] = new /datum/nanite_extra_setting/boolean(TRUE, "Above", "Below")

/datum/nanite_program/sensor/fat_sensor/check_event()
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		var/datum/nanite_extra_setting/level = extra_settings[NES_FATNESS]
		var/datum/nanite_extra_setting/direction = extra_settings[NES_DIRECTION]
		var/detected = FALSE
		if(direction.get_value())
			if(C.fatness >= level.get_value())
				detected = TRUE
		else
			if(C.fatness < level.get_value())
				detected = TRUE

		if(detected)
			if(!spent)
				spent = TRUE
				return TRUE
			return FALSE
		else
			spent = FALSE
			return FALSE
	return FALSE

/datum/nanite_program/sensor/fat_sensor/make_rule(datum/nanite_program/target)
	var/datum/nanite_rule/fatness/rule = new(target)
	var/datum/nanite_extra_setting/direction = extra_settings[NES_DIRECTION]
	var/datum/nanite_extra_setting/level = extra_settings[NES_FATNESS]
	rule.above = direction.get_value()
	rule.threshold = level.get_value()
	return rule

/datum/design/nanites/fat_sensor
	name = "BFI Sensor"
	desc = "The nanites boost can detect the host's BFI."
	id = "fat_sensor_nanites"
	program_type = /datum/nanite_program/sensor/fat_sensor
	category = list("Sensor Nanites")

/datum/nanite_program/fat_adjuster
	name = "BFI Regulator"
	desc = "The nanites act on the host's adipose tissues, removing or adding based on the specified preference. Nanites consumed are equal to value added/lost"
	use_rate = 0
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/fat_adjuster/register_extra_settings()
	. = ..()
	extra_settings[NES_FATNESS] = new /datum/nanite_extra_setting/number(0, -10, 10, "BFI")

/datum/nanite_program/fat_adjuster/check_conditions()
	var/datum/nanite_extra_setting/BFI = extra_settings[NES_FATNESS]
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		if(BFI.get_value() < 0)
			if(C.fatness_real <= 0)
				return FALSE
	else
		return FALSE
	return ..()

/datum/nanite_program/fat_adjuster/active_effect()
	var/datum/nanite_extra_setting/BFI = extra_settings[NES_FATNESS]
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		if(BFI.get_value() > 0)
			if(consume_nanites(BFI.get_value()))
				C.adjust_fatness(BFI.get_value(), FATTENING_TYPE_NANITES)
		else
			if(consume_nanites(-(BFI.get_value())))
				C.adjust_fatness(BFI.get_value(), FATTENING_TYPE_WEIGHT_LOSS)

/datum/design/nanites/fat_adjuster
	name = "BFI Regulator"
	desc = "The nanites adjust the host's BFI."
	id = "fat_adjuster_nanites"
	program_type = /datum/nanite_program/fat_adjuster
	category = list("Medical Nanites")

/datum/nanite_program/fat_converter
	name = "Adipose Conversion"
	desc = "Nanites learn to convert excess body mass to replicate."
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/fat_converter/check_conditions()
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		if(C.fatness_real <= 0 || nanites.nanite_volume >= nanites.max_nanites)
			return FALSE
	else
		return FALSE
	return ..()

/datum/nanite_program/fat_converter/active_effect()
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		if(C.fatness_real > 0 && nanites.nanite_volume < nanites.max_nanites)
			nanites.adjust_nanites(src, min(round(C.fatness_real), 5))
			C.adjust_fatness(-(min(round(C.fatness_real), 5)), FATTENING_TYPE_WEIGHT_LOSS)

/datum/design/nanites/fat_converter
	name = "Adipose Conversion"
	desc = "The nanites use fat to replicate quickly."
	id = "fat_converter_nanites"
	program_type = /datum/nanite_program/fat_converter
	category = list("Medical Nanites")

/datum/nanite_program/bwomf
	name = "B.W.O.M.F." //Body Widening Operation for Mass Fattening
	desc = "Nanites remains on standy-by, massively increasing the host's mass on trigger.."
	unique = FALSE
	can_trigger = TRUE
	trigger_cost = 50
	trigger_cooldown = 50
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/bwomf/on_trigger(comm_message)
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		C.adjust_fatness(100, FATTENING_TYPE_NANITES)
		to_chat(C, "<span class='warning'>[pick("Your belly expands quickly!", "Fat envelops you further!", "Lard grows all over you!")]</span>")

/datum/design/nanites/bwomf
	name = "B.W.O.M.F."
	desc = "Massively increase host's mass on trigger."
	id = "bwomf_nanites"
	program_type = /datum/nanite_program/bwomf
	category = list("Medical Nanites")
