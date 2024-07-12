//Edits of main code
/datum/reagent/consumable/milk
	glass_icon_state = "milkglass"

//Own
/datum/reagent/consumable/wockyslush
	name = "Wocky Slush"
	description = "That thang bleedin' to the-... ya know I mean?"
	color = "#7b60c4" // rgb(123, 96, 196)
	quality = DRINK_VERYGOOD
	taste_description = "cold rainbows"
	glass_icon_state = "wockyslush"
	glass_name = "Wocky Slush"
	glass_desc = "That thang bleedin' to the-... ya know I mean?"

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
	glass_icon_state = "orangecreamsicle"
	glass_desc = "A Summer time drink that can be frozen and eaten or Drinked from a glass!"
	glass_name = "Orange Creamsicle"

// Donator drink

/datum/reagent/consumable/honeystones_love
	name = "Honeystone's Love"
	description = "A dash of a mother's desire in every silken-drop!~"
	color = "#7b60c4" // rgb(123, 96, 196)
	quality = DRINK_FANTASTIC
	taste_description = "vivid memories, love, and lucid dirty dreams!~"
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "honeystones_love"
	glass_name = "Honeystone's Love"
	glass_desc = "A dash of a mother's desire in every silken-drop!~"

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
	var/list/genits = H.adjust_arousal(35, "hexacrocin", aphro = TRUE)//check for aphrosidiacs preferences
	for(var/g in genits)
		var/obj/item/organ/genital/G = g
		to_chat(M, span_userlove("[G.arousal_verb]!"))

	..()
// ~( Ported from TG )~
/datum/reagent/consumable/toechtauese_juice
	name = "Töchtaüse Juice"
	description = "An unpleasant juice made from töchtaüse berries. Best made into a syrup, unless you enjoy pain."
	color = "#554862"
	nutriment_factor = 0
	taste_description = "fiery itchy pain"
	glass_icon_state = "toechtauese_syrup"
	glass_name = "glass of töchtaüse juice"
	glass_desc = "Raw, unadulterated töchtaüse juice. One swig will fill you with regrets."

/datum/reagent/consumable/toechtauese_syrup
	name = "Töchtaüse Syrup"
	description = "A harsh spicy and bitter syrup, made from töchtaüse berries. Useful as an ingredient, both for food and cocktails."
	color = "#554862"
	nutriment_factor = 0
	taste_description = "sugar, spice, and nothing nice"
	glass_icon_state = "toechtauese_syrup"
	glass_name = "glass of töchtaüse syrup"
	glass_desc = "Not for drinking on its own."

/datum/reagent/consumable/milkshake_base
	name = "Milkshake"
	description = "A basic milkshake. Could use something else?"
	color = "#FFFDD0"
	nutriment_factor = 1
	taste_description = "thick, creamy, and sweet"
	glass_icon_state = "vanillashake"
	glass_name = "glass of plain milkshake"
	glass_desc = "A glass of plain milkshake, a bit boring, but still good."

/datum/reagent/consumable/milkshake_vanilla
	name = "Vanilla Milkshake"
	description = "A vanilla milkshake. Basic, but delicious."
	color = "#FFFDD0"
	nutriment_factor = 1
	taste_description = "thick, creamy, and sweet"
	glass_icon_state = "vanillashake"
	glass_name = "glass of vanilla milkshake"
	glass_desc = "A glass of vanilla milkshake, a bit boring, but still good."

/datum/reagent/consumable/milkshake_choc
	name = "Chocolate Milkshake"
	description = "A delicious Chocolate Milkshake"
	color = "#7B3F00"
	nutriment_factor = 1
	taste_description = "sweet, creamy chocolate"
	glass_icon_state = "choccyshake"
	glass_name = "glass of chocolate milkshake"
	glass_desc = "A glass of chocolate milkshake, what a treat!"

/datum/reagent/consumable/milkshake_strawberry
	name = "Strawberry Milkshake"
	description = "Frozen Strawberry Milk!"
	color = "#F4E1EA"
	nutriment_factor = 1
	taste_description = "summer memories"
	glass_icon_state = "strawberryshake"
	glass_name = "glass of strawberry milkshake"
	glass_desc = "A glass of sweet, pink Strawberry Shake"

/datum/reagent/consumable/milkshake_banana
	name = "Banana Milkshake"
	description = "Deliciously tricky!"
	color = "#FFE135"
	nutriment_factor = 1
	taste_description = "funny pranks and clowning around"
	glass_icon_state = "bananashake"
	glass_name = "glass of Banana Milkshake"
	glass_desc = "A banana milkshake! Honk!"

/datum/reagent/consumable/milkshake_berry
	name = "Wild Berry Milkshake"
	description = "A summer favorite!"
	color = "#b17179"
	nutriment_factor = 1
	taste_description = "warm summer days"
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "berryshake"
	glass_name = "glass of Wild Berry Milkshake"
	glass_desc = "A berry milkshake"

/datum/reagent/consumable/milkshake_cola
	name = "Cola Milkshake"
	description = "Sweet milkshake mixed with cola"
	color = "#3c3024"
	nutriment_factor = 1
	taste_description = "cola and milkshake"
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "colashake"
	glass_name = "glass of Cola Milkshake"
	glass_desc = "A cola milkshake, it's like a ticker float!"

/datum/reagent/consumable/milkshake_gibb
	name = "Dr. Gibb Milkshake"
	description = "Sweet milkshake mixed with Dr. Gibb"
	color = "#5e312b"
	nutriment_factor = 1
	taste_description = "cola and milkshake"
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "gibbshake"
	glass_name = "glass of Gibb Milkshake"
	glass_desc = "A Dr. Gibb milkshake, it's like a ticker float!"

/datum/reagent/consumable/milkshake_peach
	name = "Peach Milkshake"
	description = "A tasty Peach Milkshake"
	color = "#5e312b"
	nutriment_factor = 1
	taste_description = "peaches and cream"
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "peachshake"
	glass_name = "glass of Peace Milkshake"
	glass_desc = "Peaches and Cream, Peaches and Cream!"

/datum/reagent/consumable/milkshake_pineapple
	name = "Pineapple Milkshake"
	description = "A tangy Pineapple Milkshake"
	color = "#feea63"
	nutriment_factor = 1
	taste_description = "citrus and cream"
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "pineappleshake"
	glass_name = "glass of Pineapple Milkshake"
	glass_desc = "A Pineapple milkshake, a bit sweet and a bit sour, but all delicious!"

/datum/reagent/consumable/milkshake_melon
	name = "Watermelon Milkshake"
	description = "Delicous Watermelon Milkshake"
	color = "#E37383"
	nutriment_factor = 1
	taste_description = "warm sun and sweet cream"
	glass_icon = 'modular_splurt/icons/obj/drinks.dmi'
	glass_icon_state = "melonshake"
	glass_name = "glass of Watermelon Milkshake"
	glass_desc = "A Watermelon milkshake, it's like summer all over again!"
