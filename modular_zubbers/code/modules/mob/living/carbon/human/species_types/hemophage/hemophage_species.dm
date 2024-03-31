/datum/species/hemophage
	inherent_biotypes = MOB_HUMANOID | MOB_ORGANIC | MOB_VAMPIRIC
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mhuman,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mhuman,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mhuman,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mhuman,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mhuman,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mhuman,
	)

// MUTANT COLOR OVERRIDE

/datum/species/hemophage/New()
	inherent_traits |= list(
		TRAIT_MUTANT_COLORS,
	)
	. = ..()

// BLOODSUCKER SPECIFIC FIXES
/datum/species/hemophage/on_bloodsucker_gain(mob/living/carbon/human/target)
	to_chat(target, span_warning("Your hemophage features have been removed, your nature as a bloodsucker abates the hemophage virus."))
	// Without this any new organs would get corrupted again.
	target.RemoveElement(/datum/element/tumor_corruption)
	for(var/obj/item/organ/internal/organ in target.organs)
		organ.RemoveElement(/datum/element/tumor_corruption)
	humanize_organs(target)

/datum/species/hemophage/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)
