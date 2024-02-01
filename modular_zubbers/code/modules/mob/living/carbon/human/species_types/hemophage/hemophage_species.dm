/datum/species/hemophage
	inherent_biotypes = MOB_HUMANOID | MOB_ORGANIC | MOB_VAMPIRIC

/datum/species/hemophage/on_bloodsucker_gain(mob/living/carbon/human/target)
	to_chat(target, span_warning("Your hemophage features have been removed, your nature as a bloodsucker abates the hemophage virus."))
	// Without this any new organs would get corrupted again.
	target.RemoveElement(/datum/element/tumor_corruption)
	for(var/obj/item/organ/internal/organ in target.organs)
		organ.RemoveElement(/datum/element/tumor_corruption)
	humanize_organs(target)

/datum/species/hemophage/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)
