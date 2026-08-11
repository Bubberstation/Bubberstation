/datum/surgery_operation/organ/repair/brain/advanced
	name = "trauma surgery"
	rnd_name = "Neurectomy (Advanced Brain Surgery)"
	desc = "An invasive surgical procedure which guarantees removal of deep-rooted brain traumas, but takes a while for the body to recover..."
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_PRIORITY_NEXT_STEP
	time = 15 SECONDS
	var/resilience_level = TRAUMA_RESILIENCE_LOBOTOMY
	var/reagent_1_type = /datum/reagent/medicine/neurine
	var/reagent_1_amount = 3
	var/reagent_2_type
	var/reagent_2_amount

/datum/surgery_operation/organ/repair/brain/advanced/all_required_strings()
	var/datum/reagent/reagent_1 = reagent_1_type
	var/datum/reagent/reagent_2 = reagent_2_type
	if(!isnull(reagent_2_type))
		return ..() + list("the patient must be dosed with >= [reagent_1_amount]u [reagent_1.name]", "the patient must be dosed with >= [reagent_2_amount]u [reagent_2.name]")
	else
		return ..() + list("the patient must be dosed with >= [reagent_1_amount]u [reagent_1.name]")

/datum/surgery_operation/organ/repair/brain/advanced/state_check(obj/item/organ/brain/organ)
	var/mob/living/carbon/human/brain_owner = organ.owner
	if(!istype(brain_owner))
		return FALSE

	if(brain_owner.reagents?.get_reagent_amount(reagent_1_type) < reagent_1_amount)
		return FALSE

	if(reagent_2_type && (brain_owner.reagents?.get_reagent_amount(reagent_2_type) < reagent_2_amount))
		return FALSE

	if(LAZYLEN(brain_owner.get_traumas()))
		for(var/active_trauma in brain_owner.get_traumas())
			var/datum/brain_trauma/trauma = active_trauma
			if(trauma.resilience == TRAUMA_RESILIENCE_WOUND)
				continue
			if(trauma.resilience <= resilience_level)
				return TRUE

	return FALSE

/datum/surgery_operation/organ/repair/brain/advanced/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("You succeed in fixing [FORMAT_ORGAN_OWNER(organ)]'s traumas."),
		span_notice("[surgeon] successfully fixes [FORMAT_ORGAN_OWNER(organ)]'s traumas!"),
		span_notice("[surgeon] completes the surgery on [FORMAT_ORGAN_OWNER(organ)]'s brain."),
	)
	display_pain(organ.owner, "Your mind feels normal again. As normal as it ever was, at least.")
	for(var/i in TRAUMA_RESILIENCE_BASIC to resilience_level)
		if(i == TRAUMA_RESILIENCE_WOUND)
			continue
		organ.cure_all_traumas(i)

	organ.owner.apply_status_effect(/datum/status_effect/vulnerable_to_damage/surgery)

/datum/surgery_operation/organ/repair/brain/advanced/on_failure(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("You screw up, causing more damage!"),
		span_warning("[surgeon] screws up, causing brain damage!"),
		span_notice("[surgeon] completes the surgery on [FORMAT_ORGAN_OWNER(organ)]'s brain."),
	)
	display_pain(organ.owner, "Your head throbs with horrible pain; thinking hurts!")
	if(resilience_level == TRAUMA_RESILIENCE_MAGIC)
		organ.owner.adjust_oxy_loss(200)
	else
		organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_MAGIC)

/datum/surgery_operation/organ/repair/brain/advanced/mechanic
	name = "trigger trauma debugging"
	rnd_name = "Neural Defragmentation (Neurectomy)"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	reagent_1_type = /datum/reagent/medicine/liquid_solder

/datum/surgery_operation/organ/repair/brain/advanced/blessed
	name = "blessed trauma surgery"
	rnd_name = "Blessed Neurectomy (Blessed Advanced Brain Surgery)"
	desc = "We're not quite sure exactly how it works, but with the blessing of a chaplain combined with modern chemicals, this manages to remove soul-bound traumas once thought to be magic."
	success_sound = 'sound/effects/magic/repulse.ogg'
	resilience_level = TRAUMA_RESILIENCE_MAGIC
	reagent_2_type = /datum/reagent/water/holywater
	reagent_2_amount = 1

/datum/surgery_operation/organ/repair/brain/advanced/blessed/mechanic
	name = "trigger godmode trauma debugging"
	rnd_name = "Divine Defragmentation (Blessed Neurectomy)"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	reagent_1_type = /datum/reagent/medicine/liquid_solder
