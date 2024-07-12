//Own
/datum/reagent/consumable/wockyslush
	name = "Wocky Slush"
	description = "That thang bleedin' to the-... ya know I mean?"
	color = "#7b60c4" // rgb(123, 96, 196)
	quality = DRINK_VERYGOOD
	taste_description = "cold rainbows"

/datum/reagent/consumable/wockyslush/on_mob_life(mob/living/carbon/M)
	M.emote(pick("twitch","giggle","stare"))
	M.set_drugginess(75)
	M.apply_status_effect(/datum/status_effect/throat_soothed)
	..()

/datum/reagent/consumable/orange_creamsicle
	name = "Orange Creamsicle"
	description = "A Summer time drink that can be frozen and eaten or drunk from a glass!"
	color = "#ffb46e" // rgb(255, 180, 110)
	taste_description = "ice cream and orange soda"

// Donator drink

/datum/reagent/consumable/honeystones_love
	name = "Honeystone's Love"
	description = "A dash of a mother's desire in every silken-drop!~"
	color = "#7b60c4" // rgb(123, 96, 196)
	quality = DRINK_FANTASTIC
	taste_description = "vivid memories, love, and lucid dirty dreams!~"

/datum/reagent/consumable/honeystones_love/on_mob_life(mob/living/carbon/M)
	if((prob(min(current_cycle/2,5))))
		M.emote(pick("giggle","grin"))
	M.apply_status_effect(/datum/status_effect/throat_soothed)
	// healing
	M.adjustBruteLoss(-1.2, 0)
	M.adjustFireLoss(-1.2, 0)
	M.adjustToxLoss(-1.2, 0, TRUE)
	M.adjustOxyLoss(-1.2, 0)
	//checks for mindbreaker
	if(holder.has_reagent(/datum/reagent/toxin/mindbreaker))
		holder.remove_reagent(/datum/reagent/toxin/mindbreaker, 5)
	//applies horny effect
	var/mob/living/carbon/human/H = M
	var/list/genits = H.adjust_arousal(35, "hexacrocin")//check for aphrosidiacs preferences
	/* Not supported yet
	for(var/g in genits)
		var/obj/item/organ/external/genital/G = g
		to_chat(M, span_userlove("[G.arousal_verb]!"))*/

	..()
// ~( Ported from TG )~
/datum/reagent/consumable/toechtauese_juice
	name = "Töchtaüse Juice"
	description = "An unpleasant juice made from töchtaüse berries. Best made into a syrup, unless you enjoy pain."
	color = "#554862"
	nutriment_factor = 0
	taste_description = "fiery itchy pain"

/datum/reagent/consumable/toechtauese_syrup
	name = "Töchtaüse Syrup"
	description = "A harsh spicy and bitter syrup, made from töchtaüse berries. Useful as an ingredient, both for food and cocktails."
	color = "#554862"
	nutriment_factor = 0
	taste_description = "sugar, spice, and nothing nice"

/datum/reagent/consumable/milkshake_base
	name = "Milkshake"
	description = "A basic milkshake. Could use something else?"
	color = "#FFFDD0"
	nutriment_factor = 1
	taste_description = "thick, creamy, and sweet"

/datum/reagent/consumable/milkshake_cola
	name = "Cola Milkshake"
	description = "Sweet milkshake mixed with cola"
	color = "#3c3024"
	nutriment_factor = 1
	taste_description = "cola and milkshake"

/datum/reagent/consumable/milkshake_gibb
	name = "Dr. Gibb Milkshake"
	description = "Sweet milkshake mixed with Dr. Gibb"
	color = "#5e312b"
	nutriment_factor = 1
	taste_description = "cola and milkshake"

/datum/reagent/consumable/milkshake_peach
	name = "Peach Milkshake"
	description = "A tasty Peach Milkshake"
	color = "#5e312b"
	nutriment_factor = 1
	taste_description = "peaches and cream"

/datum/reagent/consumable/milkshake_pineapple
	name = "Pineapple Milkshake"
	description = "A tangy Pineapple Milkshake"
	color = "#feea63"
	nutriment_factor = 1
	taste_description = "citrus and cream"

/datum/reagent/consumable/milkshake_melon
	name = "Watermelon Milkshake"
	description = "Delicous Watermelon Milkshake"
	color = "#E37383"
	nutriment_factor = 1
	taste_description = "warm sun and sweet cream"
