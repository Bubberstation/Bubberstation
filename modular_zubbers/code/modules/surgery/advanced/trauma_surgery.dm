/datum/surgery/brain_surgery
	desc = "A minor head surgery for repairing brain damage and removing mild traumas."

/datum/surgery/advanced/neurectomy
	name = "Neurectomy"
	desc = "An invasive surgical procedure which guarantees removal of deep-rooted brain traumas, but takes a while for the body to recover..."
	possible_locs = list(BODY_ZONE_HEAD)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/neurectomy,
		/datum/surgery_step/close,
	)
	var/resilience_level = TRAUMA_RESILIENCE_LOBOTOMY

/datum/surgery/advanced/neurectomy/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	if(!.)
		return FALSE

	var/obj/item/organ/brain/target_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!target_brain)
		return FALSE

	if(LAZYLEN(target.get_traumas()))
		for(var/active_trauma in target.get_traumas())
			var/datum/brain_trauma/trauma = active_trauma
			if(trauma.resilience == resilience_level)
				return TRUE

	return FALSE

/datum/surgery_step/neurectomy
	name = "reticulate nerve splines (scalpel)"
	implements = list(
		TOOL_SCALPEL = 100,
		/obj/item/melee/energy/sword = 55,
		/obj/item/knife = 35,
		/obj/item/shard = 25,
		/obj/item/pen = 15,
	)
	chems_needed = list(
		/datum/reagent/medicine/neurine,
	)
	time = 10 SECONDS
	repeatable = FALSE
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	surgery_effects_mood = TRUE

/datum/surgery_step/neurectomy/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to excise the nerve in [target]'s brain..."),
		span_notice("[user] begins to fix [target]'s brain."),
		span_notice("[user] begins to perform surgery on [target]'s brain."),
	)
	display_pain(target, "Your head pounds with unimaginable pain!")

/datum/surgery_step/neurectomy/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(
		user,
		target,
		span_notice("You succeed in excising [target]'s failed nerve."),
		span_notice("[user] successfully excises [target]'s nerve!"),
		span_notice("[user] completes the surgery on [target]'s brain."),
	)
	display_pain(target, "Your head goes totally numb for a moment, the pain is overwhelming!")

	target.set_organ_loss(ORGAN_SLOT_BRAIN, target.get_organ_loss(ORGAN_SLOT_BRAIN) - 40)
	target.cure_all_traumas(TRAUMA_RESILIENCE_BASIC)
	target.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	target.cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)
	var/datum/surgery/advanced/neurectomy/surgery_type = surgery
	if(surgery_type.resilience_level == TRAUMA_RESILIENCE_MAGIC)
		target.cure_all_traumas(TRAUMA_RESILIENCE_MAGIC)
		playsound(source = get_turf(target), soundin = 'sound/effects/magic/repulse.ogg', vol = 75, vary = TRUE, falloff_distance = 2)
	target.apply_status_effect(/datum/status_effect/vulnerable_to_damage/surgery)
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/brainwashed))
		target.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	return ..()

/datum/surgery_step/neurectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/organ/brain/target_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(target_brain)
		display_results(
			user,
			target,
			span_warning("You excise the wrong nerve, causing more damage!"),
			span_warning("[user] fails to excise [target]'s brain!"),
			span_notice("[user] completes the surgery on [target]'s brain."),
		)
		display_pain(target, "The pain in your head only seems to get worse!")
		target_brain.apply_organ_damage(80)
		target.apply_status_effect(/datum/status_effect/vulnerable_to_damage/surgery)
		switch(rand(1,3))
			if(1)
				target.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_MAGIC)
			if(2)
				if(HAS_TRAIT(target, TRAIT_SPECIAL_TRAUMA_BOOST) && prob(50))
					target.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_MAGIC)
				else
					target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_MAGIC)
			if(3)
				target.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_MAGIC)
	else
		user.visible_message(span_warning("[user] suddenly notices that the brain [user.p_they()] [user.p_were()] working on is not there anymore."), span_warning("You suddenly notice that the brain you were working on is not there anymore."))
	return FALSE

/datum/surgery/advanced/neurectomy/blessed
	name = "Blessed Neurectomy"
	desc = "We're not quite sure exactly how it works, but with the blessing of a chaplain combined with modern chemicals, this manages to remove soul-bound traumas once thought to be magic."
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/neurectomy/blessed,
		/datum/surgery_step/close,
	)
	resilience_level = TRAUMA_RESILIENCE_MAGIC

/datum/surgery_step/neurectomy/blessed
	name = "reticulate nerve splines (scalpel)"
	chems_needed = list(
		/datum/reagent/water/holywater,
		/datum/reagent/medicine/neurine,
	)
