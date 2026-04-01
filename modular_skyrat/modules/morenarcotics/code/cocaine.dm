/datum/chemical_reaction/coca_paste
	results = list(/datum/reagent/drug/coca_paste = 5)
	required_reagents = list(/datum/reagent/drug/coca_powder = 10, /datum/reagent/toxin/acid/nitracid = 1, /datum/reagent/water = 9)
	required_temp = 300
	purity_min = 0
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_DRUG

/datum/chemical_reaction/cocaine
	results = list(/datum/reagent/drug/cocaine = 10)
	required_reagents = list(/datum/reagent/drug/coca_paste = 8, /datum/reagent/acetone = 2, /datum/reagent/toxin/acid = 2,)
	required_temp = 480 // cook it
	purity_min = 0
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_DRUG
	mix_message = "The solution thickens into a paste!"

/datum/chemical_reaction/powder_cocaine
	is_cold_recipe = TRUE
	required_reagents = list(/datum/reagent/drug/cocaine = 5)
	required_temp = 250 //freeze it
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_DRUG
	mix_message = "The solution freezes into a powder!"

/datum/chemical_reaction/powder_cocaine/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/cocaine(location)

/datum/chemical_reaction/crack_cooking
	required_reagents = list(/datum/reagent/drug/cocaine = 8, /datum/reagent/water = 12, /datum/reagent/ash = 4) // i wanted it to be ammonia but the space cleaner reaction...
	required_temp = 480 //cook it
	purity_min = 0
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_DRUG
	mix_message = "The solution solidifies into chunks!"

/datum/chemical_reaction/crack_cooking/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/crack(location)

/datum/movespeed_modifier/reagent/cocaine
	multiplicative_slowdown = -0.30

/datum/reagent/drug/cocaine
	name = "Cocaine"
	description = "A powerful stimulant extracted from coca leaves. Causes drowsiness and severe brain damage if overdosed."
	color = "#ffffff"
	overdose_threshold = 20
	ph = 9
	taste_description = "bitterness" //supposedly does taste bitter in real life
	addiction_types = list(/datum/addiction/stimulants = 17)
	metabolized_traits = list(TRAIT_ANALGESIA, TRAIT_BATON_RESISTANCE)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/cocaine/on_mob_metabolize(mob/living/metabolizer)
	..()
	metabolizer.add_movespeed_modifier(/datum/movespeed_modifier/reagent/cocaine)

/datum/reagent/drug/cocaine/on_mob_end_metabolize(mob/living/metabolizer)
	metabolizer.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/cocaine)
	..()

/datum/reagent/drug/cocaine/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	if(SPT_PROB(2.5, seconds_per_tick))
		var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("zoinked", /datum/mood_event/stimulant_heavy, name)
	M.AdjustStun(-15 * REM * seconds_per_tick)
	M.AdjustKnockdown(-15 * REM * seconds_per_tick)
	M.AdjustUnconscious(-15 * REM * seconds_per_tick)
	M.AdjustImmobilized(-15 * REM * seconds_per_tick)
	M.AdjustParalyzed(-15 * REM * seconds_per_tick)
	M.adjust_stamina_loss(-2 * REM * seconds_per_tick, 0)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote("shiver")
	..()
	. = TRUE

/datum/reagent/drug/cocaine/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("Your heart beats is beating so fast, it hurts..."))

/datum/reagent/drug/cocaine/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjust_tox_loss(5 * REM * seconds_per_tick, 0)
	M.adjust_organ_loss(ORGAN_SLOT_HEART, (rand(10, 20) / 10) * REM * seconds_per_tick, required_organ_flag = affected_organ_flags)
	M.set_jitter_if_lower(5 SECONDS)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote(pick("twitch","drool"))
	if(!HAS_TRAIT(M, TRAIT_FLOORED))
		if(SPT_PROB(1.5, seconds_per_tick))
			M.visible_message(span_danger("[M] collapses onto the floor!"))
			M.Paralyze(135,TRUE)
			M.drop_all_held_items()
	..()
	. = TRUE

/datum/reagent/drug/coca_powder
	name = "Coca Powder"
	description = "Ground-up and filtered coca leaves, mildly stimulating."
	color = "#20862f"
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/coca_powder/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	M.AdjustStun(-2 * REM * seconds_per_tick)
	M.AdjustKnockdown(-2 * REM * seconds_per_tick)
	M.AdjustUnconscious(-2 * REM * seconds_per_tick)
	M.AdjustImmobilized(-2 * REM * seconds_per_tick)
	M.AdjustParalyzed(-2 * REM * seconds_per_tick)
	..()
	. = TRUE

/datum/reagent/drug/coca_paste
	name = "Coca Paste"
	description = "An acidc paste containing high amount of cocaine and toxic chemicals used to process it - consumption is ill-advised."
	color = "#4e6444"
	ph = 5
	taste_description = "acidic sludge"
	addiction_types = list(/datum/addiction/stimulants = 17)
	metabolized_traits = list(TRAIT_ANALGESIA, TRAIT_BATON_RESISTANCE)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/coca_paste/on_mob_metabolize(mob/living/metabolizer)
	..()
	metabolizer.add_movespeed_modifier(/datum/movespeed_modifier/reagent/cocaine)

/datum/reagent/drug/coca_paste/on_mob_end_metabolize(mob/living/metabolizer)
	metabolizer.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/cocaine)
	..()

/datum/reagent/drug/coca_paste/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	M.adjust_fire_loss((volume/50) * REM * normalise_creation_purity() * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	M.adjust_tox_loss(3 * REM * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	if(SPT_PROB(2.5, seconds_per_tick))
		var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("zoinked", /datum/mood_event/stimulant_heavy, name)
	M.AdjustStun(-12 * REM * seconds_per_tick)
	M.AdjustKnockdown(-12 * REM * seconds_per_tick)
	M.AdjustUnconscious(-12 * REM * seconds_per_tick)
	M.AdjustImmobilized(-12 * REM * seconds_per_tick)
	M.AdjustParalyzed(-12 * REM * seconds_per_tick)
	M.adjust_stamina_loss(-2 * REM * seconds_per_tick, 0)
	if(SPT_PROB(20, seconds_per_tick))
		M.emote(pick("scream","twitch","shiver"))
	..()
	. = TRUE
	return UPDATE_MOB_HEALTH

/datum/reagent/drug/coca_paste/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("Your heart beats is beating so fast, it hurts..."))

/datum/reagent/drug/coca_paste/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjust_tox_loss(5 * REM * seconds_per_tick, 0)
	M.adjust_organ_loss(ORGAN_SLOT_HEART, (rand(10, 20) / 10) * REM * seconds_per_tick, required_organ_flag = affected_organ_flags)
	M.set_jitter_if_lower(5 SECONDS)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote(pick("twitch","drool"))
	if(!HAS_TRAIT(M, TRAIT_FLOORED))
		if(SPT_PROB(1.5, seconds_per_tick))
			M.visible_message(span_danger("[M] collapses onto the floor!"))
			M.Paralyze(135,TRUE)
			M.drop_all_held_items()
	..()
	. = TRUE

/datum/movespeed_modifier/reagent/crack
	multiplicative_slowdown = -0.40

/datum/reagent/drug/freebase_cocaine
	name = "Freebase Cocaine"
	description = "A smokable form of cocaine, Its higher bioavaliability results in a more intense high."
	color = "#f0e6bb"
	overdose_threshold = 15
	ph = 9 // it probably shouldnt be? but im too lazy to check it, and it was 9 because it was inhereiting
	taste_description = "crunchy bitterness"
	addiction_types = list(/datum/addiction/stimulants = 24) // even more addictive
	metabolized_traits = list(TRAIT_ANALGESIA, TRAIT_BATON_RESISTANCE)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/freebase_cocaine/on_mob_metabolize(mob/living/metabolizer)
	..()
	metabolizer.add_movespeed_modifier(/datum/movespeed_modifier/reagent/crack)

/datum/reagent/drug/freebase_cocaine/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	if(SPT_PROB(2.5, seconds_per_tick))
		var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("zoinked", /datum/mood_event/stimulant_heavy, name)
	M.AdjustStun(-18 * REM * seconds_per_tick)
	M.AdjustKnockdown(-18 * REM * seconds_per_tick)
	M.AdjustUnconscious(-18 * REM * seconds_per_tick)
	M.AdjustImmobilized(-18 * REM * seconds_per_tick)
	M.AdjustParalyzed(-18 * REM * seconds_per_tick)
	M.adjust_stamina_loss(-2.5 * REM * seconds_per_tick, 0)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote("shiver")
	..()
	. = TRUE

/datum/reagent/drug/freebase_cocaine/on_mob_end_metabolize(mob/living/metabolizer)
	metabolizer.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/crack)
	metabolizer.adjust_drowsiness(5 SECONDS)
	..()

/datum/reagent/drug/freebase_cocaine/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("Your heart beats is beating so fast, it hurts..."))

/datum/reagent/drug/freebase_cocaine/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjust_tox_loss(5 * REM * seconds_per_tick, 0)
	M.adjust_organ_loss(ORGAN_SLOT_HEART, (rand(10, 20) / 10) * REM * seconds_per_tick, required_organ_flag = affected_organ_flags)
	M.set_jitter_if_lower(5 SECONDS)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote(pick("twitch","drool"))
	if(!HAS_TRAIT(M, TRAIT_FLOORED))
		if(SPT_PROB(1.5, seconds_per_tick))
			M.visible_message(span_danger("[M] collapses onto the floor!"))
			M.Paralyze(135,TRUE)
			M.drop_all_held_items()
	..()
	. = TRUE

// no you can't multi-coke
/datum/chemical_reaction/cocaine_sanity // cracks your cocaine
	required_container = /mob/living
	required_container_accepts_subtypes = TRUE
	results = list(/datum/reagent/drug/freebase_cocaine = 2)
	required_reagents = list(/datum/reagent/drug/cocaine = 1, /datum/reagent/drug/freebase_cocaine = 1,)
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/cocaine_sanity_paste // unpastes your paste
	required_container = /mob/living
	required_container_accepts_subtypes = TRUE
	results = list(/datum/reagent/drug/cocaine = 0.6, /datum/reagent/toxin/acid/nitracid = 0.2, /datum/reagent/toxin = 0.2,)
	required_reagents = list(/datum/reagent/drug/coca_paste = 1)
	required_catalysts = list(/datum/reagent/drug/cocaine = 1)
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/cocaine_sanity_paste/crack
	required_catalysts = list(/datum/reagent/drug/freebase_cocaine = 1)

// not doing this for coca powder because honestly it doesn't matter
