//we'll put funky non-toxic chems here

//fattening chem
/datum/reagent/consumable/lipoifier
	name = "Lipoifier"
	description = "A very potent chemical that causes those that ingest it to build up fat cells quickly."
	taste_description = "lard"
	reagent_state = LIQUID
	color = "#e2e1b1"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_ORGANIC_PROCESS | REAGENT_BIOFUEL_PROCESS

/datum/reagent/consumable/lipoifier/on_mob_life(mob/living/carbon/M)
	M.adjust_fatness(15, FATTENING_TYPE_CHEM)
	return ..()

/datum/reagent/medicine/lipolicide
	name = "Lipolicide"
	description = "A powerful toxin that will destroy fat cells, massively reducing body weight in a short time. Deadly to those without nutriment in their body."
	taste_description = "mothballs"
	reagent_state = LIQUID
	color = "#F0FFF0"
	// GS13 tweak
	metabolization_rate = 0.7 * REAGENTS_METABOLISM
	overdose_threshold = 105
	chemical_flags = REAGENT_ORGANIC_PROCESS | REAGENT_BIOFUEL_PROCESS

/datum/reagent/medicine/lipolicide/overdose_process(mob/living/carbon/C)
	. = ..()
	if(current_cycle >=41 && prob(10))
		to_chat(C, "<span class='userdanger'>You feel like your organs are on fire!</span>")
		C.IgniteMob()

/datum/reagent/medicine/lipolicide/on_mob_life(mob/living/carbon/M)
	if(M.nutrition <= NUTRITION_LEVEL_STARVING)
		M.adjustToxLoss(1*REAGENTS_EFFECT_MULTIPLIER, 0)
	if(M.fatness_real == 0)
		M.nutrition = max(M.nutrition - 3, 0) // making the chef more valuable, one meme trap at a time
	if(HAS_TRAIT(M, TRAIT_LIPOLICIDE_TOLERANCE)) //GS13 edit
		M.adjust_fatness(-0.5, FATTENING_TYPE_WEIGHT_LOSS)
	else
		M.adjust_fatness(-10, FATTENING_TYPE_WEIGHT_LOSS)

	M.overeatduration = 0
	return ..()

//BURPY CHEM

/datum/reagent/consumable/fizulphite
	name = "Fizulphite"
	description = "A strange chemical that produces large amounts of gas when in contact with organic, typically fleshy environments."
	color = "#4cffed" // rgb: 102, 99, 0
	reagent_state = LIQUID
	taste_description = "fizziness"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_ORGANIC_PROCESS | REAGENT_BIOFUEL_PROCESS

/datum/reagent/consumable/fizulphite/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs.weight_gain_chems)
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
	reagent_state = LIQUID
	taste_description = "smoothness"
	metabolization_rate = 0.8 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_ORGANIC_PROCESS | REAGENT_BIOFUEL_PROCESS

/datum/reagent/consumable/extilphite/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs.weight_gain_chems)
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
	reagent_state = LIQUID
	taste_description = "sulfury sweetness"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM //Done by Zestyspy, Jan 2023
	chemical_flags = REAGENT_ORGANIC_PROCESS | REAGENT_BIOFUEL_PROCESS

/datum/reagent/consumable/flatulose/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs.weight_gain_chems)
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
	reagent_state = LIQUID
	taste_description = "sweet salvation"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/consumable/caloriteblessing/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)


/datum/reagent/consumable/caloriteblessing/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)
	..()


//BLUEBERRY CHEM - ONLY CHANGES PLAYER'S COLOR AND NOTHING MORE

/datum/reagent/blueberry_juice
	name = "Blueberry Juice"
	description = "Totally infectious."
	reagent_state = LIQUID
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	color = "#0004ff"
	var/picked_color
	var/list/random_color_list = list("#0058db","#5d00c7","#0004ff","#0057e7")
	taste_description = "blueberry pie"
	var/no_mob_color = FALSE
	value = 10	//it sells. Make that berry factory
	chemical_flags = REAGENT_ORGANIC_PROCESS | REAGENT_BIOFUEL_PROCESS //screw it let robots have juice why not

/datum/reagent/blueberry_juice/on_mob_life(mob/living/carbon/M)
	if(M?.client)
		if(!(M?.client?.prefs?.blueberry_inflation))
			M.reagents.remove_reagent(/datum/reagent/blueberry_juice, volume)
			return
		if(!no_mob_color)
			M.add_atom_colour(picked_color, WASHABLE_COLOUR_PRIORITY)
		M.adjust_fatness(1, FATTENING_TYPE_CHEM)
	..()

/datum/reagent/blueberry_juice/on_mob_add(mob/living/L, amount)
	if(iscarbon(L))
		var/mob/living/carbon/affected_mob = L
		if(!affected_mob?.client || !(affected_mob?.client?.prefs?.blueberry_inflation))
			affected_mob.reagents.remove_reagent(/datum/reagent/blueberry_juice, volume)
			return
		picked_color = pick(random_color_list)
		affected_mob.hider_add(src)
	else
		L.reagents.remove_reagent(/datum/reagent/blueberry_juice, volume)
	..()

/datum/reagent/blueberry_juice/on_mob_delete(mob/living/L)
	if(!iscarbon(L))
		return
	var/mob/living/carbon/C = L
	C.hider_remove(src)

/datum/reagent/blueberry_juice/proc/fat_hide()
	return (124 * (volume * volume))/1000	//123'840 600% size, about 56'000 400% size, calc was: (3 * (volume * volume))/50

// /obj/item/reagent_containers/food/snacks/meat/steak/troll
// 	name = "Troll steak"
// 	desc = "In its sliced state it remains dormant, but once the troll meat comes in contact with stomach acids, it begins a perpetual cycle of constant regrowth and digestion. You probably shouldn't eat this."
// 	var/hunger_threshold = NUTRITION_LEVEL_FULL
// 	var/nutrition_amount = 20 // somewhere around 5 pounds
// 	var/fullness_to_add = 10
// 	var/message = "<span class='notice'>You feel fuller...</span>" // GS13
