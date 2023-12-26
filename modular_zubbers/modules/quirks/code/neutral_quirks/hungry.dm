#define QUIRK_HUNGRY_MOD 2

/datum/quirk/hungry
	name = "Hungry"
	desc = "For some reason, you get hungrier faster than others"
	value = 0
	icon = FA_ICON_BOWL_FOOD
	gain_text = span_notice("You feel like your stomach is bottomless")
	lose_text = span_notice("You no longer feel like your stomach is bottomless")
	medical_record_text = "Patient exhibits a significantly faster metabolism"
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/food/chips)

/datum/quirk/hungry/add(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	if(istype(H))
		H.physiology.hunger_mod *= QUIRK_HUNGRY_MOD

/datum/quirk/hungry/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(istype(H))
		H.physiology.hunger_mod /= QUIRK_HUNGRY_MOD

#undef QUIRK_HUNGRY_MOD
