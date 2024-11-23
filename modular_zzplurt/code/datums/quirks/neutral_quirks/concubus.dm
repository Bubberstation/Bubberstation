// Original comments imply hunger changes are designed
// to encourage the quirk holder to seek a 'partner'
#define QUIRK_HUNGER_CONCUBUS 1.1 // 10% hungrier

/datum/quirk/concubus
	name = "Concubus"
	desc = "Your seducer-like metabolism can only be sated by milk or semen. This also makes you slightly hungrier."
	value = 0
	gain_text = span_purple("You feel a craving for certain bodily fluids.")
	lose_text = span_purple("Your bodily fluid cravings fade back away.")
	medical_record_text = "Patient claims to subsist entirely on lactose and reproductive fluids."
	mob_trait = TRAIT_CONCUBUS
	icon = FA_ICON_COW
	erp_quirk = TRUE
	mail_goodies = list (
		/datum/glass_style/drinking_glass/cum = 1,
		/obj/item/reagent_containers/condiment/milk = 1
	)

/datum/quirk/concubus/add(client/client_source)
	// Define quirk holder
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check for valid holder
	if(!istype(quirk_mob))
		return

	// Increase hunger rate
	quirk_mob.physiology.hunger_mod *= QUIRK_HUNGER_CONCUBUS

	// Prevent consuming normal food
	ADD_TRAIT(quirk_mob, TRAIT_LIVERLESS_METABOLISM, TRAIT_CONCUBUS)
	//ADD_TRAIT(quirk_mob,TRAIT_NOTHIRST,QUIRK_TRAIT) // Thirst not yet implemented

	// Register special reagent interactions
	RegisterSignals(quirk_holder, list(COMSIG_REAGENT_ADD_CUM, COMSIG_REAGENT_ADD_BREASTMILK), PROC_REF(handle_fluids))

/datum/quirk/concubus/remove()
	// Define quirk holder
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check for valid holder
	if(!istype(quirk_mob))
		return

	// Revert hunger rate change
	quirk_mob.physiology.hunger_mod /= QUIRK_HUNGER_CONCUBUS

	// Revert quirk traits
	REMOVE_TRAIT(quirk_mob, TRAIT_LIVERLESS_METABOLISM, TRAIT_CONCUBUS)
	//REMOVE_TRAIT(quirk_mob,TRAIT_NOTHIRST,QUIRK_TRAIT) // Thirst not yet implemented

	// Unregister special reagent interactions
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_ADD_CUM)
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_ADD_BREASTMILK)

/// Proc to handle reagent interactions with bodily fluids
/datum/quirk/concubus/proc/handle_fluids(mob/living/target, datum/reagent/handled_reagent, amount)
	SIGNAL_HANDLER

	// Check for valid reagent
	if(ispath(handled_reagent))
		// Remove reagent
		quirk_holder.reagents.remove_reagent(handled_reagent, amount)

	// Add Notriment
	quirk_holder.reagents.add_reagent(/datum/reagent/consumable/notriment, amount)

#undef QUIRK_HUNGER_CONCUBUS
