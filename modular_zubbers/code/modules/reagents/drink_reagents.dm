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

/datum/reagent/consumable/icetea/blood_tea/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

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

/datum/reagent/consumable/coffee/blood_coffee/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

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
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/intraverde/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/intraverde
	required_drink_type = /datum/reagent/consumable/intraverde
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "intraverde"
	name = "Intraverde"
	desc = "A fang-rotting float, often requested by hemophage fledglings who have yet grown the taste for ichor. The whipped cream top is infused with blood."


/datum/reagent/consumable/ethanol/venetian_waltz
	name = "Venetian Waltz"
	description = "A chocolate-caramel dessert cocktail, made for blood-drinkers."
	color = "#38210b"
	boozepwr = 15
	quality = DRINK_GOOD
	taste_description = "dark and bloody chocolate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/venetian_waltz/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/venetian_waltz
	required_drink_type = /datum/reagent/consumable/ethanol/venetian_waltz
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "venetian_waltz"
	name = "Venetian Waltz"
	desc = "Despite the presentation, its scoffed at by older generations for its dessert-like flavour, and is relegated to the tables of sororities and heemoboos as punishment."


/datum/reagent/consumable/ethanol/cranberry_cadillac
	name = "Cranberry Cadillac"
	description = "A bubbly, candy-rimmed cocktail."
	color = "#ac1e2a"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "a hit-and-run made of candy"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/cranberry_cadillac/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/cranberry_cadillac
	required_drink_type = /datum/reagent/consumable/ethanol/cranberry_cadillac
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "cranberry_cadillac"
	name = "Cranberry Cadillac"
	desc = "The sugar crystals that rim the glass are red with real blood, inviting the hungry to lick it clean. Served with half a lemon slice to counter the sweetness."


/datum/reagent/consumable/ethanol/jubokko
	name = "Jubokko"
	description = "A drink set of sake, and yukake mixed with blood."
	color = "#ac1e2a"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "danger looming above you"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/jubokko/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/jubokko
	required_drink_type = /datum/reagent/consumable/ethanol/jubokko
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "jubokko"
	name = "Jubokko"
	desc = "The martian, blood-drinking chaebol serve this to their guests. Tasteful as it appears, any good poet knows foreshadowing when it's put in front of them."


/datum/reagent/consumable/ethanol/morocco_coffin
	name = "Morocco Coffin"
	description = "A cold pressed coffee with a tinge of iron."
	color = "#200608"
	boozepwr = 20
	overdose_threshold = 75
	quality = DRINK_GOOD
	taste_description = "waking up at midnight"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/morocco_coffin/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.set_jitter_if_lower(10 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/morocco_coffin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)
	affected_mob.AdjustSleeping(-4 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-5 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/morocco_coffin/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/morocco_coffin
	required_drink_type = /datum/reagent/consumable/ethanol/morocco_coffin
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "morocco_coffin"
	name = "Morocco Coffin"
	desc = "For waking up when the sun goes down. Cools you down and wakes you up."


/datum/reagent/consumable/ethanol/bat_outta_hell
	name = "Bat Outta' Hell"
	description = "Brave bull mixed with blood, with an absinthe 'varnish' sitting on top."
	color = "#3d1013"
	boozepwr = 70
	overdose_threshold = 47
	quality = DRINK_VERYGOOD
	taste_description = "the blinding thrill of a HOME RUN, BABY!!"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING
	metabolization_rate = 1.2 * REAGENTS_METABOLISM

/datum/reagent/consumable/ethanol/bat_outta_hell/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/bat_outta_hell/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.add_traits(list(TRAIT_GOOD_HEARING, TRAIT_MINOR_NIGHT_VISION),"Overdose:/datum/reagent/consumable/ethanol/bat_outta_hell")
	metabolization_rate = 4.5 * REAGENTS_METABOLISM
	affected_mob.set_jitter_if_lower(5 SECONDS * REM * seconds_per_tick)
	affected_mob.set_dizzy_if_lower(5 SECONDS * REM * seconds_per_tick)
	affected_mob.set_temp_blindness_if_lower(5 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/bat_outta_hell/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_traits(list(TRAIT_GOOD_HEARING, TRAIT_MINOR_NIGHT_VISION),"Overdose:/datum/reagent/consumable/ethanol/bat_outta_hell")

/datum/reagent/consumable/ethanol/bat_outta_hell/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/bat_outta_hell
	required_drink_type = /datum/reagent/consumable/ethanol/bat_outta_hell
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bat_outta_hell"
	name = "Bat Outta' Hell"
	desc = "Strong enough to send you flyin' out of the park! Or maybe stumbling..."

//Ethereal Drinks

/datum/reagent/consumable/ethanol/karakrak
	name = "Karakrak"
	description = "A lightly charged ration made with filtered wine"
	color = "#5c0b12"
	boozepwr = 0
	quality = DRINK_NICE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	taste_description = "bitter, watered down energy"

/datum/reagent/consumable/ethanol/karakrak/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 3 * ETHEREAL_DISCHARGE_RATE)

/datum/glass_style/drinking_glass/karakrak
	required_drink_type = /datum/reagent/consumable/ethanol/karakrak
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "karakrak"
	name = "Karakrak"
	desc = "A sort of electric, alcohol-stripped wine served to the lowest castes of the ethereal masses, typically distributed by the clergy. Served on a rubber coaster to keep what very little charge exists from dissipating into the table."


/datum/reagent/consumable/ethanol/szzszz
	name = "Szz Szz"
	description = "A bootlegged version of ethereal monastic wine"
	color = "#5c0b12"
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "bitter-sweet sin"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	var/obj/effect/light_holder

/datum/reagent/consumable/ethanol/szzszz/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 4 * ETHEREAL_DISCHARGE_RATE)
	else //If you are NOT an ethereal, you jitter
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)

/datum/reagent/consumable/ethanol/szzszz/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1, COLOR_MAROON)

/datum/reagent/consumable/ethanol/szzszz/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/szzszz/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/szzszz
	required_drink_type = /datum/reagent/consumable/ethanol/szzszz
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "szzszz"
	name = "Szz Szz"
	desc = "A bootlegged version of the Divine Conduit's exclusive monastic wine. The flavour has been approximated by a thousand different tongues, who for at threat of persecution, have never actually tasted it."


/datum/reagent/consumable/blumpkin_compot
	name = "Blumpkin Compot"
	description = "Stewed fruit, sugar, and yerba leaf. An ethereal energy drink."
	color = "#3cc6e9"
	quality = DRINK_VERYGOOD
	taste_description = "clean, reliable energy"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/blumpkin_compot/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 7 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)

/datum/reagent/consumable/blumpkin_compot/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)

/datum/glass_style/drinking_glass/blumpkin_compot
	required_drink_type = /datum/reagent/consumable/blumpkin_compot
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "blumpkin_compot"
	name = "Blumpkin Compot"
	desc = "A drink created by ethereal expats made of stewed blumpkin flesh and whole berries. Sugar helps to draws out the conductive elements, making for a politely energizing beverage that's safe to drink, and also doesnt taste like window cleaner."


/datum/reagent/consumable/ethanol/storm_over_avon
	name = "Storm-Over-Avon"
	description = "A ginny, minty cocktail for ethereal artisans."
	color = "#ffca37"
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "energetic snobbery"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/storm_over_avon/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 8 * ETHEREAL_DISCHARGE_RATE)
	else //If you are not etheral, jitter. Random chance to ZAP you, every sip. Roll a one; zap.
		affected_mob.set_jitter_if_lower(5 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 15)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("You feel a sharp jolt of energy spark off your tongue!"))
			affected_mob.electrocute_act(rand(1, 5), "Storm-Over-Avon shock", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 30, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1.5, COLOR_BRIGHT_BLUE)

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/storm_over_avon
	required_drink_type = /datum/reagent/consumable/ethanol/storm_over_avon
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "storm_over_avon"
	name = "Storm-Over-Avon"
	desc = "A complicated cocktail preferred by devotees of the Everlasting Note. While its original ingredients are impossible to source off of Sprout, this drink-alike still resonates with the pretention that only a musical ecclesiarchy can hone. Known to rarely shock non-ethereals."


/datum/reagent/consumable/ethanol/coilhouse_cocktail
	name = "Coilhouse Cocktail"
	description = "A citrusy, electrified drink with orange juice and lemon."
	color = "#d6ff21"
	boozepwr = 30
	quality = DRINK_VERYGOOD
	taste_description = "a disco ball in your mouth"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	metabolization_rate = 1.1 * REAGENTS_METABOLISM
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/coilhouse_cocktail/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 6 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 6)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("You feel a sharp jolt of energy spark off your tongue!"))
			affected_mob.electrocute_act(rand(2, 8), "Coilhouse Cocktail shock", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 40, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/coilhouse_cocktail/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1.5, COLOR_YELLOW)

/datum/reagent/consumable/ethanol/coilhouse_cocktail/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/coilhouse_cocktail/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/coilhouse_cocktail
	required_drink_type = /datum/reagent/consumable/ethanol/coilhouse_cocktail
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "coilhouse_cocktail"
	name = "Coilhouse Cocktail"
	desc = "An ethereal cocktail too bombastic to have been born inside Soatii space. Also known as a Shocktown Jitter to those not made of electricity, for reasons that will become quickly apparent."


/datum/reagent/consumable/ethanol/electric_avenue
	name = "Electric Avenue"
	description = "A cocktail made of goldschlager and citrus, with salt."
	color = "#d37810"
	boozepwr = 25
	quality = DRINK_VERYGOOD
	taste_description = "a sour, electric chair"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	metabolization_rate = 1.6 * REAGENTS_METABOLISM
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/electric_avenue/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 10 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 3)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("You feel a violent jolt of energy spark off your tongue!"))
			affected_mob.electrocute_act(rand(15, 35), "Electric avenue shock", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 55, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/electric_avenue/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1.5, COLOR_VERY_SOFT_YELLOW)

/datum/reagent/consumable/ethanol/electric_avenue/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/electric_avenue/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/electric_avenue
	required_drink_type = /datum/reagent/consumable/ethanol/electric_avenue
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "electric_avenue"
	name = "Electric Avenue"
	desc = "Named after a mythical location in the Sol System, this drink is meant to be sipped slowly through the narrow copper straw, representing the long but brisk taste of life. But to non-ethereals, it's a warp lane to the emergency room."


/datum/reagent/consumable/ethanol/ira_de_zeus
	name = "Ira de Zeus"
	description = "A deep blue cocktail made by harnessing electricity and fire."
	color = "#3e1ef1"
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "sharp, spiced hypocracy"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	metabolization_rate = 1.1 * REAGENTS_METABOLISM
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/ira_de_zeus/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 5 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(5 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 8)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("You feel a violent jolt of energy spark off your tongue!"))
			affected_mob.electrocute_act(rand(10, 25), "Ira de Zeus shock", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 40, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/ira_de_zeus/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.2, 3.5, COLOR_BRIGHT_BLUE)

/datum/reagent/consumable/ethanol/ira_de_zeus/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjust_bodytemperature(15 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal()+ 20)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/ira_de_zeus/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/ira_de_zeus
	required_drink_type = /datum/reagent/consumable/ethanol/ira_de_zeus
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "ira_de_zeus"
	name = "Ira De Zeus"
	desc = "A radiant ethereal drink that warms the body and tickles the tongue. The original recipie, fabled to have originated from the tables of Sprout's upper-caste clergy, would imply heresy of the highest order. Good thing it's only a fable... May shock non-ethereals."
