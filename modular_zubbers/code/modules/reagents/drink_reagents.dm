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


/datum/reagent/consumable/icetea/blood_tea
	name = "Hemoglobin Iced Tea"
	description = "A mix of blood and iced tea, with a slice of juicy blood tomato as a garnish."
	color = "#B85D52"//rgb(184, 93, 82)
	quality = DRINK_GOOD
	taste_description = "chilly sweet tea with an iron bite"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/icetea/blood_tea/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = exposed_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(exposed_mob) || reac_volume <= 0)
		return
	exposed_mob.blood_volume = min(exposed_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/blood_tea
	required_drink_type = /datum/reagent/consumable/icetea/blood_tea
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bloodteaglass"
	name = "cup of hemoglobin iced tea"
	desc = "Delicious sweet ice tea flavored with blood."


/datum/reagent/consumable/coffee/blood_coffee
	name = "Blood Coffee"
	description = "Hot black coffee mixed with rich blood, a hemophage's favorite!"
	color = "#8E272B"//rgb(142, 39, 43)
	quality = DRINK_GOOD
	taste_description = "bitter iron"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/coffee/blood_coffee/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = exposed_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(exposed_mob) || reac_volume <= 0)
		return
	exposed_mob.blood_volume = min(exposed_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/blood_coffee
	required_drink_type = /datum/reagent/consumable/coffee/blood_coffee
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bloodcoffeeglass"
	name = "mug of blood coffee"
	desc = "A mug of hot black coffee mixed with fresh blood."
