//Unifying vox brains and android brains, so that when one is updated the other is as well.

//The accessible cybernetic brain
/obj/item/organ/brain/cybernetic/cortical
	name = "cortically-augmented brain"
	desc = "A brain which has been, in some part, mechanized."
	icon = 'modular_skyrat/master_files/icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-c"
	organ_flags = ORGAN_ORGANIC | ORGAN_ROBOTIC | ORGAN_VITAL | ORGAN_PROMINENT //it's a bit weird to be both organic and robotic, but yk
	emp_dmg_mult = 1.5 //Note that the base damage is 20/10

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

//New vox Brain
/obj/item/organ/brain/cybernetic/cortical/vox
	name = "vox-augmented brain"
	desc = "A brain which has been in some part mechanized. The components are seamlessly integrated into the flesh, which protect that grey matter from biological processes."
	organ_flags = ORGAN_ROBOTIC | ORGAN_VITAL | ORGAN_PROMINENT //Vox brains weren't organic originally. See no reason to change it
	emp_dmg_mult = 1 //20/10 is the voxs' original damage factor
	emp_dmg_max = 150 //this was originally in vox stuffs, as well

//surplus; unused
//note that this is a direct child of the android brain, and is thus not organic
/obj/item/organ/brain/cybernetic/surplus
	name = "surplus augmented brain"
	desc = "A mostly-mechanized brain. Not much of the flesh remains. Does this make them an IPC?"
	maxHealth = BRAIN_DAMAGE_DEATH*0.75 //200 -> 150, per original intention
	emp_dmg_mult = 1.5 //Note that the base damage is 20/10
	emp_dmg_max = 999

/obj/item/organ/brain/cybernetic/surplus/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dangerous_organ_removal, /*surgical = */ TRUE, /*annihilate = */ FALSE) //annihilate just means it wont qdel when removed
