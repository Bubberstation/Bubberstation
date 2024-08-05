/datum/quirk/vacuum_resistance
    name = "Vacuum Resistance"
    desc = "Your body, whether due to technology, magic, or genetic engineering - is specially adapted to withstand and operate in the vacuum of space. You may still need a source of breathable air, however."
    value = 3
    gain_text = span_notice("Your physique attunes to the silence of space, now able to operate in zero pressure.")
    lose_text = span_notice("Your physiology reverts as your spacefaring gifts lay dormant once more.")
    var/list/perks = list(TRAIT_RESISTCOLD, TRAIT_RESISTLOWPRESSURE)

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
