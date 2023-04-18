/datum/species
	///Replaces default bladder with a different organ.
	var/obj/item/organ/internal/bladder/mutantbladder = /obj/item/organ/internal/bladder


/mob/living/carbon/human/handle_hydration()
	return dna?.species?.handle_hydration(src)

/mob/living/carbon/human/handle_urination()
	return dna?.species?.handle_urination(src)

/datum/species/proc/handle_hydration(mob/living/carbon/human/human)
	if(HAS_TRAIT(human, TRAIT_NOTHIRST))
		return FALSE

	// hydration decrease wowie
	if(human.hydration > 0 && human.stat != DEAD)
		// THEY hydrate
		var/dehydration_rate = THIRST_FACTOR
		if(human.mob_mood.sanity > SANITY_DISTURBED)
			dehydration_rate *= max(0.5, 1 - 0.002 * human.mob_mood.sanity) //0.85 to 0.75

		var/obj/item/organ/internal/bladder/bladder = human.getorganslot(ORGAN_SLOT_BLADDER)
		if(bladder)
			dehydration_rate *= bladder.get_urination_gain()

		if(dehydration_rate > 0 && !HAS_TRAIT(human, TRAIT_NO_PISSING))
			human.adjust_urination(dehydration_rate)
		human.adjust_hydration(-dehydration_rate)

	human.hud_used?.hydration?.update_icon()

/datum/species/proc/handle_urination(mob/living/carbon/human/human)
	if(HAS_TRAIT(human, TRAIT_NO_PISSING))
		human.urination = 0
		return //girls dont piss
	switch(human.urination)
		if(URINATION_LEVEL_PISSY to URINATION_LEVEL_VERY_PISSY)
			if(prob(4))
				to_chat(human, span_danger("You need to piss."))
		if(URINATION_LEVEL_VERY_PISSY to URINATION_LEVEL_PISSENCUMMEN)
			if(prob(6))
				to_chat(human, span_danger("You <b>really</b> need to piss."))
		if(URINATION_LEVEL_PISSENCUMMEN to URINATION_LEVEL_PISS_PANTS)
			if(prob(3))
				human.urinate()
			else if(prob(15))
				to_chat(human, span_danger("You're gonna <b>PISS YOURSELF</b>!"))
		if(URINATION_LEVEL_PISS_PANTS to INFINITY)
			human.urinate()
