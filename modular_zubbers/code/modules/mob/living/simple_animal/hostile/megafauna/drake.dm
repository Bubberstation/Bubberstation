/mob/living/simple_animal/hostile/megafauna/dragon
	faction = list(FACTION_ASHWALKER,FACTION_MINING)

/mob/living/simple_animal/hostile/megafauna/dragon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/egg_layer/ashdrake)


/datum/component/egg_layer/ashdrake
	egg_type = /obj/item/stack/sheet/animalhide/ashdrake
	food_types = list(/obj/item/food/meat/slab/drakebait)
	feed_messages = list("[src] accepts your offering.")
	lay_messages = list(\
			"shakes its head, letting out a pleased grumble. Dry, old scales fall off harmlessly from its hide.",\
			"stretches its wings. Some scales shed off, settling into the ash below.",\
			"sighs comfortably. The movement of its diaphragm loosens its spare scales, dropping them the the ground below its belly.")
	eggs_left = 0
	eggs_added_from_eating = 7
	max_eggs_held = 14

/datum/component/egg_layer/ashdrake/feed_food(datum/source, obj/item/food, mob/living/attacker, params)
	var/the_drake_will_eat_the_meat = FALSE
	for(var/mob/living/carbon/human/person_watching_this_nonsense in view(src, 5)) //Ash Drakes won't accept offerings unless a Mother Tendril-approved person is nearby
		if(person_watching_this_nonsense.mind)
			if(person_watching_this_nonsense.mind.has_antag_datum(/datum/antagonist/ashwalker)) //No, xenobio and stowaway ashwalkers don't count
				the_drake_will_eat_the_meat = TRUE
	if(!the_drake_will_eat_the_meat)
		return
	. = ..()
