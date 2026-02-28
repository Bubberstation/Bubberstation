/datum/reagent/toxin/khara
	name = "Khara spores"
	description = "Microscopic bioengineered spores of alien origin. They aggressively colonize \
					organic tissues, inducing rapid, tumor-like growths that eventually birth a new predatory lifeform."
	color = COLOR_MAROON
	taste_description = "bitter iron and rot"
	taste_mult = 1.4
	chemical_flags = REAGENT_IGNORE_STASIS | REAGENT_INVISIBLE
	metabolization_rate = REAGENTS_METABOLISM * 4
	toxpwr = 0
	liver_damage_multiplier = 0
	silent_toxin = TRUE
	penetrates_skin = VAPOR

/datum/reagent/toxin/khara/metabolize_reagent(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	var/obj/item/organ/lungs/L = affected_mob.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!L || !(L.organ_flags & ORGAN_ORGANIC))
		return

	if(affected_mob.reagents.has_reagent(/datum/reagent/medicine/spaceacillin))
		return

	if(SPT_PROB(35, seconds_per_tick))
		affected_mob.emote("cough")

	if(SPT_PROB(10, seconds_per_tick))
		affected_mob.ForceContractDisease(new /datum/disease/khara(), del_on_fail = TRUE)
