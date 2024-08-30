/datum/quirk/incubus
	name = "Incubus"
	desc = "Your seductor-like metabolism can only be sated by milk. (And semen, if you're a Succubus as well.)"
	value = 0
	mob_trait = TRAIT_INCUBUS
	quirk_flags = /datum/quirk::quirk_flags | QUIRK_PROCESSES

/datum/quirk/incubus/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_NOHUNGER, QUIRK_TRAIT)
	//ADD_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT) //Needs thirst system

/datum/quirk/incubus/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	REMOVE_TRAIT(H, TRAIT_NOHUNGER, QUIRK_TRAIT)
	//REMOVE_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT) //Needs thirst system

/datum/quirk/incubus/process(seconds_per_tick)
	var/mob/living/carbon/human/H = quirk_holder
	H.adjust_nutrition(-0.09)//increases their nutrition loss rate to encourage them to gain a partner they can essentially leech off of

/datum/reagent/consumable/milk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(HAS_TRAIT(affected_mob, TRAIT_INCUBUS))
		affected_mob.adjust_nutrition(1.5)
