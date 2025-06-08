/mob/living
	var/burpslurring = 0 //GS13 - necessary due to "say" being defined by mob/living

/mob/living/carbon
	//Due to the changes needed to create the system to hide fatness, here's some notes:
	// -If you are making a mob simply gain or lose weight, use adjust_fatness. Try to not touch the variables directly unless you know 'em well
	// -fatness is the value a mob is being displayed and calculated as by most things. Changes to fatness are not permanent
	// -fatness_real is the value a mob is actually at, even if it's being hidden. For permanent changes, use this one
	//What level of fatness is the parent mob currently at?
	var/fatness = 0
	//The list of items/effects that are being added/subtracted from our real fatness
	var/fat_hiders = list()
	//The actual value a mob is at. Is equal to fatness if fat_hider is FALSE.
	var/fatness_real = 0
	//Permanent fatness, which sticks around between rounds
	var/fatness_perma = 0
	///At what rate does the parent mob gain weight? 1 = 100%
	var/weight_gain_rate = 1
	//At what rate does the parent mob lose weight? 1 = 100%
	var/weight_loss_rate = 1
	//Variable related to door stuckage code
	var/doorstuck = 0
	/// What is the maximum amount of weight we can put on?
	var/max_weight

	var/fullness = FULLNESS_LEVEL_HALF_FULL
	var/fullness_reduction_timer = 0 // When was the last time they emoted to reduce their fullness

	/// How many mobs have been digested by this mob?
	var/prey_digested = 0
	/// How many humanoid mobs have been digested by this mob?
	var/human_prey_digested = 0

/**
* Adjusts the fatness level of the parent mob.
*
* * adjustment_amount - adjusts how much weight is gained or loss. Positive numbers add weight.
* * type_of_fattening - what type of fattening is being used. Look at the traits in fatness.dm for valid options.
* * ignore_rate - do we want to ignore the mob's weight gain/loss rate? This is only here for niche uses.
*/
/mob/living/carbon/proc/adjust_fatness(adjustment_amount, type_of_fattening = FATTENING_TYPE_ITEM, ignore_rate = FALSE)
	if(!adjustment_amount || !type_of_fattening)
		return FALSE

	if(!HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER) && client?.prefs)
		if(!check_weight_prefs(type_of_fattening))
			return FALSE

	var/amount_to_change = adjustment_amount
	if(!ignore_rate)
		if(adjustment_amount > 0)
			amount_to_change = amount_to_change * weight_gain_rate
		else
			amount_to_change = amount_to_change * weight_loss_rate

	fatness_real += amount_to_change
	fatness_real = max(fatness_real, MINIMUM_FATNESS_LEVEL) //It would be a little silly if someone got negative fat.

	if(max_weight) // GS13
		fatness_real = min(fatness_real, (max_weight - 1))

	fatness = fatness_real //Make their current fatness their real fatness

	hiders_apply()	//Check and apply hiders
	perma_apply()	//Check and apply for permanent fat
	xwg_resize()	//Apply XWG

	// Handle Awards
	if(client)
		if(fatness > FATNESS_LEVEL_BLOB)
			client.give_award(/datum/award/achievement/fat/blob, src)
		if(fatness > 10000)
			client.give_award(/datum/award/achievement/fat/milestone_one, src)
		if(fatness > 25000)
			client.give_award(/datum/award/achievement/fat/milestone_two, src)
		if(fatness > 50000)
			client.give_award(/datum/award/achievement/fat/milestone_three, src)
		if(fatness > 100000)
			client.give_award(/datum/award/achievement/fat/milestone_four, src)
		if(fatness > 500000)
			client.give_award(/datum/award/achievement/fat/milestone_five, src)
		if(fatness > 1000000)
			client.give_award(/datum/award/achievement/fat/milestone_six, src)
		if(fatness > 10000000)
			client.give_award(/datum/award/achievement/fat/milestone_seven, src)

	return TRUE

/mob/living/carbon/fully_heal(admin_revive)
	fatness = 0
	fatness_real = 0
	. = ..()

///Checks the parent mob's prefs to see if they can be fattened by the fattening_type
/mob/living/carbon/proc/check_weight_prefs(type_of_fattening = FATTENING_TYPE_ITEM)
	if(HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER) && !client.prefs) //Comment this second part out
		return TRUE

	if(!client?.prefs || !type_of_fattening)
		return FALSE

	switch(type_of_fattening)
		if(FATTENING_TYPE_ITEM)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_items))
				return FALSE

		if(FATTENING_TYPE_FOOD)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_food))
				return FALSE

		if(FATTENING_TYPE_CHEM)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_chems))
				return FALSE

		if(FATTENING_TYPE_WEAPON)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_weapons))
				return FALSE

		if(FATTENING_TYPE_MAGIC)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_magic))
				return FALSE

		if(FATTENING_TYPE_VIRUS)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_viruses))
				return FALSE

		if(FATTENING_TYPE_NANITES)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_nanites))
				return FALSE

		if(FATTENING_TYPE_ATMOS)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_atmos))
				return FALSE

		if(FATTENING_TYPE_WEIGHT_LOSS)
			if(HAS_TRAIT(src, TRAIT_WEIGHT_LOSS_IMMUNE))
				return FALSE

	return TRUE

	// THE FATNESS HIDING GUIDE!!!
	// HOW 2 FATNESS HIDE
	//Step 1) Grab a thing that will add or reduce fatness!
	//Step 2) Give it a character.hider_add(src) and a character.hider_remove(src) depending on the conditions you want it to meet for which it will add or remove itself from messing with a character's fatness!
	//Step 3) Give it a proc/fat_hide([character argument]), with a return that will give the amount to shift that character's fatness by!
	//Step 4) There is no step 4, you did it bucko!
	//Wanna see an example? Search for /obj/item/bluespace_belt !!!

/mob/living/carbon/proc/hider_add(hide_source)
	if(!(hide_source in fat_hiders))
		fat_hiders += hide_source

	return TRUE

/mob/living/carbon/proc/hider_remove(hide_source)
	if(hide_source in fat_hiders)
		fat_hiders -= hide_source
	return TRUE

/mob/living/carbon/proc/hiders_calc()
	var/hiders_value = 0
	for(var/hider in fat_hiders)
		var/hide_values = hider:fat_hide(src)
		if(!islist(hide_values))
			hiders_value += hide_values
		else
			for(var/hide_value in hide_values)
				hiders_value += hide_value
	return hiders_value

/mob/living/carbon/proc/hiders_apply()
	if(fat_hiders) //do we have any hiders active?
		var/fatness_over = hiders_calc() //calculate the sum of all hiders
		fatness = fatness + fatness_over //Then, make their current fatness the sum of their real plus/minus the calculated amount
		if(max_weight) //Check their prefs
			fatness = min(fatness, (max_weight - 1)) //And make sure it's not above their preferred max

/mob/living/carbon/proc/perma_apply()
	if(fatness_perma > 0)	//Check if we need to make calcs at all
		fatness = fatness + fatness_perma	//Add permanent fat to fatness
		if(max_weight)	//Check for max weight prefs
			fatness = min(fatness, (max_weight - 1))	//Apply max weight prefs

/mob/living/carbon/proc/adjust_perma(adjustment_amount, type_of_fattening = FATTENING_TYPE_ITEM)
	/// we will fix this later
	/*
	return TRUE

	if(!client)
		return FALSE
	if(!client.prefs.weight_gain_permanent)
		return FALSE

	if(!adjustment_amount || !type_of_fattening)
		return FALSE

	if(!HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER) && client?.prefs)
		if(!check_weight_prefs(type_of_fattening))
			return FALSE
	var/amount_to_change = adjustment_amount

	if(adjustment_amount > 0)
		amount_to_change = amount_to_change * weight_gain_rate
	else
		amount_to_change = amount_to_change * weight_loss_rate

	fatness_perma += amount_to_change
	fatness_perma = max(fatness_perma, MINIMUM_FATNESS_LEVEL)

	if(max_weight)
		fatness_perma = min(fatness_perma, (max_weight - 1))
	*/

/mob/living/carbon/human/handle_breathing(times_fired)
	. = ..()
	fatness = fatness_real
	hiders_apply()
	perma_apply()
	xwg_resize()

/proc/get_fatness_level_name(fatness_amount)
	if(fatness_amount < FATNESS_LEVEL_FAT)
		return "Normal"
	if(fatness_amount < FATNESS_LEVEL_FATTER)
		return "Fat"
	if(fatness_amount < FATNESS_LEVEL_VERYFAT)
		return "Fatter"
	if(fatness_amount < FATNESS_LEVEL_OBESE)
		return "Very Fat"
	if(fatness_amount < FATNESS_LEVEL_MORBIDLY_OBESE)
		return "Obese"
	if(fatness_amount < FATNESS_LEVEL_EXTREMELY_OBESE)
		return "Very Obese"
	if(fatness_amount < FATNESS_LEVEL_BARELYMOBILE)
		return "Extremely Obese"
	if(fatness_amount < FATNESS_LEVEL_IMMOBILE)
		return "Barely Mobile"
	if(fatness_amount < FATNESS_LEVEL_BLOB)
		return "Immobile"

	return "Blob"

/// Finds what the next fatness level for the parent mob would be based off of fatness_real.
/mob/living/carbon/proc/get_next_fatness_level()
	if(fatness_real < FATNESS_LEVEL_FAT)
		return FATNESS_LEVEL_FAT
	if(fatness_real < FATNESS_LEVEL_FATTER)
		return FATNESS_LEVEL_FATTER
	if(fatness_real < FATNESS_LEVEL_VERYFAT)
		return FATNESS_LEVEL_VERYFAT
	if(fatness_real < FATNESS_LEVEL_OBESE)
		return FATNESS_LEVEL_OBESE
	if(fatness_real < FATNESS_LEVEL_MORBIDLY_OBESE)
		return FATNESS_LEVEL_MORBIDLY_OBESE
	if(fatness_real < FATNESS_LEVEL_EXTREMELY_OBESE)
		return FATNESS_LEVEL_EXTREMELY_OBESE
	if(fatness_real < FATNESS_LEVEL_BARELYMOBILE)
		return FATNESS_LEVEL_BARELYMOBILE
	if(fatness_real < FATNESS_LEVEL_IMMOBILE)
		return FATNESS_LEVEL_IMMOBILE
	if(fatness_real < FATNESS_LEVEL_BLOB)
		return FATNESS_LEVEL_BLOB

	return FATNESS_LEVEL_BLOB

/// How much real fatness does the current mob have to gain until they reach the next level? Return FALSE if they are maxed out.
/mob/living/carbon/proc/fatness_until_next_level()
	var/needed_fatness = get_next_fatness_level() - fatness_real
	needed_fatness = max(needed_fatness, 0)

	return needed_fatness

/mob/living/carbon/proc/applyFatnessDamage(amount)
	if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_weapons)) // If we can't fatten them through weapons, apply stamina damage
		adjustStaminaLoss(amount)
		return TRUE

	var/fat_to_add = ((amount * CONFIG_GET(number/damage_multiplier)) * FAT_DAMAGE_TO_FATNESS)
	adjust_fatness(fat_to_add, FATTENING_TYPE_WEAPON)
	return fat_to_add

/* Fix this later.
/mob/living/carbon/proc/applyPermaFatnessDamage(amount)
	if(!client?.prefs?.weight_gain_permanent) // If we cant apply permafat, apply regular fat
		return applyFatnessDamage(amount)

	var/fat_to_add = ((amount * CONFIG_GET(number/damage_multiplier)) * PERMA_FAT_DAMAGE_TO_FATNESS)
	adjust_perma(fat_to_add, FATTENING_TYPE_WEAPON)
	return fat_to_add
*/
