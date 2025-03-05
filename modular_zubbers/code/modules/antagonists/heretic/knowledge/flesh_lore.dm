//flesh stalker, but capped to 3 maximum
/datum/heretic_knowledge/limited_amount/summon/stalker
	name = "Lonely Ritual"
	desc = "Allows you to a stomach, a pen, and a pool of blood to create a Stalker. \
		Stalkers can jaunt, release EMPs, and can shapeshift into anything they witness to perform a deadly attack."
	gain_text = "I was able to combine my greed and desires to summon an eldritch beast I had never seen before. \
		An ever shapeshifting mass of flesh, it knew well my goals. The Marshal approved."
	next_knowledge = list(
		/*
		/datum/heretic_knowledge/ultimate/flesh_final,
		/datum/heretic_knowledge/spell/apetra_vulnera,
		/datum/heretic_knowledge/spell/cleave,
		*/ // swapped with raw prophets

		/datum/heretic_knowledge/blade_upgrade/flesh,
		// /datum/heretic_knowledge/reroll_targets, // BUBBER EDIT REMOVAL
		/datum/heretic_knowledge/spell/blood_siphon,
		/datum/heretic_knowledge/spell/opening_blast,
	)
	required_atoms = list(
 //		/obj/item/organ/external/tail = 1,
		/obj/item/organ/internal/stomach = 1,
//		/obj/item/organ/internal/tongue = 1,
		/obj/item/pen = 1,
//		/obj/item/paper = 1,
		/obj/effect/decal/cleanable/blood = 1,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/stalker
	cost = 1
	route = PATH_FLESH
	poll_ignore_define = POLL_IGNORE_STALKER
//	depth = 10
	depth = 8 // swapped with raw prophets
	//how many flesh stalkers we can have at once
	limit = 3
