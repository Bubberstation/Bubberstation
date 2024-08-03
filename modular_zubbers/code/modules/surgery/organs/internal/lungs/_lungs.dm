

/obj/item/organ/internal/lungs/too_much_miasma(mob/living/carbon/breather, datum/gas_mixture/breath, miasma_pp, old_miasma_pp)

	breathe_gas_volume(breath, /datum/gas/miasma)

	if(miasma_pp >= 1)
		breather.adjust_disgust( 0.5 + max(miasma_pp*1.5 - old_miasma_pp,0) * 0.5, max = DISGUST_LEVEL_DISGUSTED)
		if(old_miasma_pp <= miasma_pp*0.5 || prob(2 + min(miasma_pp*4,15)))
			breather.emote("cough")
			switch(miasma_pp)
				if(0 to 8)
					to_chat(breather, span_notice("There is an unpleasant smell in the air."))
				if(8 to 16)
					to_chat(breather, span_warning("You smell rotting flesh."))
					breather.add_mood_event("miasma", /datum/mood_event/miasma/light)
				if(24 to 32)
					to_chat(breather, span_warning("You smell something that's been horribly decayed inside this room."))
					breather.add_mood_event("miasma", /datum/mood_event/miasma/moderate)
				if(32 to INFINITY)
					to_chat(breather, span_warning("The smell of rotting carcasses is unbearable!"))
					breather.add_mood_event("miasma", /datum/mood_event/miasma/heavy)
	else
		breather.clear_mood_event("miasma")

/obj/item/organ/internal/lungs/safe_miasma(mob/living/carbon/breather, datum/gas_mixture/breath, old_miasma_pp)
	breather.clear_mood_event("miasma")
	return TRUE

/obj/item/organ/internal/lungs/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/goblin, while_present = PROC_REF(consume_goblin))


/obj/item/organ/internal/lungs/proc/consume_goblin(mob/living/carbon/breather, datum/gas_mixture/breath, goblin_pp, old_goblin_pp)

	if(goblin_pp >= 5)
		switch(rand(1,3))
			if(1)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_medicine, min(goblin_pp*0.25,10))
			if(2)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_toxic, min(goblin_pp*0.25,10))
			if(3)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_drug, min(goblin_pp*0.25,10))


