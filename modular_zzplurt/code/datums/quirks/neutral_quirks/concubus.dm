// Original comments imply hunger changes are designed
// to encourage the quirk holder to seek a 'partner'
#define QUIRK_HUNGER_CONCUBUS 1.1 // 10% hungrier

/datum/quirk/concubus
	name = "Concubus"
	desc = "Your seducer-like metabolism can only be sated by milk or semen."
	value = 0
	gain_text = span_purple("You feel a craving for certain bodily fluids.")
	lose_text = span_purple("Your bodily fluid cravings fade back away.")
	medical_record_text = "Patient claims to subsist entirely on lactose and reproductive fluids."
	mob_trait = TRAIT_CONCUBUS
	icon = FA_ICON_DROPLET
	erp_quirk = TRUE
	mail_goodies = list (
		/datum/glass_style/drinking_glass/cum = 1,
		/obj/item/reagent_containers/condiment/milk = 1
	)

/datum/quirk/concubus/add(client/client_source)
	. = ..()

	// Define quirk holder
	var/mob/living/carbon/human/H = quirk_holder

	// Check for valid holder
	if(!istype(H))
		return

	// Increase hunger rate
	H.physiology.hunger_mod *= QUIRK_HUNGER_CONCUBUS

	// Prevent consuming normal food
	ADD_TRAIT(H, TRAIT_NO_PROCESS_FOOD, QUIRK_TRAIT)
	//ADD_TRAIT(H,TRAIT_NOTHIRST,QUIRK_TRAIT) // Thirst not yet implemented

/datum/quirk/concubus/remove()
	. = ..()

	// Define quirk holder
	var/mob/living/carbon/human/H = quirk_holder

	// Check for valid holder
	if(!istype(H))
		return

	// Revert hunger rate change
	H.physiology.hunger_mod /= QUIRK_HUNGER_CONCUBUS

	// Revert quirk traits
	REMOVE_TRAIT(H, TRAIT_NO_PROCESS_FOOD, QUIRK_TRAIT)
	//REMOVE_TRAIT(H,TRAIT_NOTHIRST,QUIRK_TRAIT) // Thirst not yet implemented

#undef QUIRK_HUNGER_CONCUBUS
