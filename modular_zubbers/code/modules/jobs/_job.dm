/datum/job
	/// The job's outfit that will be assigned for Vox
	var/vox_outfit = null
	/// The job's outfit that will be assigned for Akula
	var/akula_outfit = null

/datum/job/prisoner
	banned_augments = list(/obj/item/organ/cyberimp/arm/toolkit/razor_claws/left_arm, /obj/item/organ/cyberimp/arm/toolkit/razor_claws/right_arm)
