/obj/item/integrated_circuit/input/fat_scanner
	name = "integrated body fat analyzer"
	desc = "A very small version of the common medical analyser adjusted to scan a target's weight."
	icon_state = "medscan"
	complexity = 4
	inputs = list("target" = IC_PINTYPE_REF)
	outputs = list(
		"weight (pounds)" = IC_PINTYPE_NUMBER,
		"weight (BFI)" = IC_PINTYPE_NUMBER
		)
	activators = list("scan" = IC_PINTYPE_PULSE_IN, "on scanned" = IC_PINTYPE_PULSE_OUT)
	spawn_flags = IC_SPAWN_DEFAULT|IC_SPAWN_RESEARCH
	power_draw_per_use = 40

/obj/item/integrated_circuit/input/fat_scanner/do_work()
	var/mob/living/carbon/fatty = get_pin_data_as_type(IC_INPUT, 1, /mob/living)
	if(!istype(fatty)) //Invalid input
		return
	if(!fatty.Adjacent(get_turf(src))) // Like normal analysers, it can't be used at range.
		return
	
	var/weight_in_pounds = fatty.calculate_weight_in_pounds() 
	var/weight_in_fatness = fatty.fatness 

	set_pin_data(IC_OUTPUT, 1, weight_in_pounds)
	set_pin_data(IC_OUTPUT, 2, weight_in_fatness)

	push_data()
	activate_pin(2)

