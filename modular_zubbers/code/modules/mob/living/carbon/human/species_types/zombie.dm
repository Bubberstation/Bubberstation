/datum/species/zombie/New()
	inherent_traits -= list(
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_MUTANT_COLORS,
	)
	. = ..()

/obj/item/bodypart/head/zombie //Override of /tg/ default (code\modules\surgery\bodyparts\species_parts\misc_bodyparts.dm), includes EYECOLOR, HAIR and FACIAL HAIR.
	head_flags = HEAD_HAIR|HEAD_FACIAL_HAIR|HEAD_EYESPRITES|HEAD_DEBRAIN|HEAD_EYECOLOR

/obj/item/bodypart/head/zombie/New(loc, ...)
	head_flags |= (HEAD_HAIR|HEAD_FACIAL_HAIR)
	. = ..()

/datum/species/zombie/get_species_description()
	return list("A formerly-alive person, otherwise known in colloquial as a zombie, undead, etc. \
		Rarely seen anywhere except the frontier, their creation leaves many questions unanswered, \
		but despite their murky origins, they claim full rights, same as any other sapient crewmember, \
		including a paycheck, medical care, so on.",)

/datum/species/zombie/get_species_lore()
	return list("Zombies are an enigma, a creation of some supernatural error, or perhaps a malevolent force. Despite their unclear origins, \
		they have formed unions of their own kind. While some treat themselves like laughingstock, others advocate for their own rights as people, \
		just like anyone else.")

// Preserving old function in case people want the old desc?
/*
/datum/species/zombie/get_species_description()
	return list("A rotting zombie! They descend upon Space Station Thirteen Every year to spook the crew! \"Sincerely, the Zombies!\"",)

/datum/species/zombie/get_species_lore()
	return list("Zombies have long lasting beef with Botanists. Their last incident involving a lawn with defensive plants has left them very unhinged.")
*/
