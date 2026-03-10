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


//Cold cyber lungs
/obj/item/organ/lungs/adaptive/cold/cybernetic
	name = "cybernetic cold-engineered lungs"
	desc = "A set of cybernetic lungs engineered for low temperatures, though they are more susceptible to high temperatures and EMPs. Considerably more fragile than its organic counterpart."
	failing_desc = "seems to be broken."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "lungs-c"
	breath_noise = "a steady whirr"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5

//Hot cyber lungs
/obj/item/organ/lungs/adaptive/hot/cybernetic
	name = "cybernetic heat-engineered lungs"
	desc = "A set of cybernetic lungs built for high temperatures, though they are more susceptible to low temperatures and EMPs. Considerably more fragile than its organic counterpart."
	failing_desc = "seems to be broken."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "lungs-c"
	breath_noise = "a steady whirr"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5
	var/emp_vulnerability = 80 //Chance of permanent effects if emp-ed.

/obj/item/organ/lungs/adaptive/hot/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!COOLDOWN_FINISHED(src, severe_cooldown))
		owner.losebreath += 20
		COOLDOWN_START(src, severe_cooldown, 30 SECONDS)
	if(prob(emp_vulnerability/severity))
		organ_flags |= ORGAN_EMP

//Toxin cyber lungs
/obj/item/organ/lungs/adaptive/toxin/cybernetic
	name = "cybernetic toxin-adapted lungs"
	desc = "A set of cybernetic lungs built for toxic environments, though more susceptible to extreme temperatures and EMPs. Considerably more fragile than its organic counterpart."
	failing_desc = "seems to be broken."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "lungs-c"
	breath_noise = "a steady whirr"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5
	var/emp_vulnerability = 80 //Chance of permanent effects if emp-ed.

/obj/item/organ/lungs/adaptive/hot/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!COOLDOWN_FINISHED(src, severe_cooldown))
		owner.losebreath += 20
		COOLDOWN_START(src, severe_cooldown, 30 SECONDS)
	if(prob(emp_vulnerability/severity))
		organ_flags |= ORGAN_EMP

//Low Oxy cyber lungs
/obj/item/organ/lungs/adaptive/oxy/cybernetic
	name = "cybernetic low-oxygen lungs"
	desc = "A set of cybernetic lungs engineered for low oxygen environments, though more susceptible to extreme temperatures and EMPs. Considerably more fragile than its organic counterpart."
	failing_desc = "seems to be broken."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "lungs-c"
	breath_noise = "a steady whirr"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5
	var/emp_vulnerability = 80 //Chance of permanent effects if emp-ed.

/obj/item/organ/lungs/adaptive/hot/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!COOLDOWN_FINISHED(src, severe_cooldown))
		owner.losebreath += 20
		COOLDOWN_START(src, severe_cooldown, 30 SECONDS)
	if(prob(emp_vulnerability/severity))
		organ_flags |= ORGAN_EMP
