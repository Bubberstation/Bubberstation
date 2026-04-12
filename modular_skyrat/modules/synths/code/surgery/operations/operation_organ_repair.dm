/// Repairing specific Synth Organs

/*
*
*   Hydraulic Pump Surgery - Heart
*
*/

/// Hydraulic Pump Surgery - Heart
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth
	name = "access hydraulic pump internals"
	rnd_name = "Hydraulic Pump Maintenance"
	desc = "A mechanical surgery procedure designed to repair an androids internal hydraulic pump."
	implements = list(
		TOOL_CROWBAR = 0.8,
		TOOL_SCALPEL = 1.5,
		/obj/item/melee/energy/sword = 2,
		/obj/item/knife = 3.25,
		/obj/item/shard = 3.85,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/heart/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("You begin to tighten the clamps around [FORMAT_ORGAN_OWNER(organ)]'s hydraulic pump..."),
		span_notice("[surgeon] begins to repair [FORMAT_ORGAN_OWNER(organ)]'s hydraulic pump with [tool]!"),
		span_notice("[surgeon] begins to repair [FORMAT_ORGAN_OWNER(organ)]'s hydraulic pump!"),
	)
	display_pain(organ.owner, "The pain in your chest is unbearable! You can barely take it anymore!")

// flavor text - success
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("You successfully graft a bypass channel onto [FORMAT_ORGAN_OWNER(organ)]'s hydraulic pump"),
		span_notice("[surgeon] finishes clamping tubing down around [FORMAT_ORGAN_OWNER(organ)]'s hydraulic pump with [tool]."),
		span_notice("[surgeon] finishes clamping tubing down around [FORMAT_ORGAN_OWNER(organ)]'s hydraulic pump"),
	)
	display_pain(organ.owner, "The pain in your chest throbs, but your heart feels better than ever!")

// flavor text - on_failure
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/blood_name = LOWER_TEXT(organ.owner?.get_bloodtype()?.get_blood_name()) || "blood"
	display_results(
		surgeon,
		organ.owner,
		span_warning("You screw up and slip your [tool] into their pump, tearing tubing off the pump!"),
		span_warning("[surgeon] screws up, causing high pressure [blood_name] to spurt out of [FORMAT_ORGAN_OWNER(organ)]'s chest profusely!"),
		span_warning("[surgeon] completes the surgery, but is that [blood_name] supposed to be squirting out of [FORMAT_ORGAN_OWNER(organ)]'s chest like that?"),
	)
	display_pain(organ.owner, "Your chest burns; you feel like you're going insane!")

/*
*
*   Reagent Processor Surgery - Liver
*
*/

/// Reagent Processor Repair surgery start
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth
	name = "perform reagent processor maintenance"
	rnd_name = "Reagent Processor Maintenance (Reagent Processor Repair)"
	desc = "A mechanical surgery procedure designed to repair an android's reagent processor."
	implements = list(
		TOOL_WRENCH = 0.8,
		TOOL_SCALPEL = 1.5,
		/obj/item/melee/energy/sword = 2,
		/obj/item/knife = 3.25,
		/obj/item/shard = 3.85,
	)
	preop_sound = 'sound/items/tools/screwdriver_operating.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/liver/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("You start to descale minerals built up in [FORMAT_ORGAN_OWNER(organ)]'s reagent processor..."),
		span_notice("[surgeon] begins to make an incision in [FORMAT_ORGAN_OWNER(organ)]'s reagent processor with [tool]."),
		span_notice("[surgeon] begins to make an incision in [FORMAT_ORGAN_OWNER(organ)]'s reagent processor."),
	)
	display_pain(organ.owner, "Your systems disconnect from your reagent processor, avoiding unnecessary errors.")

// flavor text - success
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("You successfully descale [FORMAT_ORGAN_OWNER(organ)]'s reagent processor, restoring factory settings and removing built up minerals."),
		span_notice("[surgeon] successfully descales [FORMAT_ORGAN_OWNER(organ)]'s reagent processor, restoring factory settings and removing built up minerals."),
		span_notice("[surgeon] successfully resets [FORMAT_ORGAN_OWNER(organ)]'s reagent processor."),
	)
	display_pain(organ.owner, "Flow rate restored.")

// flavor text - failure
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("You cut the wrong part of [FORMAT_ORGAN_OWNER(organ)]'s reagent processor out of spec!"),
		span_warning("[surgeon] follows the wrong diagram for [FORMAT_ORGAN_OWNER(organ)]'s reagent processor!"),
		span_warning("[surgeon] finishes adjusting [FORMAT_ORGAN_OWNER(organ)]'s reagent processor... wait that isn't right..."),
	)
	display_pain(organ.owner, "You see errors flow across your vision!")

/*
*
*   Heatsink Repair Surgery - Lung
*
*/

/// Heatsink Repair Surgery start
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth
	name = "heatsink maintenance"
	rnd_name = "Heatsink Diagnostic (Heatsink Repair)"
	desc = "A mechanical surgery procedure designed to repair an android's internal heatsink."
	implements = list(
		TOOL_WRENCH = 1.05,
		TOOL_RETRACTOR = 1.5,
	)
	preop_sound = 'sound/items/tools/ratchet_fast.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/lungs/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("You begin to tighten the bolts on [FORMAT_ORGAN_OWNER(organ)]'s heatsink..."),
		span_notice("[surgeon] begins to tighten the bolts on [FORMAT_ORGAN_OWNER(organ)]'s heatsink using [tool]."),
		span_notice("[surgeon] begins to tighten the bolts on [FORMAT_ORGAN_OWNER(organ)]'s heatsink."),
	)
	display_pain(organ.owner, "You feel a metal clank inside your chest as [surgeon] starts to work.")

// flavor text - success
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("You successfully tighten [FORMAT_ORGAN_OWNER(organ)]'s bolts on their heatsink."),
		span_notice("[surgeon] successfully tightened [FORMAT_ORGAN_OWNER(organ)]'s heatsink using [tool]."),
		span_notice("[surgeon] finishes tightening [FORMAT_ORGAN_OWNER(organ)]'s heatsink."),
	)
	display_pain(organ.owner, "Your internal errors clear for your temperature regulation.")

// flavor text - failure
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("You slip and barely catch the [tool] before it falls, failing to tighten [FORMAT_ORGAN_OWNER(organ)]'s heatsink down!"),
		span_warning("[surgeon] 's butterfingers barely catches the [tool] before it falls into [FORMAT_ORGAN_OWNER(organ)]'s chest!"),
		span_warning("[surgeon] screws up, nearly dropping the [tool] into [FORMAT_ORGAN_OWNER(organ)]'s chest!"),
	)
	display_pain(organ.owner, "You feel a dull thud in your chest; it feels like a [tool] fell into your chest cavity!")

/*
*
*   Fuel Cell Maintenance - Stomach
*
*/

/// Fuel Cell Maintenance - Start
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth
	name = "fuel cell maintenance"
	rnd_name = "Fuel Cell Diagnostic (Fuel Cell Repair)"
	desc = "A mechanical surgery procedure designed to repair an android's internal fuel cell."
	implements = list(
		TOOL_SCREWDRIVER = 1.05,
		TOOL_SCALPEL = 1.5,
		/obj/item/melee/energy/sword = 2,
		/obj/item/knife = 3.25,
		/obj/item/shard = 3.85,
		/obj/item = 6,
	)
	preop_sound = 'sound/effects/bodyfall/bodyfall1.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/stomach/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("You begin to patch the damaged section of [FORMAT_ORGAN_OWNER(organ)]'s fuel cell..."),
		span_notice("[surgeon] begins to delicately repair [FORMAT_ORGAN_OWNER(organ)]'s fuel cell using [tool]."),
		span_notice("[surgeon] begins to delicately repair[FORMAT_ORGAN_OWNER(organ)]'s fuel cell."),
	)
	display_pain(organ.owner, "You feel a horrible stab in your gut!")

// flavor text - success
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("You successfully remove the damaged part of [FORMAT_ORGAN_OWNER(organ)]'s fuel cell."),
		span_notice("[surgeon] successfully repairs the damaged part of [FORMAT_ORGAN_OWNER(organ)]'s fuel cell using [tool]."),
		span_notice("[surgeon] successfully repairs the damaged part of [FORMAT_ORGAN_OWNER(organ)]'s fuel cell."),
	)
	display_pain(organ.owner, "The errors clear from your fuel cell.")

// flavor text - failure
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("You slip and puncture [FORMAT_ORGAN_OWNER(organ)]'s fuel cell!"),
		span_warning("[surgeon] slips and punctures [FORMAT_ORGAN_OWNER(organ)]'s fuel cell with the [tool]!"),
		span_warning("[surgeon] slips and punctures [FORMAT_ORGAN_OWNER(organ)]'s fuel cell!"),
	)
	display_pain(organ.owner, "Your midsection throws additional errors; that's not right!")

/*
*
*   Reset Logic Core - Brain
*
*/

/// Reset Logic Core - Start
/datum/surgery_operation/organ/repair/brain/mechanic/synth
	name = "perform neural debugging"
	rnd_name = "Reset Logic Core (Posi Repair)"
	desc = "A surgical procedure that restores the default behavior logic and personality matrix of an synthetic humanoid's neural network."
	implements = list(
		TOOL_MULTITOOL = 1.05,
		TOOL_SCREWDRIVER = 4.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	time = 12 SECONDS //long and complicated
	target_type = /obj/item/organ/brain/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/brain/mechanic/synth/on_preop(obj/item/organ/brain/synth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = organ.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	brain_type = synth_brain.name
	display_results(
		surgeon,
		organ.owner,
		span_notice("You begin to clear system corruption from [FORMAT_ORGAN_OWNER(organ)]'s [brain_type]..."),
		span_notice("[surgeon] begins to fix [FORMAT_ORGAN_OWNER(organ)]'s [brain_type]"),
		span_notice("[surgeon] begins to perform surgery on [FORMAT_ORGAN_OWNER(organ)]'s [brain_type]."),
	)
	display_pain(organ.owner, "You start to have fragmented thoughts!")

// flavor text - success
/datum/surgery_operation/organ/repair/brain/mechanic/synth/on_success(obj/item/organ/brain/synth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	organ.apply_organ_damage(-organ.maxHealth * heal_to_percent) // no parent call, special healing for this one
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = organ.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(synth_brain)
		brain_type = synth_brain.name
	display_results(
		surgeon,
		organ.owner,
		span_notice("You succeed in clearing system corruption from [FORMAT_ORGAN_OWNER(organ)]'s [brain_type]."),
		span_notice("[surgeon] successfully fixes [FORMAT_ORGAN_OWNER(organ)]'s [brain_type]."),
		span_notice("[surgeon] completes the surgery on [FORMAT_ORGAN_OWNER(organ)]'s [brain_type]."),
	)
	display_pain(organ.owner, "The fragmentation errors start clearing.")
	if (organ.owner)
		organ.owner.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	else if (organ.brainmob)
		organ.brainmob.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	organ.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	if(organ.damage > organ.maxHealth * 0.1)
		to_chat(surgeon, "[FORMAT_ORGAN_OWNER(organ)]'s [brain_type] still has some lasting system damage that can be cleared.")

// flavor text - failure
/datum/surgery_operation/organ/repair/brain/mechanic/synth/on_failure(obj/item/organ/brain/synth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = organ.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(synth_brain)
		brain_type = synth_brain.name
	display_results(
		surgeon,
		organ.owner,
		span_warning("You screw up, fragmenting their data!"),
		span_warning("[surgeon] screws up, causing damage to the circuits!"),
		span_notice("[surgeon] completes the surgery on [FORMAT_ORGAN_OWNER(organ)]'s [brain_type]. Or so they thought."),
	)
	display_pain(organ.owner, "Your vision floods with errors; something is wrong!")
	organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/*
*
*   Repair auditory microphones - Ear
*
*/

/// Repair Auditory Microphones - Start
/datum/surgery_operation/organ/repair/ears/synth
	name = "ear repair"
	rnd_name = "Repair Auditory Microphones (Hearing Repair)" // source: i made it up
	desc = "Repair a patient's damaged ears to restore hearing."
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_SCREWDRIVER = 4.85,
		/obj/item/pen = 6.67,
	)
	target_type = /obj/item/organ/ears/synth
	time = 6.4 SECONDS
	heal_to_percent = 0
	repeatable = TRUE
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 1

/datum/surgery_operation/organ/repair/ears/synth/all_blocked_strings()
	return ..() + list("if the limb has bones, they must be intact")

/datum/surgery_operation/organ/repair/ears/synth/state_check(obj/item/organ/ears/organ)
	// If bones are sawed, prevent the operation (unless we're operating on a limb with no bones)
	if(LIMB_HAS_ANY_SURGERY_STATE(organ.bodypart_owner, SURGERY_BONE_SAWED|SURGERY_BONE_DRILLED) && LIMB_HAS_BONES(organ.bodypart_owner))
		return FALSE
	return TRUE // always available so you can intentionally fail it

/datum/surgery_operation/organ/repair/ears/synth/on_preop(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("You begin to repair [FORMAT_ORGAN_OWNER(organ)]'s microphones..."),
		span_notice("[surgeon] begins to fix [FORMAT_ORGAN_OWNER(organ)]'s microphones."),
		span_notice("[surgeon] begins to perform maintenance on [FORMAT_ORGAN_OWNER(organ)]'s microphones."),
	)
	display_pain(organ.owner, "Your auditory input starts to crackle loudly!")

/datum/surgery_operation/organ/repair/ears/synth/on_success(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/deaf_change = 40 SECONDS - organ.temporary_deafness
	organ.adjust_temporary_deafness(deaf_change)
	display_results(
		surgeon,
		organ.owner,
		span_notice("You successfully repair [FORMAT_ORGAN_OWNER(organ)]'s microphones."),
		span_notice("[surgeon] successfully repair [FORMAT_ORGAN_OWNER(organ)]'s microphones."),
		span_notice("[surgeon] successfully repair [FORMAT_ORGAN_OWNER(organ)]'s microphones."),
	)
	display_pain(organ.owner, "Your sensors call out in protest, but it seems like your microphones are coming back online!")

/datum/surgery_operation/organ/repair/ears/synth/on_failure(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/obj/item/organ/brain/brain = locate() in organ.bodypart_owner
	if(isnull(brain))
		display_results(
			surgeon,
			organ.owner,
			span_warning("You accidentally stab [FORMAT_ORGAN_OWNER(organ)] right in the posibrain! Or would have, if [FORMAT_ORGAN_OWNER(organ)] had a posibrain."),
			span_warning("[surgeon] accidentally stabs [FORMAT_ORGAN_OWNER(organ)] right in the posibrain! Or would have, if [FORMAT_ORGAN_OWNER(organ)] had a posibrain."),
			span_warning("[surgeon] accidentally stabs [FORMAT_ORGAN_OWNER(organ)] right in the posibrain!"),
		)
		return

	display_results(
		surgeon,
		organ.owner,
		span_warning("You accidentally stab [FORMAT_ORGAN_OWNER(organ)] right in the posibrain!"),
		span_warning("[surgeon] accidentally stabs [FORMAT_ORGAN_OWNER(organ)] right in the posibrain!"),
		span_warning("[surgeon] accidentally stabs [FORMAT_ORGAN_OWNER(organ)] right in the posibrain!"),
	)
	display_pain(organ.owner, "You sudden are jolted by something shorting your insides!")
