/proc/get_random_bunnysuit()
	return pick(
		subtypesof(/obj/item/clothing/under/color/playbunny) \
			- /obj/item/clothing/under/rank/prisoner/bunnysuit \
	)

/datum/colored_assistant/solid/New()
	. = ..()
	var/obj/item/clothing/under/color/chosen_suit = jumpsuits[1]
	for (var/obj/item/clothing/under/color/playbunny/playbunny_type as anything in subtypesof(/obj/item/clothing/under/color/playbunny))
		if (findtext(playbunny_type.greyscale_colors, initial(chosen_suit.greyscale_colors)) == TRUE)
			bunnysuits = list(playbunny_type)
			return

	bunnysuits = list(get_random_bunnysuit()) //BUBBER EDIT - Bunnysuits

/datum/outfit/job/assistant/give_jumpsuit(mob/living/carbon/human/target)
	..()
	var/static/jumpsuit_number
	if(target.jumpsuit_style == PREF_BUNNY)
		var/index = (jumpsuit_number % GLOB.colored_assistant.jumpsuits.len) + 1
		uniform = GLOB.colored_assistant.bunnysuits[index]

/datum/colored_assistant
	var/list/bunnysuits //BUBBER EDIT - Bunnysuits

/datum/colored_assistant/grey
	bunnysuits = list(/obj/item/clothing/under/color/playbunny/grey) //BUBBER EDIT - Bunnysuits

/datum/colored_assistant/random
	bunnysuits = list(/obj/item/clothing/under/color/playbunny/random) //BUBBER EDIT - Bunnysuits

/datum/colored_assistant/christmas
	bunnysuits = list(
		/obj/item/clothing/under/color/playbunny/green,
		/obj/item/clothing/under/color/playbunny/red,
	)

/datum/colored_assistant/mcdonalds
	bunnysuits = list(
		/obj/item/clothing/under/color/playbunny/yellow,
		/obj/item/clothing/under/color/playbunny/red,
	)

/datum/colored_assistant/halloween
	bunnysuits = list(
		/obj/item/clothing/under/color/playbunny/orange,
		/obj/item/clothing/under/color/playbunny/black,
	)

/datum/colored_assistant/ikea
	bunnysuits = list(
		/obj/item/clothing/under/color/playbunny/yellow,
		/obj/item/clothing/under/color/playbunny/blue,
	)

/datum/colored_assistant/mud
	bunnysuits = list(
		/obj/item/clothing/under/color/playbunny/brown,
		/obj/item/clothing/under/color/playbunny/lightbrown,
	)

/datum/colored_assistant/warm
	bunnysuits = list(
		/obj/item/clothing/under/color/playbunny/red,
		/obj/item/clothing/under/color/playbunny/pink,
		/obj/item/clothing/under/color/playbunny/orange,
		/obj/item/clothing/under/color/playbunny/yellow,
	)

/datum/colored_assistant/cold
	bunnysuits = list(
		/obj/item/clothing/under/color/playbunny/blue,
		/obj/item/clothing/under/color/playbunny/darkblue,
		/obj/item/clothing/under/color/playbunny/darkgreen,
		/obj/item/clothing/under/color/playbunny/green,
		/obj/item/clothing/under/color/playbunny/lightpurple,
		/obj/item/clothing/under/color/playbunny/teal,
	)
