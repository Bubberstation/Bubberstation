
/obj/item/organ/internal/lungs/too_much_miasma(mob/living/carbon/breather, datum/gas_mixture/breath, miasma_pp, old_miasma_pp)

	breathe_gas_volume(breath, /datum/gas/miasma)

	if(miasma_pp >= 0.1)
		breather.adjust_disgust( 1 + max(miasma_pp*2 - old_miasma_pp,0) * 0.2)

	if(old_miasma_pp <= miasma_pp*0.5 || prob(2 + min(miasma_pp*4,15)))
		breather.emote("cough")
		switch(miasma_pp)
			if(0 to 4)
				to_chat(breather, span_notice("There is an unpleasant smell in the air."))
			if(4 to 12)
				to_chat(breather, span_warning("You smell rotting flesh."))
				breather.add_mood_event("miasma", /datum/mood_event/miasma/light)
			if(12 to 20)
				to_chat(breather, span_warning("You smell something that's been horribly decayed inside this room."))
				breather.add_mood_event("miasma", /datum/mood_event/miasma/moderate)
			if(20 to INFINITY)
				to_chat(breather, span_warning("The smell of rotting carcasses is unbearable!"))
				breather.add_mood_event("miasma", /datum/mood_event/miasma/heavy)
				if(prob(miasma_pp))
					var/datum/disease/advance/floorfood/miasma/miasma_disease = new
					if(breather.CanContractDisease(miasma_disease))
						breather.AirborneContractDisease(miasma_disease, TRUE)
					breather.vomit(VOMIT_CATEGORY_DEFAULT)

/obj/item/organ/internal/lungs/safe_miasma(mob/living/carbon/breather, datum/gas_mixture/breath, old_miasma_pp)
	breather.clear_mood_event("miasma")
	return TRUE
