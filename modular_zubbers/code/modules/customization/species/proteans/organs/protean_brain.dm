#define TRANSFORM_TRAITS list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_RESISTHEAT, TRAIT_RESISTCOLD)

/**
 * HANDLES ALL OF PROTEAN EXISTENCE CODE.
 * Very snowflakey species. This is the communication chain.
 * Brain > Refactory > Modsuit Core > Modsuit
 * Brain > Orchestrator
 * Brain > Murder every other organ you try to shove in this thing.
 */

/obj/item/organ/brain/protean
	name = "protean core"
	desc = "An advanced positronic brain, typically found in the core of a protean."
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
	if(dead)
		return
	handle_refactory(owner.get_organ_slot(ORGAN_SLOT_STOMACH))
	handle_orchestrator(owner.get_organ_slot(ORGAN_SLOT_HEART))
	if(owner.stat >= HARD_CRIT && !dead)
		to_chat(owner, span_red("Your fragile refactory withers away with your mass reduced to scraps. Someone will have to help you."))
		dead = TRUE
		owner.revive(list(HEAL_DAMAGE, HEAL_ORGANS), TRUE, TRUE) // So we dont get dead human inside of suit
		qdel(owner.get_organ_slot(ORGAN_SLOT_STOMACH))
		go_into_suit(TRUE)
		owner.add_traits(list(TRAIT_CRITICAL_CONDITION)) // Just to make crew monitoring console scream

/obj/item/organ/brain/protean/proc/handle_refactory(obj/item/organ) // Slowly degrade
	var/datum/species/protean/species = owner?.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(owner.loc == suit)
		return
	if(isnull(organ) || !istype(organ, /obj/item/organ/stomach/protean))
		owner.adjustBruteLoss(3, forced = TRUE)
		if(COOLDOWN_FINISHED(src, refactory_cooldown))
			to_chat(owner, span_warning("Your mass is slowly degrading without your refactory!"))
			COOLDOWN_START(src, refactory_cooldown, 30 SECONDS)

/obj/item/organ/brain/protean/proc/handle_orchestrator(obj/item/organ) // If you're missing an orchestrator, you will have trouble walking.
	var/datum/species/protean/species = owner?.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(owner.loc == suit)
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
	if(!istype(protean) || owner.loc == protean.species_modsuit)
		return
	var/obj/item/mod/control/pre_equipped/protean/suit = protean.species_modsuit
	if(!forced)
		if(!do_after(owner, 5 SECONDS))
			return
	owner.visible_message(span_warning("[owner] retreats into [suit]!"))
	owner.extinguish_mob()
	owner.invisibility = 101
	new /obj/effect/temp_visual/protean_to_suit(owner.loc, owner.dir)
	owner.Stun(INFINITY, TRUE)
	owner.add_traits(TRANSFORM_TRAITS, PROTEAN_TRAIT)
	owner.remove_status_effect(/datum/status_effect/protean_low_power_mode/low_power)
	suit.drop_suit()
	owner.forceMove(suit)
	sleep(12) //Sleep is fine here because I'm not returning anything and if the brain gets deleted within 12 ticks of this being ran, we have some other serious issues.
	owner.invisibility = initial(owner.invisibility)

/obj/item/organ/brain/protean/proc/leave_modsuit()
	var/datum/species/protean/protean = owner.dna?.species
	if(!istype(protean))
		return
	var/obj/item/mod/control/pre_equipped/protean/suit = protean.species_modsuit
	if(dead)
		to_chat(owner, span_warning("Your mass is destroyed. You are unable to leave."))
		return
	if(!do_after(owner, 5 SECONDS, suit, IGNORE_INCAPACITATED))
		return
	if(istype(suit.loc, /obj/item/reagent_containers/cup/soup_pot)) // If protean inside of soup pot
		var/obj/item/reagent_containers/cup/soup_pot/pot = suit.loc
		pot.remove_first_ingredient(null)
	var/mob/living/carbon/mob = suit.loc
	if(istype(mob))
		mob.dropItemToGround(suit, TRUE)
	var/datum/storage/storage = suit.loc.atom_storage
	if(istype(storage))
		storage.remove_single(null, suit, get_turf(suit), TRUE)
	suit.invisibility = 101
	new /obj/effect/temp_visual/protean_from_suit(suit.loc, owner.dir)
	sleep(12) //Same as above
	suit.drop_suit()
	owner.forceMove(suit.loc)
	if(owner.get_item_by_slot(ITEM_SLOT_BACK))
		owner.dropItemToGround(owner.get_item_by_slot(ITEM_SLOT_BACK), TRUE, TRUE, TRUE)
	owner.equip_to_slot_if_possible(suit, ITEM_SLOT_BACK, disable_warning = TRUE)
	suit.invisibility = initial(suit.invisibility)
	owner.SetStun(0)
	owner.remove_traits(TRANSFORM_TRAITS, PROTEAN_TRAIT)
	owner.apply_status_effect(/datum/status_effect/protean_low_power_mode/reform)
	owner.visible_message(span_warning("[owner] reforms from [suit]!"))
	if(!HAS_TRAIT(suit, TRAIT_NODROP))
		ADD_TRAIT(suit, TRAIT_NODROP, "protean")

/obj/item/organ/brain/protean/proc/replace_limbs()
	var/obj/item/organ/stomach/protean/stomach = owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	var/obj/item/organ/eyes/robotic/protean/eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
	var/obj/item/organ/tongue/cybernetic/protean/tongue = owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	var/obj/item/organ/ears/cybernetic/protean/ears = owner.get_organ_slot(ORGAN_SLOT_EARS)
	var/obj/item/organ/liver/protean/liver = owner.get_organ_slot(ORGAN_SLOT_LIVER)

	if(stomach.metal <= PROTEAN_STOMACH_FULL * 0.6 && istype(stomach))
		to_chat(owner, span_warning("Not enough metal to heal body!"))
		return
	if(!istype(owner.loc, /obj/item/mod/control))
		to_chat(owner, span_warning("Not in the open. You must be inside your suit!"))
		return
	var/datum/species/protean/species = owner.dna.species
	if(!do_after(owner, 30 SECONDS, species.species_modsuit, IGNORE_INCAPACITATED))
		return

	stomach.metal = clamp(stomach.metal - (PROTEAN_STOMACH_FULL * 0.6), 0, 10)
	owner.fully_heal(HEAL_LIMBS)
	if(isnull(eyes))
		eyes = new /obj/item/organ/eyes/robotic/protean
		eyes.on_bodypart_insert()
		eyes.Insert(owner, TRUE)
	else if(organ_flags & ORGAN_NANOMACHINE)
		eyes.set_organ_damage(0)

	if(isnull(tongue))
		tongue = new /obj/item/organ/tongue/cybernetic/protean
		tongue.on_bodypart_insert()
		tongue.Insert(owner, TRUE)
	else if(organ_flags & ORGAN_NANOMACHINE)
		tongue.set_organ_damage(0)

	if(isnull(ears))
		ears = new /obj/item/organ/ears/cybernetic/protean
		ears.on_bodypart_insert()
		ears.Insert(owner, TRUE)
	else if(organ_flags & ORGAN_NANOMACHINE)
		ears.set_organ_damage(0)

	if(isnull(liver))
		liver = new /obj/item/organ/liver/protean
		liver.on_bodypart_insert()
		liver.Insert(owner, TRUE)
	else if(organ_flags & ORGAN_NANOMACHINE)
		liver.set_organ_damage(0)

/obj/item/organ/brain/protean/proc/revive()
	dead = FALSE
	playsound(owner, 'sound/machines/ping.ogg', 30)
	to_chat(owner, span_warning("You have regained all your mass!"))
	owner.fully_heal()
	owner.remove_traits(list(TRAIT_CRITICAL_CONDITION))

/obj/item/organ/brain/protean/proc/revive_timer()
	balloon_alert_to_viewers("repairing")
	addtimer(CALLBACK(src, PROC_REF(revive)), 5 MINUTES) // Bump to 5 minutes

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

/obj/item/organ/brain/protean/emp_act(severity) // technically, a protean brain isn't a cybernetic brain, so it's not inherting the normal cybernetic proc.
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(owner.stat == DEAD)
		return
	switch(severity)
		if (EMP_HEAVY)
			to_chat(owner, span_boldwarning("Your core nanites [pick("buzz erratically", "surge chaotically")]!"))
			owner.set_drugginess_if_lower(40 SECONDS)
		if (EMP_LIGHT)
			to_chat(owner, span_warning("Your core nanites feel [pick("fuzzy", "unruly", "sluggish")]."))
			owner.set_drugginess_if_lower(20 SECONDS)

#undef TRANSFORM_TRAITS
