/mob/living/simple_animal/hostile/megafauna/dragon
	faction = list(FACTION_ASHWALKER,FACTION_MINING)

/mob/living/simple_animal/hostile/megafauna/dragon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/egg_layer,\
		egg_type = /obj/item/stack/sheet/animalhide/ashdrake,\
		food_types = list(/obj/item/food/meat/slab/drakebait),\
		feed_messages = list("The drake accepts your offering."),\
		lay_messages = list(\
				"shakes its head, letting out a pleased grumble. Dry, old scales fall off harmlessly from its hide.",\
				"stretches its wings. Some scales shed off, falling into a neat pile.",\
				"sighs comfortably. The movement of its diaphragm loosens its spare scales, dropping them to the ground below its belly."),\
		eggs_left = 0,\
		eggs_added_from_eating = 7,\
		max_eggs_held = 14,\
	)
