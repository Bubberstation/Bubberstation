//BLUEBERRY CHEM - ONLY CHANGES PLAYER'S COLOR AND NOTHING MORE

/* Put this back in later.
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
	// put this back in later value = 10	//it sells. Make that berry factory

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

// /obj/item/food/meat/steak/troll
// 	name = "Troll steak"
// 	desc = "In its sliced state it remains dormant, but once the troll meat comes in contact with stomach acids, it begins a perpetual cycle of constant regrowth and digestion. You probably shouldn't eat this."
// 	var/hunger_threshold = NUTRITION_LEVEL_FULL
// 	var/nutrition_amount = 20 // somewhere around 5 pounds
// 	var/fullness_to_add = 10
// 	var/message = "<span class='notice'>You feel fuller...</span>" // GS13

*/
