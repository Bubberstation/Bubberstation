/obj/item/organ/lungs/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/goblin, while_present = PROC_REF(consume_goblin))


/obj/item/organ/lungs/proc/consume_goblin(mob/living/carbon/breather, datum/gas_mixture/breath, goblin_pp, old_goblin_pp)

	if(goblin_pp >= 5)
		switch(rand(1,3))
			if(1)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_medicine, min(goblin_pp*0.25,10))
			if(2)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_toxic, min(goblin_pp*0.25,10))
			if(3)
				breather.reagents.add_reagent(SSair.chosen_goblin_reagent_drug, min(goblin_pp*0.25,10))


