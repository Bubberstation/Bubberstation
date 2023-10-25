/datum/reagent/putrescine
	name = "Putrescine"
	description = "A horrible toxin inhaled from rotting organs."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM / 0.5
	color = "#808080"
	taste_description = "horrible horribleness."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE

/datum/reagent/putrescine/on_mob_life(mob/living/carbon/breather, seconds_per_tick, times_fired)
	. = ..()
	if(prob(0.1))
		to_chat(breather, "You smell something horrible!")
		breather.emote("sniff")
	breather.adjust_disgust(25)
	if(breather.disgust >= DISGUST_LEVEL_GROSS && SPT_PROB(50, seconds_per_tick))
		to_chat(breather, span_userdanger("The awful smell is searing your senses!"))

