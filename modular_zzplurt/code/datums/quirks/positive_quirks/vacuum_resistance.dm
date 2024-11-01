/datum/quirk/vacuum_resistance
    name = "Vacuum Resistance"
    desc = "Your body is specially adapted to withstand and operate in zero-pressure environments. You may still need a source of breathable air, however."
    value = 8
    gain_text = span_notice("Your physique attunes to the silence of space, now able to operate in zero pressure.")
    lose_text = span_notice("Your physiology reverts as your space faring gifts lay dormant once more.")
    medical_record_text = "Patient's body has fully adapted to zero-pressure environments."
    hardcore_value = -6
    icon = FA_ICON_USER_ASTRONAUT
    mail_goodies = list (
        /obj/item/storage/box/emergency_spacesuit = 1
    )
    var/list/perks = list(TRAIT_RESISTLOWPRESSURE)

/datum/quirk/vacuum_resistance/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	for(var/perk in perks)
		ADD_TRAIT(H, perk, ROUNDSTART_TRAIT)

/datum/quirk/vacuum_resistance/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	for(var/perk in perks)
		REMOVE_TRAIT(H, perk, ROUNDSTART_TRAIT)
