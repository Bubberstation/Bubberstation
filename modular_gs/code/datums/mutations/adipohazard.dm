/datum/mutation/human/adipohazard
	name = "Adipohazard"
	desc = "A mutation that causes swelling upon touching the mutated person."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>Everything around you feels soft...</span>"
	text_lose_indication = "<span class='notice'>The soft feeling around you disappears.</span>"
	difficulty = 14
	instability = 30
	power_coeff = 1
	var/fat_add = 2

/datum/mutation/human/adipohazard/on_life()
	. = ..()
	if(owner.pulledby != null && iscarbon(owner.pulledby))
		var/mob/living/carbon/C = owner.pulledby
		var/pwr = GET_MUTATION_POWER(src)
		C.adjust_fatness(get_fatness_bonus(owner) + (fat_add * pwr), FATTENING_TYPE_RADIATIONS)
		if(C.grab_state >= GRAB_AGGRESSIVE)
			C.adjust_fatness(get_fatness_bonus(owner) + ((fat_add * 2) * pwr), FATTENING_TYPE_RADIATIONS)
		if(prob(5))
			var/add_text = pick("You feel softer.", "[owner] feels warm to the touch", "It's so nice to touch [owner].", "You don't want to let go of [owner].")
			to_chat(C, "<span class='notice'>[add_text]</span>")
	if(owner.pulling != null && iscarbon(owner.pulling))
		var/mob/living/carbon/C = owner.pulling
		var/pwr = GET_MUTATION_POWER(src)
		C.adjust_fatness(get_fatness_bonus(owner) + (fat_add * pwr), FATTENING_TYPE_RADIATIONS)
		if(C.grab_state >= GRAB_AGGRESSIVE)
			C.adjust_fatness(get_fatness_bonus(owner) + ((fat_add * 2) * pwr), FATTENING_TYPE_RADIATIONS)
		if(prob(5))
			var/add_text = pick("You feel softer.", "[owner] feels warm to the touch", "It's so nice for [owner] to touch.", "You don't want [owner] to let go of you.")
			to_chat(C, "<span class='notice'>[add_text]</span>")

/datum/mutation/human/adipohazard/proc/get_fatness_bonus(mob/living/carbon/user)
	var/fatness_level = get_fatness_level_name(user.fatness)
	var/fatness_bonus = 0
	switch(fatness_level)
		if("Fat", "Fatter")
			fatness_bonus = 1
		if("Very Fat", "Obese")
			fatness_bonus = 2
		if("Very Obese", "Extremely Obese")
			fatness_bonus = 3
		if("Barely Mobile", "Immobile")
			fatness_bonus = 4
		if("Blob")
			fatness_bonus = 5
	return fatness_bonus

/datum/mutation/human/adipohazard/proc/fatten(mob/living/carbon/toucher, amount = 1)
	toucher.adjust_fatness(get_fatness_bonus(owner) + (amount * GET_MUTATION_POWER(src)), FATTENING_TYPE_RADIATIONS)
	to_chat(toucher, "<span class='notice'>That felt so nice!</span>")

/obj/item/dnainjector/antiadipohazard
	name = "\improper DNA injector (Anti-Adipohazard)"
	desc = "No hugs?"
	remove_mutations = list(ADIPOHAZARD)

/obj/item/dnainjector/adipohazard
	name = "\improper DNA injector (Adipohazard)"
	desc = "It's hugs time!"
	add_mutations = list(ADIPOHAZARD)

/mob/living/carbon/help_shake_act(mob/living/carbon/M)
	. = ..()

	var/datum/mutation/human/adipohazard/touched_mutation
	for(var/datum/mutation/human/adipohazard/HM in dna.mutations)
		if(istype(HM, /datum/mutation/human/adipohazard))
			touched_mutation = HM

	var/datum/mutation/human/adipohazard/touching_mutation
	for(var/datum/mutation/human/adipohazard/HM in M.dna.mutations)
		if(istype(HM, /datum/mutation/human/adipohazard))
			touching_mutation = HM

	if(on_fire)
		return
	if(M == src && check_self_for_injuries())
		return

	if(touched_mutation)
		if(health >= 0 && !(HAS_TRAIT(src, TRAIT_FAKEDEATH)))
			if(mob_run_block(M, 0, M.name, ATTACK_TYPE_UNARMED, 0, null, null, null))
				return
			if(lying)
				if(buckled)
					return
				touched_mutation.fatten(M, 5)
			else if(M.zone_selected == BODY_ZONE_PRECISE_MOUTH)
				touched_mutation.fatten(M, 1)
			else if(check_zone(M.zone_selected) == BODY_ZONE_HEAD)
				touched_mutation.fatten(M, 3)
			else if(check_zone(M.zone_selected) == BODY_ZONE_R_ARM || check_zone(M.zone_selected) == BODY_ZONE_L_ARM)
				if((pulling == M) && (grab_state == GRAB_PASSIVE))
					touched_mutation.fatten(M, 2)
				else
					touched_mutation.fatten(M, 1)
			else
				touched_mutation.fatten(M, 5)

	if(touching_mutation)
		if(health >= 0 && !(HAS_TRAIT(src, TRAIT_FAKEDEATH)))
			if(mob_run_block(M, 0, M.name, ATTACK_TYPE_UNARMED, 0, null, null, null))
				return
			if(lying)
				if(buckled)
					return
				touching_mutation.fatten(src, 5)
			else if(M.zone_selected == BODY_ZONE_PRECISE_MOUTH)
				touching_mutation.fatten(src, 1)
			else if(check_zone(M.zone_selected) == BODY_ZONE_HEAD)
				touching_mutation.fatten(src, 3)
			else if(check_zone(M.zone_selected) == BODY_ZONE_R_ARM || check_zone(M.zone_selected) == BODY_ZONE_L_ARM)
				if((pulling == M) && (grab_state == GRAB_PASSIVE))
					touching_mutation.fatten(src, 2)
				else
					touching_mutation.fatten(src, 1)
			else
				touching_mutation.fatten(src, 5)

/mob/living/carbon/human/kisstarget(mob/living/L)
	. = ..()
	if(isliving(L))
		if(iscarbon(L))
			var/datum/mutation/human/adipohazard/touched_mutation
			var/mob/living/carbon/C = L
			for(var/datum/mutation/human/adipohazard/HM in C.dna.mutations)
				if(istype(HM, /datum/mutation/human/adipohazard))
					touched_mutation = HM
			if(touched_mutation)
				touched_mutation.fatten(src, 10)

			var/datum/mutation/human/adipohazard/touching_mutation
			for(var/datum/mutation/human/adipohazard/HM in dna.mutations)
				if(istype(HM, /datum/mutation/human/adipohazard))
					touching_mutation = HM
			if(touching_mutation)
				touching_mutation.fatten(L, 10)

/datum/species/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	. = ..()
	var/aim_for_mouth = user.zone_selected == "mouth"
	var/target_on_help = target.a_intent == INTENT_HELP
	var/target_aiming_for_mouth = target.zone_selected == "mouth"
	var/target_restrained = target.restrained()
	var/same_dir = (target.dir & user.dir)
	var/aim_for_groin  = user.zone_selected == "groin"
	var/target_aiming_for_groin = target.zone_selected == "groin"

	var/opposite_dir = user.dir == DIRFLIP(target.dir)

	var/datum/mutation/human/adipohazard/touched_mutation
	for(var/datum/mutation/human/adipohazard/HM in target.dna.mutations)
		if(istype(HM, /datum/mutation/human/adipohazard))
			touched_mutation = HM

	var/datum/mutation/human/adipohazard/touching_mutation
	for(var/datum/mutation/human/adipohazard/HM in user.dna.mutations)
		if(istype(HM, /datum/mutation/human/adipohazard))
			touching_mutation = HM

	if(touched_mutation != null && target != user)
		if(!IS_STAMCRIT(user))
			if(aim_for_mouth && ( target_on_help || target_restrained || target_aiming_for_mouth))
				touched_mutation.fatten(user, 4)
			else if(aim_for_groin && (target == user || target.lying || same_dir || opposite_dir) && (target_on_help || target_restrained || target_aiming_for_groin))
				touched_mutation.fatten(user, 5)
			else
				touched_mutation.fatten(user, 5)

	if(touching_mutation != null && target != user)
		if(!IS_STAMCRIT(user))
			if(aim_for_mouth && ( target_on_help || target_restrained || target_aiming_for_mouth))
				touching_mutation.fatten(target, 4)
			else if(aim_for_groin && (target == user || target.lying || same_dir || opposite_dir) && (target_on_help || target_restrained || target_aiming_for_groin))
				touching_mutation.fatten(target, 5)
			else
				touching_mutation.fatten(target, 2)
