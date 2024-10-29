// Original comments imply hunger changes are designed
// to encourage the quirk holder to seek a 'partner'
#define QUIRK_HUNGER_SUCCUBUS 1.1 // 10% hungrier

/datum/quirk/succubus
	name = "Succubus"
	desc = "Your seductress-like metabolism can only be sated by semen."
	value = 0
	gain_text = span_purple("You feel a craving for certain reproductive fluids.")
	lose_text = span_purple("Your bodily fluid craving fades back away.")
	medical_record_text = "Patient claims to subsist entirely on milk based products."
	mob_trait = TRAIT_SUCCUBUS
	icon = FA_ICON_DROPLET
	erp_quirk = TRUE
	mail_goodies = list (
		/datum/glass_style/drinking_glass/cum = 1
	)

/datum/quirk/succubus/add(client/client_source)
	. = ..()

	// Define quirk holder
	var/mob/living/carbon/human/H = quirk_holder

	// Check for valid holder
	if(!istype(H))
		return

	// Increase hunger rate
	H.physiology.hunger_mod *= QUIRK_HUNGER_SUCCUBUS

	// Prevent consuming normal food
	ADD_TRAIT(H, TRAIT_NO_PROCESS_FOOD, QUIRK_TRAIT)
	//ADD_TRAIT(H,TRAIT_NOTHIRST,QUIRK_TRAIT) //Needs thirst system

/datum/quirk/succubus/remove()
	. = ..()

	// Define quirk holder
	var/mob/living/carbon/human/H = quirk_holder

	// Check for valid holder
	if(!istype(H))
		return

	// Revert hunger rate change
	H.physiology.hunger_mod /= QUIRK_HUNGER_SUCCUBUS

	// Revert quirk traits
	REMOVE_TRAIT(H, TRAIT_NO_PROCESS_FOOD, QUIRK_TRAIT)
	//REMOVE_TRAIT(H,TRAIT_NOTHIRST,QUIRK_TRAIT) //Needs thirst system

// Please move this when the reagent is added
/* Reagent doesn't exist yet
/datum/reagent/consumable/ethanol/cum_in_a_hot_tub/semen/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	if(HAS_TRAIT(drinker, TRAIT_SUCCUBUS))
		drinker.adjust_nutrition(0.5)
*/
