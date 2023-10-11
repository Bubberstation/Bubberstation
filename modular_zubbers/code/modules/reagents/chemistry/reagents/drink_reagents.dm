/datum/reagent/consumable/coconutmilk
	name = "Coconut Milk"
	description = "A transparent white liquid extracted from coconuts. Rich in taste."
	color = "#DFDFDF" // rgb: 223, 223, 223
	taste_description = "sweet milk"
	quality = DRINK_GOOD

/datum/reagent/consumable/coconutmilk/on_mob_life(mob/living/carbon/M)
	if(M.getBruteLoss() && prob(20))
		M.heal_bodypart_damage(2,0, 0)
		. = 1
	..()
