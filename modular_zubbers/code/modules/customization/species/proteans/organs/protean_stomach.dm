#define REGEN_TIME (30 SECONDS) // () are important for order of operations. Fuck you too, byond
/obj/item/organ/stomach/protean
	name = "refactory"
	desc = "An extremely fragile factory used to recycle materials and create more nanite mass. Needed to facilitate the repair process on a collapsed Protean; it can be installed as a module in the rig, or as an organ."
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "refactory"
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE
	organ_traits = list(TRAIT_NOHUNGER)

	/// How much max metal can we hold at any given time (In sheets). This isn't using nutrition code because nutrition code gets weird without livers.
	var/metal_max = PROTEAN_STOMACH_FULL
	/// How much metal are we holding currently (In sheets)
	var/metal = PROTEAN_STOMACH_FULL
	/// Multiplicative modifier to how fast we lose metal
	var/metabolism_modifier = 1
	COOLDOWN_DECLARE(starving_message)
	COOLDOWN_DECLARE(damage_delay)

/obj/item/organ/stomach/protean/Initialize(mapload)
	. = ..() // Call the rest of the proc
	metal = round(rand(PROTEAN_STOMACH_FULL/2, PROTEAN_STOMACH_FULL))

/obj/item/organ/stomach/protean/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	RegisterSignal(receiver, COMSIG_CARBON_ATTEMPT_EAT, PROC_REF(try_stomach_eat))
	RegisterSignal(receiver, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(damage_listener))

/obj/item/organ/stomach/protean/on_mob_remove(mob/living/carbon/stomach_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(stomach_owner, COMSIG_CARBON_ATTEMPT_EAT)
	UnregisterSignal(stomach_owner, COMSIG_MOB_AFTER_APPLY_DAMAGE)

/obj/item/organ/stomach/protean/on_life(seconds_per_tick, times_fired)
	var/datum/species/protean/species = owner?.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(owner.loc == suit)
		return
	/// Zero out any nutrition. We do not use hunger in this species.
	for(var/datum/reagent/consumable/food in reagents.reagent_list)
		food.nutriment_factor = 0
	. = ..()
	handle_protean_hunger(owner, seconds_per_tick)

/obj/item/organ/stomach/protean/proc/handle_protean_hunger(mob/living/carbon/human/human, seconds_per_tick)
	if(!istype(owner.dna.species, /datum/species/protean))
		return
	if(isnull(owner.client)) // So we dont die from afk/crashing out
		return
	if(metal > PROTEAN_STOMACH_FALTERING)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)
		var/hunger_modifier = metabolism_modifier
		// If we're high enough on metal we might try to heal or recover blood
		if(metal > PROTEAN_STOMACH_FULL * 0.3)
			if(owner.health < owner.maxHealth)
				var/healing_amount = -2
				hunger_modifier += 20
				if(!COOLDOWN_FINISHED(src, damage_delay))
					var/cooldown_left = (REGEN_TIME - COOLDOWN_TIMELEFT(src, damage_delay)) / REGEN_TIME
					hunger_modifier *= cooldown_left
					healing_amount *= cooldown_left
				owner.adjust_brute_loss(healing_amount, forced = TRUE)
				owner.adjust_fire_loss(healing_amount, forced = TRUE)
			if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
				hunger_modifier += 100
				owner.blood_volume = min(owner.blood_volume + (((BLOOD_REGEN_FACTOR * PROTEAN_METABOLISM_RATE) * 0.05) * seconds_per_tick), BLOOD_VOLUME_NORMAL)
		metal -= clamp(((PROTEAN_STOMACH_FULL / PROTEAN_METABOLISM_RATE) * hunger_modifier * seconds_per_tick), 0, metal_max)
		return
	owner.adjust_brute_loss(2, forced = TRUE)
	if(COOLDOWN_FINISHED(src, starving_message))
		to_chat(owner, span_warning("You are starving! You must find metal now!"))
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown, multiplicative_slowdown = 2)
		COOLDOWN_START(src, starving_message, 20 SECONDS)

/obj/item/organ/stomach/protean/proc/damage_listener()
	SIGNAL_HANDLER

	if(COOLDOWN_STARTED(src, damage_delay))
		COOLDOWN_RESET(src, damage_delay)
	COOLDOWN_START(src, damage_delay, REGEN_TIME)

/// Check to see if our metal storage is full.
/obj/item/organ/stomach/protean/proc/try_stomach_eat(mob/eater, atom/eating)
	SIGNAL_HANDLER

	if(istype(eating, /obj/item/food/golem_food))
		var/obj/item/food/golem_food/food = eating
		if(metal > (PROTEAN_STOMACH_FULL - 0.3) && food.owner.loc == owner)
			balloon_alert(owner, "storage full!")
			return COMSIG_CARBON_BLOCK_EAT

/// If we ate a sheet of metal, add it to storage.
/obj/item/organ/stomach/protean/after_eat(atom/edible)
	if(istype(edible, /obj/item/food/golem_food))
		var/obj/item/food/golem_food/food = edible
		metal = clamp(metal + 1, 0, PROTEAN_STOMACH_FULL)
		if(food.owner.loc != owner) // Other people feeding them will heal them.
			owner.adjust_brute_loss(-20, forced = TRUE)
			var/health_check = owner.health >= owner.maxHealth ? "fully healed!" : "healed!"
			owner.balloon_alert_to_viewers("[health_check]")

#undef REGEN_TIME
#undef PROTEAN_STOMACH_FULL
#undef PROTEAN_STOMACH_FALTERING
