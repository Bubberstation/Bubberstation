// Original comments imply hunger changes are designed
// to encourage the quirk holder to seek a 'partner'
#define QUIRK_HUNGER_INCUBUS 1.1 // 10% hungrier

/datum/quirk/incubus
	name = "Incubus"
	desc = "Your seductress-like metabolism can only be sated by milk."
	value = 0
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

	// Define quirk holder
	var/mob/living/carbon/human/H = quirk_holder

	// Check for valid holder
	if(!istype(H))
		return

	// Increase hunger rate
	H.physiology.hunger_mod *= QUIRK_HUNGER_INCUBUS

	// Prevent consuming normal food
	ADD_TRAIT(H, TRAIT_NO_PROCESS_FOOD, QUIRK_TRAIT)
	//ADD_TRAIT(H,TRAIT_NOTHIRST,QUIRK_TRAIT) //Needs thirst system

/datum/quirk/incubus/remove()
	. = ..()

	// Define quirk holder
	var/mob/living/carbon/human/H = quirk_holder

	// Check for valid holder
	if(!istype(H))
		return

	// Revert hunger rate change
	H.physiology.hunger_mod /= QUIRK_HUNGER_INCUBUS

	// Revert quirk traits
	REMOVE_TRAIT(H, TRAIT_NO_PROCESS_FOOD, QUIRK_TRAIT)
	//REMOVE_TRAIT(H,TRAIT_NOTHIRST,QUIRK_TRAIT) //Needs thirst system

#undef QUIRK_HUNGER_INCUBUS
