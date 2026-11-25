/obj/item/food/grown/cannabis/on_grind()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_DRIED))
		reagents.clear_reagents()
		reagents.add_reagent(/datum/reagent/drug/thc/hash, 0.15 * seed.potency)
		return TRUE

/datum/chemical_reaction/hash
	required_reagents = list(/datum/reagent/drug/thc/hash = 10)
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/hash/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/hash(location)

/datum/chemical_reaction/dabs
	required_reagents = list(/datum/reagent/drug/thc = 20)
	required_temp = 420 //haha very funny
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/dabs/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/hash/dabs(location)

//shit for effects
/datum/mood_event/stoned
	description = span_nicegreen("You're totally baked right now...\n")
	mood_change = 6
	timeout = 3 MINUTES

/atom/movable/screen/alert/stoned
	name = "Stoned"
	desc = "You're stoned out of your mind! Woaaahh..."
	icon_state = "high"

//the reagent itself
/datum/reagent/drug/thc
	name = "THC"
	description = "A chemical found in cannabis that serves as its main psychoactive component."
	color = "#cfa40c"
	metabolization_rate = 0.125 * REAGENTS_METABOLISM
	overdose_threshold = 30 //just gives funny effects, but doesnt hurt you; thc has no actual known overdose
	ph = 6
	taste_description = "skunk"

/datum/reagent/drug/thc/concentrated
	name = "Concentrated THC"
	description = "TCH in pure concentrated form"

/datum/reagent/drug/thc/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	M.apply_status_effect(/datum/status_effect/stoned)
	M.adjust_nutrition(-1 * REM * seconds_per_tick) //munchies
	if(SPT_PROB(3.5, seconds_per_tick))
		M.emote(pick("laugh","giggle"))
	..()

/datum/status_effect/stoned/on_apply()
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/human_owner = owner
	human_owner.hud_used?.plane_master_controllers[PLANE_MASTERS_GAME].add_filter("weed_blur", 10, angular_blur_filter(0, 0, 0.45))

/datum/status_effect/stoned/on_remove()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/human_owner = owner
	human_owner.hud_used?.plane_master_controllers[PLANE_MASTERS_GAME].remove_filter("weed_blur")

/datum/reagent/drug/thc/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjust_drowsiness(0.2 SECONDS * REM * normalise_creation_purity() * seconds_per_tick)
	if(SPT_PROB(3.5, seconds_per_tick))
		M.emote("cough")
	..()
	. = TRUE

/datum/reagent/drug/thc/hash //only exists to generate hash object
	name = "hashish"
	description = "Concentrated cannabis extract. Delivers a much better high when used in a bong."
	color = "#cfa40c"
