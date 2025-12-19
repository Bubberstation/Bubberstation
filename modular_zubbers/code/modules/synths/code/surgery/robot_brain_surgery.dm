/datum/surgery/robot_brain_surgery
	name = "Reset Posibrain Logic (Brain Surgery)"
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fix_robot_brain,
		/datum/surgery_step/mechanic_close,
	)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST) // The brains are in the chest
	requires_bodypart_type = BODYTYPE_ROBOTIC
	desc = "A surgical procedure that restores the default behavior logic and personality matrix of an IPC posibrain, removing deep-rooted traumas."

/datum/surgery/robot_brain_surgery/can_start(mob/user, mob/living/carbon/target, obj/item/tool)
	var/obj/item/organ/brain/synth/brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)

	if (!..())
		return FALSE

	if(!istype(brain) && !issynthetic(target))
		return FALSE
	else
		return TRUE

/datum/surgery_step/fix_robot_brain
	name = "fix posibrain (multitool/hemostat)"
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 90,
		/obj/item/pen = 15)
	repeatable = TRUE
	preop_sound = 'sound/items/handling/tools/multitool_pickup.ogg'
	success_sound = 'sound/items/handling/tools/multitool_drop.ogg'
	failure_sound = 'sound/items/handling/tools/multitool_drop.ogg'
	time = 12 SECONDS //long and complicated

/datum/surgery_step/fix_robot_brain/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to clear system corruption from [target]'s posibrain..."),
		"[user] begins to fix [target]'s posibrain.",
		"[user] begins to perform surgery on [target]'s posibrain.",
	)

/datum/surgery_step/fix_robot_brain/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user,
		target,
		span_notice("You succeed in clearing system corruption from [target]'s posibrain."),
		"[user] successfully fixes [target]'s posibrain!",
		"[user] completes the surgery on [target]'s posibrain.",
	)

	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/brainwashed))
		target.mind.remove_antag_datum(/datum/antagonist/brainwashed)

	target.setOrganLoss(ORGAN_SLOT_BRAIN, target.get_organ_loss(ORGAN_SLOT_BRAIN) - 60)	//we set damage in this case in order to clear the "failing" flag
	target.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	if(target.get_organ_loss(ORGAN_SLOT_BRAIN) > NONE)
		to_chat(user, "[target]'s posibrain still has some lasting system damage that can be cleared.")

	return ..()

/datum/surgery_step/fix_robot_brain/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.get_organ_slot(ORGAN_SLOT_BRAIN))
		display_results(
			user,
			target,
			span_warning("You screw up, fragmenting their data!"),
			span_warning("[user] screws up, causing damage to the circuits!"),
			"[user] completes the surgery on [target]'s posibrain.",
		)

		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 60)
		target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
	else
		user.visible_message(span_warning("[user] suddenly notices that the posibrain [user.p_they()] [user.p_were()] working on is not there anymore."), span_warning("You suddenly notice that the posibrain you were working on is not there anymore."))

	return FALSE

/datum/surgery/robot_trauma_surgery
	name = "Neural Defragmentation (Neurectomy)"
	desc = "Requires Liquid Solder. A surgical procedure that refurbishes low level components in the posibrain, to fix deep-rooted trauma errors."
	possible_locs = list(BODY_ZONE_CHEST) // The brains are in the chest
	requires_bodypart_type = BODYTYPE_ROBOTIC
	requires_tech = TRUE
	target_mobtypes = list(/mob/living/carbon/human)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fix_robot_brain/trauma,
		/datum/surgery_step/mechanic_close,
	)
	var/resilience_level = TRAUMA_RESILIENCE_LOBOTOMY

/datum/surgery/robot_trauma_surgery/can_start(mob/user, mob/living/carbon/target, obj/item/tool)
	. = ..()
	if(!.)
		return FALSE

	var/obj/item/organ/brain/synth/target_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(target_brain) && !issynthetic(target))
		return FALSE

	if(LAZYLEN(target.get_traumas()))
		for(var/active_trauma in target.get_traumas())
			var/datum/brain_trauma/trauma = active_trauma
			if(trauma.resilience == resilience_level)
				return TRUE

	return FALSE

/datum/surgery_step/fix_robot_brain/trauma
	name = "reticulate splines (multitool/hemostat)"
	repeatable = FALSE
	chems_needed = list(
		/datum/reagent/medicine/liquid_solder,
	)

/datum/surgery_step/fix_robot_brain/trauma/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user,
		target,
		span_notice("You succeed in reticulating [target]'s splines."),
		"[user] successfully fixes [target]'s posibrain!",
		"[user] completes the surgery on [target]'s posibrain.",
	)

	target.setOrganLoss(ORGAN_SLOT_BRAIN, target.get_organ_loss(ORGAN_SLOT_BRAIN) - 60)	//we set damage in this case in order to clear the "failing" flag
	target.cure_all_traumas(TRAUMA_RESILIENCE_BASIC)
	target.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	target.cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)
	var/datum/surgery/robot_trauma_surgery/surgery_type = surgery
	if(surgery_type.resilience_level == TRAUMA_RESILIENCE_MAGIC)
		target.cure_all_traumas(TRAUMA_RESILIENCE_MAGIC)
		playsound(source = get_turf(target), soundin = 'sound/effects/magic/repulse.ogg', vol = 75, vary = TRUE, falloff_distance = 2)
	target.apply_status_effect(/datum/status_effect/vulnerable_to_damage/surgery)
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/brainwashed))
		target.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	return ..()

/datum/surgery/robot_trauma_surgery/blessed
	name = "Devine Debugging (Blessed Neurectomy)"
	desc = "Requires Liquid Solder and Holy Water. A surgical procedure that refurbishes low level components in the posibrain, to fix the strongest, soulbound trauma errors."
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fix_robot_brain/blessed,
		/datum/surgery_step/mechanic_close,
	)
	resilience_level = TRAUMA_RESILIENCE_MAGIC

/datum/surgery_step/fix_robot_brain/blessed
	name = "trigger godmode debugging (multitool/hemostat)"
	repeatable = FALSE
	chems_needed = list(
		/datum/reagent/medicine/liquid_solder,
		/datum/reagent/water/holywater,
	)
