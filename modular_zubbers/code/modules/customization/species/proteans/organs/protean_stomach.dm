/obj/item/organ/stomach/protean
	name = "refactory"
	desc = "An extremely fragile factory used to recycle materials and create more nanite mass. Needed to facilitate the repair process on a collapsed Protean; it can be installed as a module in the rig, or as an organ."
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "refactory"
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE
	organ_traits = list(TRAIT_ROCK_EATER)
	/// Multiplicative modifier to how fast we lose metal
	var/metabolism_modifier = 1
	COOLDOWN_DECLARE(starving_message)

/obj/item/organ/stomach/protean/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
<<<<<<< Updated upstream
	RegisterSignal(receiver, COMSIG_CARBON_ATTEMPT_EAT, PROC_REF(try_stomach_eat))

/obj/item/organ/stomach/protean/on_mob_remove(mob/living/carbon/stomach_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(stomach_owner, COMSIG_CARBON_ATTEMPT_EAT)
=======
	RegisterSignal(receiver, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(damage_listener))

/obj/item/organ/stomach/protean/on_mob_remove(mob/living/carbon/stomach_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(stomach_owner, COMSIG_MOB_AFTER_APPLY_DAMAGE)
>>>>>>> Stashed changes

/obj/item/organ/stomach/protean/on_life(seconds_per_tick, times_fired)
	if(isnull(owner.client)) // So we dont die from afk/crashing out
		return
	for(var/datum/reagent/consumable/food in reagents.reagent_list)
		if(istype(food, /datum/reagent/consumable/nutriment/mineral))
			continue
		food.nutriment_factor = 0
	. = ..()
	handle_protean_hunger(owner, seconds_per_tick)

/obj/item/organ/stomach/protean/proc/handle_protean_hunger(mob/living/carbon/human/human, seconds_per_tick)
	if(!istype(owner.dna.species, /datum/species/protean))
		return ..()

	var/nutrition = owner.nutrition
	if(nutrition > NUTRITION_LEVEL_VERY_HUNGRY)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)
		var/hunger_modifier = metabolism_modifier
		// If we're high enough on metal we might try to heal or recover blood
		if(nutrition > NUTRITION_LEVEL_HUNGRY)
			if(owner.health < owner.maxHealth)
				hunger_modifier += 20
				owner.adjustBruteLoss(-2, forced = TRUE)
				owner.adjustFireLoss(-2, forced = TRUE)
			if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
				hunger_modifier += 100
				owner.blood_volume = min(owner.blood_volume + (((BLOOD_REGEN_FACTOR * PROTEAN_METABOLISM_RATE) * 0.05) * seconds_per_tick), BLOOD_VOLUME_NORMAL)
		nutrition -= clamp((HUNGER_FACTOR * hunger_modifier * seconds_per_tick), 0, NUTRITION_LEVEL_FULL)
		return
	owner.adjustBruteLoss(2, forced = TRUE)
	if(COOLDOWN_FINISHED(src, starving_message))
		to_chat(owner, span_warning("You are starving! You must find metal now!"))
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown, multiplicative_slowdown = 2)
		COOLDOWN_START(src, starving_message, 20 SECONDS)

<<<<<<< Updated upstream
/// Check to see if our metal storage is full.
/obj/item/organ/stomach/protean/proc/try_stomach_eat(mob/eater, atom/eating)
	SIGNAL_HANDLER

	if(istype(eating, /obj/item/food/golem_food))
		var/obj/item/food/golem_food/food = eating
		if(metal > (PROTEAN_STOMACH_FULL - 0.3) && food.owner.loc == owner)
			balloon_alert(owner, "storage full!")
			return COMSIG_CARBON_BLOCK_EAT
=======
/obj/item/organ/stomach/protean/proc/damage_listener()
	SIGNAL_HANDLER

	if(COOLDOWN_STARTED(src, damage_delay))
		COOLDOWN_RESET(src, damage_delay)
	COOLDOWN_START(src, damage_delay, REGEN_TIME)
>>>>>>> Stashed changes

/// If we ate a sheet of metal, add it to storage.
/obj/item/organ/stomach/protean/after_eat(atom/edible)
	if(istype(edible, /obj/item/food/golem_food))
		var/obj/item/food/golem_food/food = edible
		if(food.owner.loc != owner) // Other people feeding them will heal them.
			owner.adjustBruteLoss(-20, forced = TRUE)
			owner.adjustFireLoss(-20, forced = TRUE)
			var/health_check = owner.health >= owner.maxHealth ? "fully healed!" : "healing"
			owner.balloon_alert_to_viewers("[health_check]")

#undef PROTEAN_STOMACH_FULL
#undef PROTEAN_STOMACH_FALTERING
