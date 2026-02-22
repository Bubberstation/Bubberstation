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

/datum/reagent/toxin/khara/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	. = ..()

	var/obj/item/organ/lungs/L = M.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(!L || !(L.organ_flags & ORGAN_ORGANIC))
		return

	if(M.reagents.has_reagent(/datum/reagent/medicine/spaceacillin))
		return

	if(SPT_PROB(35, seconds_per_tick))
		M.emote("cough")

	if(SPT_PROB(10, seconds_per_tick))
		M.ForceContractDisease(new /datum/disease/khara(), del_on_fail = TRUE)
