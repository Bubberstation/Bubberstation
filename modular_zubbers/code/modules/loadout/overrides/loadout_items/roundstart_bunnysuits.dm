#define PREF_BUNNY "Bunnysuit"

/proc/get_random_bunnysuit()
	return pick(
		subtypesof(/obj/item/clothing/under/costume/playbunny/color) \
			- /obj/item/clothing/under/rank/prisoner/bunnysuit \
	)

/datum/outfit/job/assistant/preview/give_jumpsuit(mob/living/carbon/human/target)
	if(target.jumpsuit_style == PREF_BUNNY) //BUBBER EDIT START - Bunnysuits
		uniform = /obj/item/clothing/under/costume/playbunny/color/grey //BUBBER EDIT END - Bunnysuits

/datum/colored_assistant
	var/list/bunnysuits //BUBBER EDIT - Bunnysuits

/datum/colored_assistant/grey
	..()
	bunnysuits = list(/obj/item/clothing/under/costume/playbunny/color/grey) //BUBBER EDIT - Bunnysuits

/datum/colored_assistant/random
	..()
	bunnysuits = list(/obj/item/clothing/under/costume/playbunny/color/random) //BUBBER EDIT - Bunnysuits

/datum/colored_assistant/christmas
	..()
	//BUBBER EDIT START - Bunnysuits
	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/green,
		/obj/item/clothing/under/costume/playbunny/color/red,
	) //BUBBER EDIT END - Bunnysuits

/datum/colored_assistant/mcdonalds
	..()
	//BUBBER EDIT START - Bunnysuits
	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/yellow,
		/obj/item/clothing/under/costume/playbunny/color/red,
	) //BUBBER EDIT END - Bunnysuits

/datum/colored_assistant/halloween
	..()
	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/orange,
		/obj/item/clothing/under/costume/playbunny/color/black,
	)

/datum/colored_assistant/ikea
	//BUBBER EDIT START - Bunnysuits
	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/yellow,
		/obj/item/clothing/under/costume/playbunny/color/blue,
	) //BUBBER EDIT END - Bunnysuits

/datum/colored_assistant/mud
	//BUBBER EDIT START - Bunnysuits
	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/brown,
		/obj/item/clothing/under/costume/playbunny/color/lightbrown,
	) //BUBBER EDIT END - Bunnysuits

/datum/colored_assistant/warm
	//BUBBER EDIT START - Bunnysuits
	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/red,
		/obj/item/clothing/under/costume/playbunny/color/pink,
		/obj/item/clothing/under/costume/playbunny/color/orange,
		/obj/item/clothing/under/costume/playbunny/color/yellow,
	) //BUBBER EDIT END - Bunnysuits

/datum/colored_assistant/cold
	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/blue,
		/obj/item/clothing/under/costume/playbunny/color/darkblue,
		/obj/item/clothing/under/costume/playbunny/color/darkgreen,
		/obj/item/clothing/under/costume/playbunny/color/green,
		/obj/item/clothing/under/costume/playbunny/color/lightpurple,
		/obj/item/clothing/under/costume/playbunny/color/teal,
	) //BUBBER EDIT
