/datum/heretic_knowledge/ultimate/exile_final
	name = "Exile's Ascension"
	desc = "The ascension ritual of the Path of Exile. \
	Bring 3 corpses belonging to high-value targets, such as a Head of Staff or Captain, to a transmutation rune to complete the ritual. \
	When completed, you become highly resistant to damage, as well as immune from various types of ailments. \
	Note that you cannot use guns after completing this, as guns are dishonorable!"
	gain_text = "Much like the Exile before me, I have seeked revenge against those who exiled me. \
	Now that I have returned to full power, none can stop me. I am free to raze and pillage this place as I see fit, \
	a true reward for someone returning from the Path of Exile."
	route = PATH_EXILE
	gain_text = ""


/datum/heretic_knowledge/ultimate/exile_final/is_valid_sacrifice(mob/living/sacrifice)
	return HAS_TRAIT(sacrifice,TRAIT_HIGH_VALUE_RANSOM)

/datum/heretic_knowledge/ultimate/exile_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)

	. = ..()

	user.add_traits(
		list(
			TRAIT_STUNIMMUNE,
			TRAIT_PIERCEIMMUNE,
			TRAIT_NODISMEMBER,
			TRAIT_PUSHIMMUNE,
			TRAIT_PERFECT_ATTACKER,
			TRAIT_NOGUNS,
			TRAIT_NEVER_WOUNDED
		),
		EXILE_ASCENSION_TRAIT
	)

	if(ishuman(user))
		//With the base damage resistance from ascending, this should equal the equivelent of 75% damage resist (0.5 * 0.5 = 0.25)
		var/mob/living/carbon/human/human_user = user
		human_user.physiology.brute_mod *= 0.5
		human_user.physiology.burn_mod *= 0.5
