/proc/get_configured_colored_assistant_type()
	return CONFIG_GET(flag/grey_assistants) ? /datum/colored_assistant/grey : /datum/colored_assistant/random

/// Defines a style of jumpsuit/jumpskirt for assistants.
/// Jumpsuit and jumpskirt lists should match in colors, as they are used interchangably.
/datum/colored_assistant
	var/list/jumpsuits
	var/list/jumpskirts
	var/list/bunnysuits

/datum/colored_assistant/grey
	jumpsuits = list(/obj/item/clothing/under/color/grey)
	jumpskirts = list(/obj/item/clothing/under/color/jumpskirt/grey)
	bunnysuits = list(/obj/item/clothing/under/costume/playbunny/color/grey)

/datum/colored_assistant/random
	jumpsuits = list(/obj/item/clothing/under/color/random)
	jumpskirts = list(/obj/item/clothing/under/color/jumpskirt/random)
	bunnysuits = list(/obj/item/clothing/under/costume/playbunny/color/random)

/datum/colored_assistant/christmas
	jumpsuits = list(
		/obj/item/clothing/under/color/green,
		/obj/item/clothing/under/color/red,
	)

	jumpskirts = list(
		/obj/item/clothing/under/color/jumpskirt/green,
		/obj/item/clothing/under/color/jumpskirt/red,
	)

	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/green,
		/obj/item/clothing/under/costume/playbunny/color/red,
	)

/datum/colored_assistant/mcdonalds
	jumpsuits = list(
		/obj/item/clothing/under/color/yellow,
		/obj/item/clothing/under/color/red,
	)

	jumpskirts = list(
		/obj/item/clothing/under/color/jumpskirt/yellow,
		/obj/item/clothing/under/color/jumpskirt/red,
	)

	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/yellow,
		/obj/item/clothing/under/costume/playbunny/color/red,
	)

/datum/colored_assistant/halloween
	jumpsuits = list(
		/obj/item/clothing/under/color/orange,
		/obj/item/clothing/under/color/black,
	)

	jumpskirts = list(
		/obj/item/clothing/under/color/jumpskirt/orange,
		/obj/item/clothing/under/color/jumpskirt/black,
	)

	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/orange,
		/obj/item/clothing/under/costume/playbunny/color/black,
	)

/datum/colored_assistant/ikea
	jumpsuits = list(
		/obj/item/clothing/under/color/yellow,
		/obj/item/clothing/under/color/blue,
	)

	jumpskirts = list(
		/obj/item/clothing/under/color/jumpskirt/yellow,
		/obj/item/clothing/under/color/jumpskirt/blue,
	)

	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/yellow,
		/obj/item/clothing/under/costume/playbunny/color/blue,
	)

/datum/colored_assistant/mud
	jumpsuits = list(
		/obj/item/clothing/under/color/brown,
		/obj/item/clothing/under/color/lightbrown,
	)

	jumpskirts = list(
		/obj/item/clothing/under/color/jumpskirt/brown,
		/obj/item/clothing/under/color/jumpskirt/lightbrown,
	)

	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/brown,
		/obj/item/clothing/under/costume/playbunny/color/lightbrown,
	)

/datum/colored_assistant/warm
	jumpsuits = list(
		/obj/item/clothing/under/color/red,
		/obj/item/clothing/under/color/pink,
		/obj/item/clothing/under/color/orange,
		/obj/item/clothing/under/color/yellow,
	)

	jumpskirts = list(
		/obj/item/clothing/under/color/jumpskirt/red,
		/obj/item/clothing/under/color/jumpskirt/pink,
		/obj/item/clothing/under/color/jumpskirt/orange,
		/obj/item/clothing/under/color/jumpskirt/yellow,
	)

	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/red,
		/obj/item/clothing/under/costume/playbunny/color/pink,
		/obj/item/clothing/under/costume/playbunny/color/orange,
		/obj/item/clothing/under/costume/playbunny/color/yellow,
	)

/datum/colored_assistant/cold
	jumpsuits = list(
		/obj/item/clothing/under/color/blue,
		/obj/item/clothing/under/color/darkblue,
		/obj/item/clothing/under/color/darkgreen,
		/obj/item/clothing/under/color/green,
		/obj/item/clothing/under/color/lightpurple,
		/obj/item/clothing/under/color/teal,
	)

	jumpskirts = list(
		/obj/item/clothing/under/color/jumpskirt/blue,
		/obj/item/clothing/under/color/jumpskirt/darkblue,
		/obj/item/clothing/under/color/jumpskirt/darkgreen,
		/obj/item/clothing/under/color/jumpskirt/green,
		/obj/item/clothing/under/color/jumpskirt/lightpurple,
		/obj/item/clothing/under/color/jumpskirt/teal,
	)

	bunnysuits = list(
		/obj/item/clothing/under/costume/playbunny/color/blue,
		/obj/item/clothing/under/costume/playbunny/color/darkblue,
		/obj/item/clothing/under/costume/playbunny/color/darkgreen,
		/obj/item/clothing/under/costume/playbunny/color/green,
		/obj/item/clothing/under/costume/playbunny/color/lightpurple,
		/obj/item/clothing/under/costume/playbunny/color/teal,
	)

/// Will pick one color, and stick with it
/datum/colored_assistant/solid

/datum/colored_assistant/solid/New()
	var/obj/item/clothing/under/color/random_jumpsuit_type = get_random_jumpsuit()
	jumpsuits = list(random_jumpsuit_type)

	for (var/obj/item/clothing/under/color/jumpskirt/jumpskirt_type as anything in subtypesof(/obj/item/clothing/under/color/jumpskirt))
		if (initial(jumpskirt_type.greyscale_colors) == initial(random_jumpsuit_type.greyscale_colors))
			jumpskirts = list(jumpskirt_type)
			return

	for (var/obj/item/clothing/under/costume/playbunny/color/bunnysuit_type as anything in subtypesof(/obj/item/clothing/under/costume/playbunny/color))
		if (initial(bunnysuit_type.greyscale_colors) == initial(random_jumpsuit_type.greyscale_colors))
			bunnysuits = list(bunnysuit_type)
			return

	// Couldn't find a matching jumpskirt, oh well
	jumpskirts = list(get_random_jumpskirt())
	bunnysuits = list(get_random_bunnysuit())
