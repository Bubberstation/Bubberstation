/datum/chemical_reaction/coca_paste
	results = list(/datum/reagent/drug/cocaine/coca_paste = 5)
	required_reagents = list(/datum/reagent/drug/coca_powder = 10, /datum/reagent/toxin/acid/nitracid = 1, /datum/reagent/water = 9)
	required_temp = 300
	purity_min = 0
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_DRUG

/datum/chemical_reaction/coca_tea
	results = list(/datum/reagent/drug/coca_tea = 5)
	required_reagents = list(/datum/reagent/drug/coca_powder = 1, /datum/reagent/water = 5)
	required_temp = 300
	purity_min = 0
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRINK

/datum/chemical_reaction/cocaine
	results = list(/datum/reagent/drug/cocaine = 10)
	required_reagents = list(/datum/reagent/drug/cocaine/coca_paste = 8, /datum/reagent/acetone = 2, /datum/reagent/toxin/acid = 2,)
	required_temp = 480 // cook it
	purity_min = 0
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_DRUG
	mix_message = "The solution thickens into a paste!"

/datum/chemical_reaction/powder_cocaine
	is_cold_recipe = TRUE
	required_reagents = list(/datum/reagent/drug/cocaine = 10)
	required_temp = 250 //freeze it
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_DRUG
	mix_message = "The solution freezes into a powder!"

/datum/chemical_reaction/powder_cocaine/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/cocaine(location)

/datum/chemical_reaction/crack_cooking
	required_reagents = list(/datum/reagent/drug/cocaine = 8, /datum/reagent/water = 12, /datum/reagent/ammonia = 4)
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
	multiplicative_slowdown = -0.4

/datum/reagent/drug/cocaine
	name = "cocaine"
	description = "A powerful stimulant extracted from coca leaves. Causes drowsiness and severe brain damage if overdosed."
	color = "#ffffff"
	overdose_threshold = 20
	ph = 9
	taste_description = "bitterness" //supposedly does taste bitter in real life
	addiction_types = list(/datum/addiction/stimulants = 14) //5.6 per 2 seconds

	metabolized_traits = list(TRAIT_ANALGESIA, TRAIT_BATON_RESISTANCE)

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
	M.add_mood_event("zoinked", /datum/mood_event/stimulant_heavy, 1, name)
	M.AdjustStun(-15 * REM * seconds_per_tick)
	M.AdjustKnockdown(-15 * REM * seconds_per_tick)
	M.AdjustUnconscious(-15 * REM * seconds_per_tick)
	M.AdjustImmobilized(-15 * REM * seconds_per_tick)
	M.AdjustParalyzed(-15 * REM * seconds_per_tick)
	M.adjustStaminaLoss(-2 * REM * seconds_per_tick, 0)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote("shiver")
	..()
	. = TRUE

/datum/reagent/drug/cocaine/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("Your heart beats is beating so fast, it hurts..."))

/datum/reagent/drug/cocaine/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjustToxLoss(5 * REM * seconds_per_tick, 0)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, (rand(10, 20) / 10) * REM * seconds_per_tick)
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
	name = "coca powder"
	description = "Ground-up and filtered coca leaves, mildly stimulating."
	color = "#20862f"
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/coca_powder/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	M.AdjustStun(-1.5 * REM * seconds_per_tick)
	M.AdjustKnockdown(-1.5 * REM * seconds_per_tick)
	M.AdjustUnconscious(-1.5 * REM * seconds_per_tick)
	M.AdjustImmobilized(-1.5 * REM * seconds_per_tick)
	M.AdjustParalyzed(-1.5 * REM * seconds_per_tick)
	..()
	. = TRUE

/datum/reagent/drug/coca_tea
	name = "coca tea"
	description = "Kind of tea made from coca leaves."
	color = "#48a455"
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/coca_tea/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	M.AdjustStun(-1 * REM * seconds_per_tick)
	M.AdjustKnockdown(-1 * REM * seconds_per_tick)
	M.AdjustUnconscious(-1 * REM * seconds_per_tick)
	M.AdjustImmobilized(-1 * REM * seconds_per_tick)
	M.AdjustParalyzed(-1 * REM * seconds_per_tick)
	..()
	. = TRUE

/datum/reagent/drug/cocaine/coca_paste
	name = "coca paste"
	description = "Acidc paste containing high amount of cocaine and toxic chemicals used to process it - consumption is ill-advised."
	color = "#4e6444"
	ph = 5
	taste_description = "acidic sludge"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/cocaine/coca_paste/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	M.adjustFireLoss((volume/100) * REM * normalise_creation_purity() * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	M.adjustToxLoss(3 * REM * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	if(SPT_PROB(2.5, seconds_per_tick))
		var/high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
		to_chat(M, span_notice("[high_message]"))
	M.add_mood_event("zoinked", /datum/mood_event/stimulant_heavy, 1, name)
	M.AdjustStun(-15 * REM * seconds_per_tick)
	M.AdjustKnockdown(-15 * REM * seconds_per_tick)
	M.AdjustUnconscious(-15 * REM * seconds_per_tick)
	M.AdjustImmobilized(-15 * REM * seconds_per_tick)
	M.AdjustParalyzed(-15 * REM * seconds_per_tick)
	M.adjustStaminaLoss(-2 * REM * seconds_per_tick, 0)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote("scream")
	..()
	. = TRUE
	return UPDATE_MOB_HEALTH

/datum/movespeed_modifier/reagent/crack
	multiplicative_slowdown = -0.5

/datum/reagent/drug/cocaine/freebase_cocaine
	name = "freebase cocaine"
	description = "A smokable form of cocaine, Its higher bioavaliability results in a more intense high."
	color = "#f0e6bb"
	overdose_threshold = 15
	taste_description = "crunchy bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drug/cocaine/freebase_cocaine/on_mob_metabolize(mob/living/metabolizer)
	..()
	metabolizer.add_movespeed_modifier(/datum/movespeed_modifier/reagent/crack)

/datum/reagent/drug/cocaine/freebase_cocaine/on_mob_end_metabolize(mob/living/metabolizer)
	metabolizer.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/crack)
	metabolizer.adjust_drowsiness(5 SECONDS)
	..()

/datum/reagent/drug/cocaine/powder_cocaine
	name = "powder cocaine"
	description = "The powder form of cocaine."
	color = "#ffffff"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
