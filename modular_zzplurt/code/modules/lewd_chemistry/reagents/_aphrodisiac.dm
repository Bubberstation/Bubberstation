/datum/reagent/drug/aphrodisiac
	/// Largest size the chem can make a mob's butt
	var/butt_max_size = 8
	/// How much the butt is increased in size each time it's run
	var/butt_size_increase_step = 1
	/// Smallest size the chem can make a mob's butt
	var/butt_minimum_size = 1
	/// How much to reduce the size of the butt each time it's run
	var/butt_size_reduction_step = 1

	/// Largest size the chem can make a mob's belly
	var/belly_max_size = 7
	/// How much the belly is increased in size each time it's run
	var/belly_size_increase_step = 1
	/// Smallest size the chem can make a mob's belly
	var/belly_minimum_size = 1
	/// How much to reduce the size of the belly each time it's run
	var/belly_size_reduction_step = 1

	// Blud didn't even undefine the indexes in nonmodular code 💀💀💀
	#define GENITAL_BELLY 6
	#define GENITAL_BUTT 7

/**
* Handle belly growth
*
* exposed_mob - the mob being affected by the reagent
* suppress_chat - whether or not to display a message in chat
* mob_belly - the belly to cause to grow
*/
/datum/reagent/drug/aphrodisiac/proc/grow_belly(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/belly/mob_belly = exposed_mob?.get_organ_slot(ORGAN_SLOT_BELLY))
	if(!mob_belly)
		return

	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/belly_enlargement))
		return

	enlargement_amount += enlarger_increase_step

	if(enlargement_amount >= enlargement_threshold)
		if(mob_belly?.genital_size >= belly_max_size)
			return

		mob_belly.genital_size = min(mob_belly.genital_size + belly_size_increase_step, belly_max_size)
		update_appearance(exposed_mob, mob_belly)
		enlargement_amount = 0

		growth_to_chat(exposed_mob, mob_belly, suppress_chat)

	// Damage from being too big for clothes
	if((mob_belly?.genital_size >= (belly_max_size - 2)) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		if(prob(damage_chance))
			to_chat(exposed_mob, span_danger("Your belly strains against your clothes!"))
			exposed_mob.adjustOxyLoss(5)
			exposed_mob.apply_damage(1, BRUTE, exposed_mob.get_bodypart(BODY_ZONE_CHEST))

/**
* Handle butt growth
*
* exposed_mob - the mob being affected by the reagent
* suppress_chat - whether or not to display a message in chat
* mob_butt - the butt to cause to grow
*/
/datum/reagent/drug/aphrodisiac/proc/grow_butt(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/butt/mob_butt = exposed_mob?.get_organ_slot(ORGAN_SLOT_BUTT))
	if(!mob_butt)
		return

	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/butt_enlargement))
		return

	enlargement_amount += enlarger_increase_step

	if(enlargement_amount >= enlargement_threshold)
		if(mob_butt?.genital_size >= butt_max_size)
			return

		mob_butt.genital_size = min(mob_butt.genital_size + butt_size_increase_step, butt_max_size)
		update_appearance(exposed_mob, mob_butt)
		enlargement_amount = 0

		growth_to_chat(exposed_mob, mob_butt, suppress_chat)

	// Damage from being too big for clothes
	if((mob_butt?.genital_size >= (butt_max_size - 2)) && (exposed_mob.w_uniform || exposed_mob.wear_suit))
		if(prob(damage_chance))
			to_chat(exposed_mob, span_danger("Your bottom strains against your clothes!"))
			exposed_mob.apply_damage(1, BRUTE, exposed_mob.get_bodypart(BODY_ZONE_PRECISE_GROIN))

/**
* Handle belly creation
*
* exposed_mob - the mob being affected by the reagent
* suppress_chat - whether or not to display a message in chat
* mob_belly - the mob's belly
*/
/datum/reagent/drug/aphrodisiac/proc/create_belly(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/belly/mob_belly = exposed_mob?.get_organ_slot(ORGAN_SLOT_BELLY))
	if(mob_belly)
		return

	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/new_genitalia_growth))
		return

	var/obj/item/organ/external/genital/belly/new_belly = new
	new_belly.build_from_dna(exposed_mob.dna, ORGAN_SLOT_BELLY)
	new_belly.Insert(exposed_mob, 0, FALSE)
	new_belly.genital_size = belly_minimum_size
	update_appearance(exposed_mob, new_belly)

	if(!suppress_chat)
		to_chat(exposed_mob, span_purple("Your midsection feels warm as it begins to expand outward."))

/**
* Handle butt creation
*
* exposed_mob - the mob being affected by the reagent
* suppress_chat - whether or not to display a message in chat
* mob_butt - the mob's butt
*/
/datum/reagent/drug/aphrodisiac/proc/create_butt(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/butt/mob_butt = exposed_mob?.get_organ_slot(ORGAN_SLOT_BUTT))
	if(mob_butt)
		return

	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/new_genitalia_growth))
		return

	var/obj/item/organ/external/genital/butt/new_butt = new
	new_butt.build_from_dna(exposed_mob.dna, ORGAN_SLOT_BUTT)
	new_butt.Insert(exposed_mob, 0, FALSE)
	new_butt.genital_size = butt_minimum_size
	update_appearance(exposed_mob, new_butt)

	if(!suppress_chat)
		to_chat(exposed_mob, span_purple("Your bottom feels warm as it begins to expand outward."))

/**
* Handle belly shrinkage
*
* exposed_mob - the mob being affected by the reagent
* suppress_chat - whether or not to display a message in chat
* mob_belly - the belly to shrink
* message - the message to send to chat
*/
/datum/reagent/drug/aphrodisiac/proc/shrink_belly(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/belly/mob_belly = exposed_mob?.get_organ_slot(ORGAN_SLOT_BELLY))
	if(!mob_belly)
		return

	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/belly_shrinkage))
		return

	if(mob_belly.genital_size > belly_minimum_size)
		mob_belly.genital_size = max(mob_belly.genital_size - belly_size_reduction_step, belly_minimum_size)
		update_appearance(exposed_mob, mob_belly)

	else if(mob_belly.genital_size == belly_minimum_size)
		var/message = "Your belly has completely flattened out."
		remove_genital(exposed_mob, mob_belly, suppress_chat, message)

/**
* Handle butt shrinkage
*
* exposed_mob - the mob being affected by the reagent
* suppress_chat - whether or not to display a message in chat
* mob_butt - the butt to shrink
* message - the message to send to chat
*/
/datum/reagent/drug/aphrodisiac/proc/shrink_butt(mob/living/carbon/human/exposed_mob, suppress_chat = FALSE, obj/item/organ/external/genital/butt/mob_butt = exposed_mob?.get_organ_slot(ORGAN_SLOT_BUTT))
	if(!mob_butt)
		return

	if(!exposed_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp/butt_shrinkage))
		return

	if(mob_butt.genital_size > butt_minimum_size)
		mob_butt.genital_size = max(mob_butt.genital_size - butt_size_reduction_step, butt_minimum_size)
		update_appearance(exposed_mob, mob_butt)

	else if(mob_butt.genital_size == butt_minimum_size)
		var/message = "Your bottom has completely flattened out."
		remove_genital(exposed_mob, mob_butt, suppress_chat, message)

/**
* Handle shrinkage of genitals
*
* exposed_mob - the mob being affected by the reagent
* suppress_chat - whether or not to display a message in chat
* genitals_to_shrink - the genitals to shrink
*/
/datum/reagent/drug/aphrodisiac/shrink_genitals(mob/living/carbon/human/exposed_mob, suppress_chat, list/genitals_to_shrink)
	. = ..()
	for(var/mob_genital in genitals_to_shrink)
		switch(mob_genital)
			if(GENITAL_BELLY)
				shrink_belly(exposed_mob, suppress_chat)
			if(GENITAL_BUTT)
				shrink_butt(exposed_mob, suppress_chat)
