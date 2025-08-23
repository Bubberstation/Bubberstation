//we'll put funky non-toxic chems here

//fattening chem
/datum/reagent/consumable/lipoifier
	name = "Lipoifier"
	description = "A very potent chemical that causes those that ingest it to build up fat cells quickly."
	taste_description = "lard"
	color = "#e2e1b1"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/consumable/lipoifier/on_mob_life(mob/living/carbon/M)
	M.adjust_fatness(15, FATTENING_TYPE_CHEM)
	return ..()

//BURPY CHEM

/datum/reagent/consumable/fizulphite
	name = "Fizulphite"
	description = "A strange chemical that produces large amounts of gas when in contact with organic, typically fleshy environments."
	color = "#4cffed" // rgb: 102, 99, 0
	taste_description = "fizziness"
	metabolization_rate = 2 * REAGENTS_METABOLISM

/datum/reagent/consumable/fizulphite/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_chems))
		M.burpslurring = max(M.burpslurring,50)
		M.burpslurring += 2
	else
		M.burpslurring += 0
	..()

//ANTI-BURPY CHEM

/datum/reagent/consumable/extilphite
	name = "Extilphite"
	description = "A very useful chemical that helps soothe bloated stomachs."
	color = "#2aed96"
	taste_description = "smoothness"
	metabolization_rate = 0.8 * REAGENTS_METABOLISM

/datum/reagent/consumable/extilphite/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_chems))
		M.burpslurring -= 3
	else
		M.burpslurring -= 0

	if(M.fullness>10)
		M.fullness -= 6
	else
		M.fullness -= 0
	..()

//FARTY CHEM

/datum/reagent/consumable/flatulose
	name = "Flatulose"
	description = "A sugar largely indigestible to most known organic organisms. Causes frequent flatulence."
	color = "#634500"
	taste_description = "sulfury sweetness"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM //Done by Zestyspy, Jan 2023

/datum/reagent/consumable/flatulose/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_chems))
		if(M.reagents.get_reagent_amount(/datum/reagent/consumable/flatulose) < 1)
			to_chat(M,"<span class='notice'>You feel substantially bloated...</span>")
		if(M.reagents.get_reagent_amount(/datum/reagent/consumable/flatulose) > 3)
			to_chat(M,"<span class='notice'>You feel pretty gassy...</span>")
			M.emote(pick("brap","fart")) // we gotta categorize this into "slob" category or something later! - GDLW2
		..()
	else
		return ..()

// calorite blessing chem, used in the golem ability

/datum/reagent/consumable/caloriteblessing
	name = "Calorite blessing"
	description = "A strange, viscous liquid derived from calorite. It is said to have physically enhancing properties surprisingly unrelated to weight gain when consumed"
	color = "#eb6e00"
	taste_description = "sweet salvation"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/consumable/caloriteblessing/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)


/datum/reagent/consumable/caloriteblessing/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)
	..()

