/datum/uplink_item/stealthy_weapons/hypnostick
	name = "Hypno Lipstick"
	desc = "A potent lipstick capable of weakening and even hypnotizing the minds of those you kiss!"
	item = /obj/item/lipstick/hypnosyndie
	cost = 4

///Split this between traitors and nukies so nukie stays the same, and traitors can still get it if they work together/steal TC from each other
/datum/uplink_item/stealthy_weapons/romerol_kit_traitor
	name = "Romerol"
	desc = "A highly experimental bioterror agent which creates dormant nodules to be etched into the grey matter of the brain. \
		On death, these nodules take control of the dead body, causing limited revivification, \
		along with slurred speech, aggression, and the ability to infect others with this agent."
	item = /obj/item/storage/box/syndie_kit/romerol
	cost = 30
	population_minimum = TRAITOR_POPULATION_LOWPOP
	progression_minimum = 30 MINUTES
	purchasable_from = UPLINK_TRAITORS
	cant_discount = TRUE
