//Unifying vox brains and android brains, so that when one is updated the other is as well.

//The accessible cybernetic brain
/obj/item/organ/brain/cybernetic/cortical
	name = "cortically-augmented brain"
	desc = "A brain which has been in some part mechanized."
	icon = 'modular_skyrat/master_files/icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-c"
	emp_dmg_mult = 1.5 //Note that the base damage is 20/10
	emp_dmg_max = 150

//Extra effects
/obj/item/organ/brain/cybernetic/cortical/emp_act(severity)
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
/obj/item/organ/brain/cybernetic/cortical/brain_damage_examine()
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
/obj/item/organ/brain/cybernetic/cortical/vox
	name = "vox-augmented brain"
	desc = "A brain which has been in some part mechanized. The components are seamlessly integrated into the flesh."
	emp_dmg_mult = 1 //Nobody notices the brain damage anyways wink wink

//surplus; TBI to prosthetic organ quirk
/obj/item/organ/brain/cybernetic/cortical/surplus
	name = "surplus augmented brain"
	desc = "A brain which has been in some part mechanized. It looks a bit cheap."
	maxHealth = BRAIN_DAMAGE_DEATH*0.5 //200 -> 100, at time of creation
	emp_dmg_max = 999
