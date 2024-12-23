//Unifying vox brains and android brains, so that when one is updated the other is as well.

//The accessible cybernetic brain
/obj/item/organ/internal/brain/cybernetic/cortical
	name = "cortically-enhanced brain"
	desc = "A brain which has been in some part mechanized."
	icon = 'modular_skyrat/master_files/icons/obj/medical/organs/organs.dmi' 
	icon_state = "brain-c"
	emp_dmg_mult = 1.25
	emp_dmg_max = 150

//Extra damage from EMPs, and visual effects
//Note that /obj/item/organ/internal/brain/cybernetic's base damage is capped at 190 while this one is capped at 150.
/obj/item/organ/internal/brain/cybernetic/cortical/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(owner.stat == DEAD)
		return
	switch(severity)
		if(1)
			owner.set_jitter_if_lower(30 SECONDS)
			owner.adjust_stutter(30 SECONDS)
			owner.adjust_confusion(10 SECONDS)
		if(2)
			owner.set_jitter_if_lower(15 SECONDS)
			owner.adjust_stutter(15 SECONDS)
			owner.adjust_confusion(3 SECONDS)
			

// It's still organic
/obj/item/organ/internal/brain/cybernetic/cortical/brain_damage_examine()
	if(suicided)
		return span_info("Its circuitry is smoking slightly. They must not have been able to handle the stress of it all.")
	if(brainmob && (decoy_override || brainmob.client || brainmob.get_ghost()))
		if(organ_flags & ORGAN_FAILING)
			return span_info("It seems to still have a bit of energy within it, but it's rather damaged... You may be able to restore it with some <b>mannitol</b>.")
		else if(damage >= BRAIN_DAMAGE_DEATH*0.5)
			return span_info("You can feel the small spark of life still left in this one, but it's got some bruises. You may be able to restore it with some <b>mannitol</b>.")
		else
			return span_info("You can feel the small spark of life still left in this one.")
	else
		return span_info("This one is completely devoid of life.")
	
//New vox Brain
/obj/item/organ/internal/brain/cybernetic/cortical/vox
	name = "vox brain"
	desc = "A brain which has been in some part mechanized. The components are seamlessly integrated into the flesh."
	emp_dmg_mult = 1 //vox get a little treat

//surplus
/obj/item/organ/internal/brain/cybernetic/cortical/surplus
	name = "cortically-enhanced brain"
	desc = "A brain which has been in some part mechanized."
	maxHealth = BRAIN_DAMAGE_DEATH*0.5
	emp_dmg_max = 999
