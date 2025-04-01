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
	RegisterSignal(src, COMSIG_PROTEAN_EAT, PROC_REF(add_metal))
	RegisterSignal(src, COMSIG_MOB_PRE_EAT, PROC_REF(check_metal))

/obj/item/organ/stomach/protean/on_life(seconds_per_tick, times_fired)
	/// Zero out any nutrition. We do not use hunger in this species.
	for(var/datum/reagent/consumable/food in reagents.reagent_list)
		food.nutriment_factor = 0
	. = ..()
	metal -= ((PROTEAN_STOMACH_FULL / 4000) * seconds_per_tick)

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

/obj/item/organ/stomach/protean/proc/add_metal(mob/eater)
	SIGNAL_HANDLER

	metal += clamp(1, 0, 10)

/obj/item/organ/stomach/protean/proc/check_metal(mob/eater)
	SIGNAL_HANDLER

	if(metal >= PROTEAN_STOMACH_FULL)
		balloon_alert(owner, "storage full!")
		return COMSIG_CARBON_BLOCK_EAT

#undef PROTEAN_STOMACH_FULL
#undef PROTEAN_STOMACH_FALTERING
