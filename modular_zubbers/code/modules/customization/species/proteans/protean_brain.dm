/**
 * HANDLES ALL OF PROTEAN EXISTENCE CODE.
 * Very snowflakey species. This is the communication chain.
 * Brain > Refactory > Modsuit Core > Modsuit
 * Brain > Orchestrator
 * Brain > Murder every other organ you try to shove in this thing.
 */

/obj/item/organ/brain/protean
	name = "protean core"
	desc = "An advanced positronic brain, typically found in the core of a protean"
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "posi1"
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE
	organ_traits = list(TRAIT_SILICON_EMOTES_ALLOWED)
	/// Whether or not the protean is stuck in their suit or not.
	var/dead = FALSE
	COOLDOWN_DECLARE(message_cooldown)
	COOLDOWN_DECLARE(refactory_cooldown)
	COOLDOWN_DECLARE(orchestrator_cooldown)

/obj/item/organ/brain/protean/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/damage_amount = 4

	for(var/obj/item/organ/organ in owner.organs)
		if(!(organ.organ_flags & ORGAN_ORGANIC))
			continue
		apply_organ_damage(damage_amount, damage)
		if(COOLDOWN_FINISHED(src, message_cooldown))
			to_chat(owner, span_warning("Your mass violently rips apart [organ]!"))
			COOLDOWN_START(src, message_cooldown, 5 SECONDS)
		if(organ.organ_flags & ORGAN_FAILING)
			to_chat(owner, span_warning("Your mass violently rejects [organ]"))
			forceMove(owner.loc)

	handle_refactory(owner.get_organ_slot(ORGAN_SLOT_STOMACH))
	handle_orchestrator(owner.get_organ_slot(ORGAN_SLOT_HEART))
	if(owner.stat >= HARD_CRIT && !dead)
		to_chat(owner, span_red("Your fragile refactory withers away with your mass reduced to scraps. Someone will have to help you."))
		dead = TRUE
		// TODO: Custom death

/obj/item/organ/brain/protean/proc/handle_refactory(obj/item/organ) // Slowly degrade
	if(isnull(organ) || !istype(organ, /obj/item/organ/stomach/protean))
		owner.adjustBruteLoss(3, forced = TRUE)

/obj/item/organ/brain/protean/proc/handle_orchestrator(obj/item/organ) // If you're missing an orchestrator, you will have trouble walking.
	if(!COOLDOWN_FINISHED(src, orchestrator_cooldown))
		return

	if(isnull(organ) || !istype(organ, /obj/item/organ/heart/protean))
		owner.KnockToFloor(FALSE, TRUE, 0.5 SECONDS)
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown, multiplicative_slowdown = 2)
	else
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)

	COOLDOWN_START(src, orchestrator_cooldown, 5 SECONDS)

/datum/movespeed_modifier/protean_slowdown
	variable = TRUE

/obj/item/organ/brain/protean/proc/go_into_suit()
