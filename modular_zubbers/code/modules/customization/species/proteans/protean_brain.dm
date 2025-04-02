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
	var/damage_amount = 4 // How much damage per life() tick this organ should apply

	for(var/obj/item/organ/organ in owner.organs)
		if(!(organ.organ_flags & ORGAN_ORGANIC))
			continue
		apply_organ_damage(damage_amount)
		if(COOLDOWN_FINISHED(src, message_cooldown))
			to_chat(owner, span_warning("Your mass violently rips apart [organ]!"))
			COOLDOWN_START(src, message_cooldown, 30 SECONDS)
		if(organ.organ_flags & ORGAN_FAILING)
			to_chat(owner, span_warning("Your mass violently rejects [organ]"))
			forceMove(owner.loc)

	handle_refactory(owner.get_organ_slot(ORGAN_SLOT_STOMACH))
	handle_orchestrator(owner.get_organ_slot(ORGAN_SLOT_HEART))
	if(owner.stat >= HARD_CRIT && !dead)
		to_chat(owner, span_red("Your fragile refactory withers away with your mass reduced to scraps. Someone will have to help you."))
		dead = TRUE
		qdel(owner.get_organ_slot(ORGAN_SLOT_STOMACH))
		go_into_suit(TRUE)

/obj/item/organ/brain/protean/proc/handle_refactory(obj/item/organ) // Slowly degrade
	if(dead)
		return
	if(isnull(organ) || !istype(organ, /obj/item/organ/stomach/protean))
		owner.adjustBruteLoss(3, forced = TRUE)
		if(COOLDOWN_FINISHED(src, refactory_cooldown))
			to_chat(owner, span_warning("Your mass is slowly degrading without your refactory!"))
			COOLDOWN_START(src, refactory_cooldown, 30 SECONDS)

/obj/item/organ/brain/protean/proc/handle_orchestrator(obj/item/organ) // If you're missing an orchestrator, you will have trouble walking.
	if(dead)
		return
	if(!COOLDOWN_FINISHED(src, orchestrator_cooldown))
		return

	if(isnull(organ) || !istype(organ, /obj/item/organ/heart/protean))
		owner.KnockToFloor(TRUE, TRUE, 1 SECONDS)
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown, multiplicative_slowdown = 2)
		to_chat(owner, span_warning("You're struggling to walk without your orchestrator!"))
	else
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)

	COOLDOWN_START(src, orchestrator_cooldown, 30 SECONDS)

/datum/movespeed_modifier/protean_slowdown
	variable = TRUE

/obj/item/organ/brain/protean/proc/go_into_suit(forced)
	var/datum/species/protean/protean = owner.dna?.species
	if(!istype(protean))
		return
	var/obj/item/mod/control/pre_equipped/protean/suit = protean.species_modsuit
	owner.invisibility = 101
	new /obj/effect/temp_visual/protean_to_suit(owner.loc, owner.dir)
	sleep(12)
	owner.Paralyze(INFINITY, TRUE)
	owner.dropItemToGround(suit, TRUE, TRUE, TRUE)
	owner.forceMove(suit)
	owner.invisibility = initial(owner.invisibility)

/obj/item/organ/brain/protean/proc/leave_modsuit()
	var/datum/species/protean/protean = owner.dna?.species
	if(!istype(protean))
		return
	var/obj/item/mod/control/pre_equipped/protean/suit = protean.species_modsuit
	if(dead)
		to_chat(owner, span_warning("Your mass is destroyed. You are unable to leave."))
		return
	suit.invisibility = 101
	new /obj/effect/temp_visual/protean_from_suit(get_turf(suit), owner.dir)
	sleep(12)
	suit.drop_suit()
	owner.equip_to_slot_if_possible(suit, ITEM_SLOT_BACK, disable_warning = TRUE)
	suit.invisibility = initial(suit.invisibility)
	owner.SetParalyzed(0, TRUE)
	if(owner.IsParalyzed())
		to_chat(owner, span_warning("AHELP if you can't move and contact a coder if you see this message. Tell the admin to delete your status effect."))
		stack_trace("Protean is immobilized coming out of their suit!")

/obj/effect/temp_visual/protean_to_suit
	name = "to_suit"
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "to_puddle"
	duration = 12

/obj/effect/temp_visual/protean_from_suit
	name = "from_suit"
	icon = PROTEAN_ORGAN_SPRITE
	icon_state = "from_puddle"
	duration = 12
