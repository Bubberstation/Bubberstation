/obj/item/organ/stomach/protean
	name = "refactory"
	desc = "An extremely fragile factory used to rescyle materials and create more nanite mass"
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "refactory"
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE
	organ_traits = list(TRAIT_NOHUNGER)

	/// How much max metal can we hold at any given time (In sheets). This isn't using nutrition code because nutrition code gets weird without livers.
	var/metal_max = PROTEAN_STOMACH_FULL
	/// How much metal are we holding currently (In sheets)
	var/metal = PROTEAN_STOMACH_FULL
	COOLDOWN_DECLARE(starving_message)

/obj/item/organ/stomach/protean/Initialize(mapload)
	. = ..() // Call the rest of the proc
	metal = round(rand(PROTEAN_STOMACH_FULL/2, PROTEAN_STOMACH_FULL))

/obj/item/organ/stomach/protean/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	RegisterSignal(owner, COMSIG_CARBON_ATTEMPT_EAT, PROC_REF(try_eat))

/obj/item/organ/stomach/protean/on_mob_remove(mob/living/carbon/stomach_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(owner, COMSIG_CARBON_ATTEMPT_EAT)

/obj/item/organ/stomach/protean/on_life(seconds_per_tick, times_fired)
	/// Zero out any nutrition. We do not use hunger in this species.
	for(var/datum/reagent/consumable/food in reagents.reagent_list)
		food.nutriment_factor = 0
	. = ..()
	metal -= ((PROTEAN_STOMACH_FULL / PROTEAN_METABOLISM_RATE) * seconds_per_tick)

/// Reused here to check if our stomach is faltering
/obj/item/organ/stomach/protean/handle_hunger_slowdown(mob/living/carbon/human/human)
	if(!istype(owner.dna.species, /datum/species/protean))
		return
	if(metal > PROTEAN_STOMACH_FALTERING)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)
		return
	owner.adjustBruteLoss(2, forced = TRUE)
	if(COOLDOWN_FINISHED(src, starving_message))
		to_chat(owner, span_warning("You are starving! You must find metal now!"))
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown, multiplicative_slowdown = 2)
		COOLDOWN_START(src, starving_message, 20 SECONDS)

/// Check to see if our metal storage is full.
/obj/item/organ/stomach/protean/proc/try_eat(mob/eater, atom/eating)
	SIGNAL_HANDLER

	if(istype(eating, /obj/item/food/golem_food))
		if(metal >= PROTEAN_STOMACH_FULL)
			balloon_alert(owner, "storage full!")
			return COMSIG_CARBON_BLOCK_EAT

/// If we ate a sheet of metal, add it to storage.
/obj/item/organ/stomach/protean/proc/check_eat(mob/eater, atom/eating)
	SIGNAL_HANDLER

	if(istype(eating, /obj/item/food/golem_food))
		metal += clamp(1, 0, PROTEAN_STOMACH_FULL)

/**
 * Listens to COMSIG_FOOD_EATEN registered on [/obj/item/food/golem_food] for if a protean is eating it.
 * This should probally be given its own carbon after eating signal. All carbons have is COMSIG_CARBON_ATTEMPT_EAT.
 */

/obj/item/food/golem_food/proc/check_protean(mob/living/carbon/eating, mob/feeder)
	SIGNAL_HANDLER

	var/obj/item/organ/stomach/protean/stomach = eating.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(isprotean(eating))
		if(istype(stomach))
			stomach.metal += clamp(1, 0, PROTEAN_STOMACH_FULL)

	if(!isnull(feeder) && stomach.owner.health < stomach.owner.maxHealth) // Heals if someone else feeds them.
		stomach.owner.adjustBruteLoss(-20, forced = TRUE)
		balloon_alert(feeder, "healed!")

#undef PROTEAN_STOMACH_FULL
#undef PROTEAN_STOMACH_FALTERING
