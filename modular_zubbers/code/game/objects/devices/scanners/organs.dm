/obj/item/organ/internal
	///The effects when this limb is damaged. Used by health analyzers.
	var/damage_description

/obj/item/organ/internal/brain
	damage_description = "Brain damage reduces the patient's skills, and causes brain traumas"

/obj/item/organ/internal/heart
	damage_description = "Damaged hearts cause reduced constitution, suffocation and pain. Broken hearts prevent revival until repaired."

/obj/item/organ/internal/lungs
	damage_description = "Damaged lungs cause suffocation, slowdown and slower endurance regeneration. Broken lungs significantly worsen these effects."

/obj/item/organ/internal/liver
	damage_description = "Damaged livers slowly increase toxin damage instead of healing it, take damage when processing toxins, become less effective at processing toxins, and deal toxin damage when processing toxins."

/obj/item/organ/internal/appendix
	damage_description = "Damaged appendix will increase toxin damage overtime until removed."

/obj/item/organ/internal/eyes
	damage_description = "Damaged eyes cause blurry vision. Dead eyes cause blindness."

/obj/item/organ/internal/ears
	damage_description = "Damaged ears cause hearing loss. Dead ears cause total deafness."

/obj/item/organ/proc/get_organ_status(advanced)
	if(advanced && (organ_flags & ORGAN_PROMINENT))
		return "Harmful Foreign Body"

	if(organ_flags & ORGAN_FAILING)
		return "Non-Functional"

	if(damage > high_threshold)
		return "Severely Damaged"

	if (damage > low_threshold)
		return "Mildly Damaged"

	return ""
