/obj/item/codex_cicatrix/morbus/Initialize(mapload)
	. = ..()

	if (check_holidays(APRIL_FOOLS) || prob(1))
		name = "Codex Morbius"
		desc = "It's morbin' time."

/datum/heretic_knowledge/curse/transmutation
	duration = 5 MINUTES // infinit efor no fucking reason in tgcode oml

/datum/heretic_knowledge/curse/corrosion
	duration = 1.5 MINUTES
