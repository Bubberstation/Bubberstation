/datum/quirk/incubus
	name = "Incubus"
	desc = "Your seductress-like metabolism can only be sated by milk."
	value = 0
	quirk_flags = QUIRK_PROCESSES
	gain_text = span_notice("You feel a craving for dairy products.")
	lose_text = span_notice("Your dairy craving fades back away.")
	medical_record_text = "Patient claims to subsist entirely on milk based products."
	mob_trait = TRAIT_INCUBUS
	icon = FA_ICON_COW
	mail_goodies = list (
		/obj/item/reagent_containers/condiment/milk = 1
	)

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
