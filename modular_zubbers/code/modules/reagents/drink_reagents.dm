/datum/reagent/consumable/moth_milk
	name = "Moth Milk"
	description = "Whoever thought that milking moths is a good idea was totally wrong. Is it even milk?"
	color = "#F0E9DA" // rgb: 240, 233, 218
	taste_description = "salty and oily substance"
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/moth_milk/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	if(!ismoth(M))
		M.adjust_disgust(10 * REM * delta_time,DISGUST_LEVEL_DISGUSTED)
		return UPDATE_MOB_HEALTH


/mob/living/basic/mothroach/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/udder, reagent_produced_override = /datum/reagent/consumable/moth_milk)


/datum/reagent/consumable/tea/blood_tea
	name = "Hemoglobin Iced Tea"
	description = "A timeless classic!"
	color = "#B85D52"//rgb(184, 93, 82)
	quality = DRINK_GOOD
	taste_description = "chilly sweet tea and an iron bite"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/tea/blood_tea/on_mob_add(mob/living/affected_mob, amount)
	. = ..()
	if(ishemophage(affected_mob))
		affected_mob.reagents.add_reagent(/datum/reagent/blood, amount)

/datum/glass_style/drinking_glass/blood_tea
	required_drink_type = /datum/reagent/consumable/tea/blood_tea
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bloodteaglass"
	name = "cup of hemoglobin iced tea"
	desc = "Delicious sweet ice tea flavored with blood."


/datum/reagent/consumable/coffee/blood_coffee
	name = "Blood Coffee"
	description = "A timeless classic!"
	color = "#8E272B"//rgb(142, 39, 43)
	quality = DRINK_GOOD
	taste_description = "bitter iron"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/coffee/blood_coffee/on_mob_add(mob/living/affected_mob, amount)
	. = ..()
	if(ishemophage(affected_mob))
		affected_mob.reagents.add_reagent(/datum/reagent/blood, amount)

/datum/glass_style/drinking_glass/blood_coffee
	required_drink_type = /datum/reagent/consumable/coffee/blood_coffee
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bloodcoffeeglass"
	name = "mug of blood coffee"
	desc = "A mug of hot steamy coffee mixed with fresh blood."
