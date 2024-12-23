/datum/reagent
	var/hydration = 0

/datum/reagent/consumable/cum
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/femcum
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/consumable/orangejuice
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/tomatojuice
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/limejuice
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/carrotjuice
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/berryjuice
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/applejuice
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/poisonberryjuice
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/watermelonjuice
	hydration = 10 * REAGENTS_METABOLISM

/datum/reagent/consumable/lemonjuice
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/banana
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/grapejuice
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/milk
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/soymilk
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/cream
	hydration = 5 * REAGENTS_METABOLISM

/datum/reagent/consumable/coffee
	hydration = 5 * REAGENTS_METABOLISM

/datum/reagent/consumable/tea
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/lemonade
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/tea/arnold_palmer
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/icecoffee
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/icetea
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/space_cola
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/nuka_cola
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/consumable/dr_gibb
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/space_up
	hydration = 10 * REAGENTS_METABOLISM

/datum/reagent/consumable/lemon_lime
	hydration = 5 * REAGENTS_METABOLISM

/datum/reagent/consumable/pwr_game
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/shamblers
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/consumable/grey_bull
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/sodawater
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/tonic
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/ice
	hydration = 10 * REAGENTS_METABOLISM

/datum/reagent/consumable/soy_latte
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/cafe_latte
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/doctor_delight
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/pumpkin_latte
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/consumable/gibbfloats
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/pumpkinjuice
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/consumable/triple_citrus
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/grape_soda
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/milk/chocolate_milk
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/grenadine
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/consumable/parsnipjuice
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/consumable/pineapplejuice
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/peachjuice
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/cream_soda
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/pinkmilk
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/pinktea
	hydration = 8 * REAGENTS_METABOLISM

/datum/reagent/consumable/monkey_energy
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/consumable/bungojuice
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/consumable/prunomix
	hydration = 6 * REAGENTS_METABOLISM

/datum/reagent/consumable/ethanol
	hydration = 4 * REAGENTS_METABOLISM

/datum/reagent/water
	hydration = 10 * REAGENTS_METABOLISM

/datum/reagent/water/metabolize_reagent(mob/living/carbon/M)
	. = ..()
	M.adjust_thirst(hydration)

/obj/item/organ/internal/stomach/proc/handle_thirst(mob/living/carbon/human/H, seconds_per_tick, times_fired)
	if(HAS_TRAIT(H, TRAIT_NOTHIRST))
		return
	H.adjust_thirst(-THIRST_FACTOR)

/datum/reagent/consumable/metabolize_reagent(mob/living/carbon/M)
	. = ..()
	M.adjust_thirst(hydration)
