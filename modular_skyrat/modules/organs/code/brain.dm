//Unifying vox brains and android brains, so that when one is updated the other is as well.
//Vox and basic cybernetic (cortical) brains will have both the robotic and organic brain surgery options; while android only has robotic.

//The accessible cybernetic brain
/obj/item/organ/internal/brain/cybernetic/cortical
	name = "cortically-enhanced brain"
	desc = "A brain which has been in some part mechanized."
	icon = 'modular_skyrat/master_files/icons/obj/medical/organs/organs.dmi' 
	icon_state = "brain-c"

//More damage from EMPs, and visual effects	
/obj/item/organ/internal/brain/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(owner.stat == DEAD)
		return
	switch(severity)
		if(1)
			to_chat(owner, span_boldwarning("You feel [pick("like your brain is being fried", "a sharp pain in your head")]!"))
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20, 150)
			owner.set_jitter_if_lower(30 SECONDS)
			owner.adjust_stutter(30 SECONDS)
			owner.adjust_confusion(10 SECONDS)
		if(2)
			to_chat(owner, span_warning("You feel [pick("disoriented", "confused", "dizzy")]."))
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10, 150)
			owner.set_jitter_if_lower(30 SECONDS)
			owner.adjust_stutter(30 SECONDS)
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
