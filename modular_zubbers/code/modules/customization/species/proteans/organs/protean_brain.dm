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
	COOLDOWN_DECLARE(message_cooldown)
	COOLDOWN_DECLARE(refactory_cooldown)
	COOLDOWN_DECLARE(orchestrator_cooldown)

/obj/item/organ/brain/protean/on_life(seconds_per_tick, times_fired)
	. = ..()

	handle_refactory(owner.get_organ_slot(ORGAN_SLOT_STOMACH))
	handle_orchestrator(owner.get_organ_slot(ORGAN_SLOT_HEART))
	if(owner.stat >= DEAD)
		to_chat(owner, span_red("Your fragile refactory withers away with your mass reduced to scraps. Someone will have to help you."))
		splat_handler()


/obj/item/organ/brain/protean/proc/handle_refactory(obj/item/organ) // Slowly degrade
	var/datum/species/protean/species = owner?.dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(owner.loc == suit)
		return
	if(isnull(organ) || !istype(organ, /obj/item/organ/stomach/protean))
		owner.adjust_brute_loss(3, forced = TRUE)
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

/obj/item/organ/brain/protean/proc/splat_handler()
	var/obj/item/mmi/posibrain/sphere/protean_mmi = new(get_turf(src))

	var/list/droplist = owner.drop_everything(del_on_drop = FALSE, force = TRUE, del_if_nodrop = FALSE)
	for(var/obj/loot as anything in droplist)
		loot.throw_at(get_step_rand(src), 2, 4, owner, TRUE)
	owner.gib(DROP_BRAIN | DROP_ITEMS)
	protean_mmi.force_brain_into(src)



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

/obj/item/organ/brain/protean/proc/enter_core_revive()

/obj/item/mmi/posibrain/sphere/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	brain.tool_act(user, tool, modifiers)

/obj/item/organ/brain/protean/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()

	if(istype(tool, /obj/item/pen))
		to_chat(user, span_notice("You begin to reset the protean's random access memory using a pen."))
		user.balloon_alert_to_viewers("resetting memory")
		user.visible_message(span_boldwarning("[user] is reaching a pen into [src]!"))
		playsound(src, 'sound/machines/synth/synth_no.ogg', 100)
		if(!do_after(user, 10 SECONDS))
			return
		src.say("Alert - Random Access Memory Reset. Current memories lost. Any interactions that were ongoing have been forgotten.", forced = TRUE)
		src.log_message("has had their memory reset.", LOG_ATTACK)
		to_chat(src, span_boldwarning("Your memories have been reset. You cannot remember who reset you or any of the events leading up to your reset."))
		playsound(src, 'sound/machines/synth/synth_yes.ogg', 100)
		playsound(src, 'sound/machines/click.ogg', 100)

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
