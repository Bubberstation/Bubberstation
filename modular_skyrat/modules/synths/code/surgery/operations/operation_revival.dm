/datum/surgery_operation/basic/revive_synth
	name = "reboot neural network"
	rnd_name = "Restart Neural Network (Revival)"
	desc = "A mechanical surgical procedure that restarts an android's neural network."
	implements = list(
		TOOL_MULTITOOL = 1,
		/obj/item/shockpaddles = 1.43,
		/obj/item/melee/touch_attack/shock = 1.43,
		/obj/item/melee/baton/security = 2.86,
		/obj/item/gun/energy = 10,
	)
	operation_flags = OPERATION_MORBID | OPERATION_NOTABLE
	time = 5 SECONDS
	target_zone = BODY_ZONE_CHEST
	required_biotype = MOB_ROBOTIC
	required_bodytype = BODYTYPE_SYNTHETIC
	all_surgery_states_required = SURGERY_SKIN_OPEN | SURGERY_BONE_SAWED

/datum/surgery_operation/basic/revive_synth/get_default_radial_image()
	return image(/obj/item/multitool)

/datum/surgery_operation/basic/revive_synth/all_required_strings()
	return ..() + list("the patient must be deceased", "the patient must be in a revivable state", "the patient must be synthetic")

/datum/surgery_operation/basic/revive_synth/state_check(mob/living/patient)
	if(patient.stat != DEAD)
		return FALSE
	if(HAS_TRAIT(patient, TRAIT_SUICIDED) || HAS_TRAIT(patient, TRAIT_HUSK) || HAS_TRAIT(patient, TRAIT_DEFIB_BLACKLISTED))
		return FALSE
	if(patient.has_limbs)
		var/obj/item/organ/brain/synth/brain = patient.get_organ_slot(ORGAN_SLOT_BRAIN)
		return !isnull(brain) && brain_check(brain)
	return mob_check(patient)

/datum/surgery_operation/basic/revive_synth/proc/brain_check(obj/item/organ/brain/brain)
	return !IS_ROBOTIC_ORGAN(brain)

/datum/surgery_operation/basic/revive_synth/proc/mob_check(mob/living/patient)
	return !(patient.mob_biotypes & MOB_ROBOTIC)

/datum/surgery_operation/basic/revive_synth/tool_check(obj/item/tool)
	if(istype(tool, /obj/item/shockpaddles))
		var/obj/item/shockpaddles/paddles = tool
		if((paddles.req_defib && !paddles.defib.powered) || !HAS_TRAIT(paddles, TRAIT_WIELDED) || paddles.cooldown || paddles.busy)
			return FALSE

	if(istype(tool, /obj/item/melee/baton/security))
		var/obj/item/melee/baton/security/baton = tool
		return baton.active

	if(istype(tool, /obj/item/gun/energy))
		var/obj/item/gun/energy/egun = tool
		return istype(egun.chambered, /obj/item/ammo_casing/energy/electrode)

	return TRUE

/datum/surgery_operation/basic/revive_synth/on_preop(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = patient.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(synth_brain)
		brain_type = synth_brain.name
	display_results(
		surgeon,
		patient,
		span_notice("You begin to force a reboot in [patient]'s [brain_type]..."),
		span_notice("[surgeon] begins to force a reboot in [patient]'s [brain_type]."),
		span_notice("[surgeon] begins to force a reboot in [patient]'s [brain_type].")
	)

	patient.notify_revival("Someone is trying to reboot your [brain_type].", source = patient)

/datum/surgery_operation/basic/revive_synth/on_success(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = patient.get_organ_slot(ORGAN_SLOT_BRAIN)
	brain_type = synth_brain.name
	display_results(
		surgeon,
		patient,
		span_notice("You successfully shock [patient]'s [brain_type] with [tool]..."),
		span_notice("[surgeon] sends a powerful shock to [patient]'s [brain_type] with [tool]..."),
		span_notice("[surgeon] sends a powerful shock to [patient]'s [brain_type]..."),
	)
	patient.grab_ghost()
	if(iscarbon(patient))
		var/mob/living/carbon/carbon_patient = patient
		carbon_patient.set_heartattack(FALSE)
	if(!patient.revive())
		on_no_revive(surgeon, patient)
		return

	on_revived(surgeon, patient)

/// Call when successfully revived
/datum/surgery_operation/basic/revive_synth/proc/on_revived(mob/living/surgeon, mob/living/patient)
	if (patient.stat < DEAD)
		patient.visible_message(span_notice("...[patient] is completely unaffected! Seems like they're already active!"))
		return TRUE
	patient.grab_ghost()
	if(patient.revive())
		patient.emote("chime")
		patient.visible_message(span_notice("...[patient] reactivates, their chassis coming online!"))
		if(HAS_MIND_TRAIT(surgeon, TRAIT_MORBID)) // Contrary to their typical hatred of resurrection, it wouldn't be very thematic if morbid people didn't love playing god
			surgeon.add_mood_event("morbid_revival_success", /datum/mood_event/morbid_revival_success)
		to_chat(patient, span_danger("[CONFIG_GET(string/blackoutpolicy)]"))
	patient.adjust_organ_loss(ORGAN_SLOT_BRAIN, 15, 180)

/// Called when revival fails
/datum/surgery_operation/basic/revive_synth/proc/on_no_revive(mob/living/surgeon, mob/living/patient)
	patient.emote("buzz")
	patient.visible_message(span_warning("...[patient.p_they()] convulses, then goes offline."))
	patient.adjust_organ_loss(ORGAN_SLOT_BRAIN, 50, 199) // MAD SCIENCE

/// Flavor for failure
/datum/surgery_operation/basic/revive_synth/on_failure(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = patient.get_organ_slot(ORGAN_SLOT_BRAIN)
	brain_type = synth_brain.name
	display_results(
		surgeon,
		patient,
		span_warning("You shock [patient]'s [brain_type] with [tool], but [patient.p_they()] don't react."),
		span_warning("[surgeon] shocks [patient]'s [brain_type] with [tool], but [patient.p_they()] don't react."),
		span_warning("[surgeon] shocks [patient]'s [brain_type] with [tool], but [patient.p_they()] don't react."),
	)
/datum/surgery_operation/basic/revive_synth/brain_check(obj/item/organ/brain/synth/brain)
	return !..()

/datum/surgery_operation/basic/revive_synth/mob_check(mob/living/patient)
	return !..()
