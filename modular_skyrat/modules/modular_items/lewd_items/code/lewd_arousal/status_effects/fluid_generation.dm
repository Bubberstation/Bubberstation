// These are effectively magic numbers.
#define AROUSAL_MULTIPLIER 25
#define TESTES_MULTIPLIER 235
#define NUTRITION_MULTIPLIER 100
#define NUTRITION_COST_MULTIPLIER 2
// Breasts have ungodly scaling at larger sizes, so the massive multiplier to ensure there's no runaway production makes sense here.
#define BREASTS_MULTIPLIER 11000
#define VAGINA_MULTIPLIER 250
#define VAGINA_FLUID_REMOVAL_AMOUNT -0.05
#define BASE_MULTIPLIER 5

/datum/status_effect/body_fluid_regen
	id = "body fluid regen"
	tick_interval = 5 SECONDS
	duration = STATUS_EFFECT_PERMANENT
	alert_type = null

//
// VAGINA
//

/datum/status_effect/body_fluid_regen/vagina
	id = "vagina fluid regen"

/datum/status_effect/body_fluid_regen/vagina/tick(seconds_between_ticks)
	var/mob/living/carbon/human/affected_human = owner
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp) || !istype(affected_human))
		return FALSE

	var/obj/item/organ/genital/vagina/vagina = owner.get_organ_slot(ORGAN_SLOT_VAGINA)
	if(!vagina)
		return FALSE

	if(affected_human.arousal > AROUSAL_LOW)
		var/regen = (affected_human.arousal / AROUSAL_MULTIPLIER) * (vagina.reagents.maximum_volume / VAGINA_MULTIPLIER) * BASE_MULTIPLIER
		vagina.reagents.add_reagent(vagina.internal_fluid_datum, regen)
	else
		vagina.reagents.remove_reagent(vagina.internal_fluid_datum, VAGINA_FLUID_REMOVAL_AMOUNT)

//
// BALLS
//

/datum/status_effect/body_fluid_regen/testes
	id = "testes fluid regen"

/datum/status_effect/body_fluid_regen/testes/tick(seconds_between_ticks)
	var/mob/living/carbon/human/affected_human = owner
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp) || !istype(affected_human))
		return FALSE

	var/obj/item/organ/genital/testicles/testes = owner.get_organ_slot(ORGAN_SLOT_TESTICLES)

	var/regen = (50 / AROUSAL_MULTIPLIER) * (testes.reagents.maximum_volume / TESTES_MULTIPLIER) * BASE_MULTIPLIER // this is really quite stupid, the bare number is replacing the arousal value previously there
	testes.reagents.add_reagent(testes.internal_fluid_datum, regen)

//
// BREASTS
//

/datum/status_effect/body_fluid_regen/breasts
	id = " breast milk regen"

/datum/status_effect/body_fluid_regen/breasts/tick(seconds_between_ticks)
	var/mob/living/carbon/human/affected_human = owner
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp) || !istype(affected_human))
		return FALSE

	var/obj/item/organ/genital/breasts/breasts = owner.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(!breasts || !breasts.lactates)
		return FALSE

	var/regen = ((owner.nutrition / (NUTRITION_LEVEL_WELL_FED / NUTRITION_MULTIPLIER)) / NUTRITION_MULTIPLIER) * (breasts.reagents.maximum_volume / BREASTS_MULTIPLIER) * BASE_MULTIPLIER
	if(breasts.reagents.total_volume < breasts.reagents.maximum_volume)
		var/free_space = breasts.reagents.maximum_volume
		var/occp_space = breasts.reagents.total_volume
		free_space -= occp_space // how much free space remaining?
		if(regen > free_space)
			regen = free_space // so we aren't draining nutrition for milk that isn't actually being generated
		owner.adjust_nutrition(-regen / NUTRITION_COST_MULTIPLIER)
		breasts.reagents.add_reagent(breasts.internal_fluid_datum, regen)

#undef AROUSAL_MULTIPLIER
#undef TESTES_MULTIPLIER
#undef NUTRITION_MULTIPLIER
#undef NUTRITION_COST_MULTIPLIER
#undef BREASTS_MULTIPLIER
#undef VAGINA_MULTIPLIER
#undef VAGINA_FLUID_REMOVAL_AMOUNT
#undef BASE_MULTIPLIER
