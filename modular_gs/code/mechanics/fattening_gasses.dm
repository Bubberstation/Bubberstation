/obj/item/organ/lungs/proc/lipoifium_breathing(datum/gas_mixture/breath, mob/living/carbon/human/H)
	if(!breath)
		return
	
	if(breath.total_moles() == 0)
		return

	var/total_moles = breath.total_moles()
	var/lipoifium_moles = breath.get_moles(GAS_FAT)
	#define PP_MOLES(X) ((X / total_moles) * pressure) // this needs to be here because spaghetti, I'm sorry
	if(lipoifium_moles <= 0)
		return

	H.adjust_fatness(lipoifium_moles * 1500, FATTENING_TYPE_ATMOS)
	breath.set_moles(GAS_FAT, 0)
	// TODO: the entire code below is a workaround for default odor not working
	// The problem seems to be auxmos'es get_gasses function not acknowledging that lipoifium exists
	// which is strange, considering that everything else regarding this gas and auxmos works
	var/smell_chance = min(lipoifium_moles * 100 / total_moles, 20)
	if(prob(smell_chance))
		to_chat(owner, "<span class='notice'>You can smell lard.</span>")


/obj/item/organ/lungs/check_breath(datum/gas_mixture/breath, mob/living/carbon/human/H)
	lipoifium_breathing(breath, H)
	. = ..()
