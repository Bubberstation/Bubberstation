/datum/glass_style/has_foodtype/drinking_glass/eggnog          //Eggnog doesn't have a custom glass in the dm where
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi' //it should (mixed_alcohol.dm), so this exists to give it a glass.
	icon_state = "eggnog"

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


/datum/reagent/consumable/intraverde
	name = "Intraverde"
	description = "A melon soda float topped with blood-infused whipped cream."
	color = "#40e729"
	quality = DRINK_GOOD
	taste_description = "tart sugar and a bit lip."
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/intraverde/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = exposed_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(exposed_mob) || reac_volume <= 0)
		return
	exposed_mob.blood_volume = min(exposed_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/intraverde
	required_drink_type = /datum/reagent/consumable/intraverde
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "intraverde"
	name = "glass of intraverde"
	desc = "A fang-rotting float, often requested by hemophage fledglings who have yet grown the taste for ichor."


/datum/reagent/consumable/ethanol/venetianwaltz
	name = "Venetian Waltz"
	description = "A chocolate-caramel dessert cocktail, made for blood-drinkers."
	color = "#38210b"
	boozepwr = 15
	quality = DRINK_GOOD
	taste_description = "bloody chocolate"
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/venetianwaltz/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = exposed_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(exposed_mob) || reac_volume <= 0)
		return
	exposed_mob.blood_volume = min(exposed_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/venetianwaltz
	required_drink_type = /datum/reagent/consumable/ethanol/venetianwaltz
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "venetianwaltz"
	name = "glass of venetian waltz"
	desc = "Despite the presentation, its scoffed at by older generations for its dessert-like flavour, and is relegated to the tables of sororities and heemoboos as punishment."


/datum/reagent/consumable/ethanol/cranberrycadillac
	name = "Cranberry Cadillac"
	description = "A bubbly, candy-rimmed cocktail."
	color = "#ac1e2a"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "a hit-and-run made of candy"
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/cranberrycadillac/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = exposed_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(exposed_mob) || reac_volume <= 0)
		return
	exposed_mob.blood_volume = min(exposed_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/cranberrycadillac
	required_drink_type = /datum/reagent/consumable/ethanol/cranberrycadillac
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "cranberrycadillac"
	name = "coupe of cranberry cadillac"
	desc = "The sugar crystals that rim the glass are red with real blood, inviting the hungry to lick it clean. Served with half a lemon to counter the sweetness."


/datum/reagent/consumable/ethanol/jubokko
	name = "Jubokko"
	description = "A drink set of sake, and yukake mixed with blood."
	color = "#ac1e2a"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "danger overhead"
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/jubokko/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = exposed_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(exposed_mob) || reac_volume <= 0)
		return
	exposed_mob.blood_volume = min(exposed_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/jubokko
	required_drink_type = /datum/reagent/consumable/ethanol/jubokko
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "jubokko"
	name = "serving of jubokko"
	desc = "The martian, blood-drinking chaebol serve this to their guests. Tasteful as it appears, any good poet knows foreshadowing when it's put in front of them. "


/datum/reagent/consumable/ethanol/moroccocoffin
	name = "Morocco Coffin"
	description = "A cold pressed coffee with a tinge of iron."
	color = "#200608"
	boozepwr = 20
	overdose_threshold = 75
	quality = DRINK_GOOD
	taste_description = "waking up at midnight"
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/moroccocoffin/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.set_jitter_if_lower(10 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/moroccocoffin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)
	affected_mob.AdjustSleeping(-4 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-5 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/moroccocoffin/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = exposed_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(exposed_mob) || reac_volume <= 0)
		return
	exposed_mob.blood_volume = min(exposed_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/moroccocoffin
	required_drink_type = /datum/reagent/consumable/ethanol/moroccocoffin
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "moroccocoffin"
	name = "glass of Morocco Coffin"
	desc = "For waking up when the sun goes down. Cools you down and wakes you up."


/datum/reagent/consumable/ethanol/batouttahell
	name = "Bat Outta' Hell"
	description = "Brave bull mixed with blood, with an absinthe 'varnish' sitting on top."
	color = "#3d1013"
	boozepwr = 70
	overdose_threshold = 47
	quality = DRINK_VERYGOOD
	taste_description = "the blinding thrill of a HOME RUN, BABY!!"
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING
	metabolization_rate = 1.2 * REAGENTS_METABOLISM

/datum/reagent/consumable/ethanol/batouttahell/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/batouttahell/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.add_traits(list(TRAIT_ECHOLOCATION_RECEIVER, TRAIT_TRUE_NIGHT_VISION,TRAIT_GOOD_HEARING),"Overdose:/datum/reagent/consumable/ethanol/batouttahell")
	metabolization_rate = 4.5 * REAGENTS_METABOLISM
	affected_mob.set_dizzy_if_lower(5 SECONDS * REM * seconds_per_tick)
	affected_mob.set_temp_blindness_if_lower(5 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/batouttahell/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_traits(list(TRAIT_ECHOLOCATION_RECEIVER, TRAIT_TRUE_NIGHT_VISION,TRAIT_GOOD_HEARING),"Overdose:/datum/reagent/consumable/ethanol/batouttahell")

/datum/reagent/consumable/ethanol/batouttahell/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = exposed_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(exposed_mob) || reac_volume <= 0)
		return
	exposed_mob.blood_volume = min(exposed_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/batouttahell
	required_drink_type = /datum/reagent/consumable/ethanol/batouttahell
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "batouttahell"
	name = "glass of bat outta' hell"
	desc = "Strong enough to send you flyin' out of the park! Or maybe stumbling..."
