/// Handles weight gain from vore.
/obj/vore_belly/proc/handle_vore_weight_gain(mob/living/carbon/pred, mob/living/carbon/prey)
	if(!istype(pred) || !istype(prey))
		return FALSE // No fatness, no dice.

	var/prey_weight_value = prey.fatness_real //We only want the real weight from them.
	if(prey_weight_value < 1)
		return FALSE

	pred.adjust_fatness(prey_weight_value * FATNESS_FROM_VORE, FATTENING_TYPE_FOOD)
	pred.carbons_digested += 1

	return TRUE

