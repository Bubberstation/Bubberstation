// UNIMPLEMENTED QUIRK!
/datum/quirk/thirsty
	name = "Thirsty"
	desc = "You find yourself unusually thirsty. Gotta drink twice as much as normal."
	value = -1
	gain_text = span_danger("You're starting to feel thirstier a lot faster.")
	lose_text = span_notice("Your elevated craving for water begins dying down.")
	medical_record_text = "Patient reports drinking twice as many liquids per day than usual for their species."
	mob_trait = TRAIT_THIRSTY
	hardcore_value = 1
	icon = FA_ICON_GLASS_WATER
	mail_goodies = list (
		/obj/item/reagent_containers/cup/glass/waterbottle = 1
	)

// Copy pasted from old code
// Thirst has not been implemented yet
/*
/datum/quirk/thirsty/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/physiology/P = H.physiology
	P.thirst_mod *= 2

/datum/quirk/thirsty/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/physiology/P = H.physiology
		P.thirst_mod /= 2
*/
