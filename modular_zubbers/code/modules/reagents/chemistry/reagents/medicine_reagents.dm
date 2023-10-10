/datum/reagent/medicine/xlasyn
	name = "Xlasyn"
	description = "A chemical compound of Synthflesh and Clonexadone that specializes in treating small amounts of organ damage. Metabolism only works while in very cold temperatures."
	color = "#c4603c"
	taste_description = "organ tissue"
	ph = 13
	burning_temperature = 30
	burning_volume = 0.2
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/medicine/xlasyn/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(affected_mob.bodytemperature < T0C)
		var/base_heal = REAGENTS_METABOLISM * (0.00001 * (affected_mob.bodytemperature ** 2) + 0.5)*0.1
		if(base_heal >= 0.1)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_APPENDIX,base_heal*0.1)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN,base_heal*0.1)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_EARS,base_heal*0.25)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_EYES,base_heal*0.25)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_HEART,base_heal*0.25)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_LIVER,base_heal*0.5)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_LUNGS,base_heal)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_STOMACH,base_heal*0.5)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_TONGUE,base_heal*0.25)
			affected_mob.adjustOrganLoss(ORGAN_SLOT_VOICE,base_heal*0.25)
		. = TRUE
	..()

/datum/reagent/medicine/coagulant/synthetic
	name = "Synuirite"
	description = "A synthetic knockoff of the proprietary coagulant used to help bleeding wounds clot faster."
	color = "#bb5974"
	taste_description = "sour saltwater"
	ph = 12
	metabolization_rate = 0.125 * REAGENTS_METABOLISM
	overdose_threshold = 15
	clot_rate = 0.1
	passive_bleed_modifier = 0.86
