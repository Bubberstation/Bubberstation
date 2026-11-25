/datum/design/leftarm/New()
	category += list(SPECIES_SNAIL)
	return ..()

/datum/design/rightarm/New()
	category += list(SPECIES_SNAIL)
	return ..()

/datum/design/leftleg/New()
	category += list(SPECIES_SNAIL)
	return ..()

/datum/design/rightleg/New()
	category += list(SPECIES_SNAIL)
	return ..()

/datum/design/tongue/snail
	name = "Snail Tongue"
	build_path = /obj/item/organ/tongue/snail
	category = list(
		SPECIES_SNAIL,
		RND_CATEGORY_INITIAL,
	)

/datum/design/liver/snail
	name = "Snail Liver"
	build_path = /obj/item/organ/liver/snail
	category = list(
		SPECIES_SNAIL,
		RND_CATEGORY_INITIAL,
	)

/datum/design/heart/snail
	name = "Snail Heart"
	build_path = /obj/item/organ/heart/snail
	category = list(
		SPECIES_SNAIL,
		RND_CATEGORY_INITIAL,
	)
