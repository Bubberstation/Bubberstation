/datum/surgery_operation/limb/subsystem_upgrade
	abstract_type = /datum/surgery_operation/limb/subsystem_upgrade
	implements = list(
		IMPLEMENT_HAND = 1,
	)
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_MORBID | OPERATION_LOCKED | OPERATION_MECHANIC
	required_bodytype = BODYTYPE_SYNTHETIC
	time = 12.5 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED|SURGERY_ORGANS_CUT
	/// What status effect is gained when the surgery is successful?
	/// Used to check against other subsystem_upgrade types to prevent stacking.
	var/datum/status_effect/status_effect_gained = /datum/status_effect/subsystem_upgrade
	/// Zone to operate on for this subsystem_upgrade
	var/required_zone = BODY_ZONE_CHEST

/datum/surgery_operation/limb/subsystem_upgrade/get_default_radial_image()
	return image('icons/hud/implants.dmi', "lighting_bolt")

/datum/surgery_operation/limb/subsystem_upgrade/all_required_strings()
	return list("operate on [parse_zone(required_zone)] (target [parse_zone(required_zone)])") + ..()

/datum/surgery_operation/limb/subsystem_upgrade/all_blocked_strings()
	var/list/incompatible_surgeries = list()
	for(var/datum/surgery_operation/limb/subsystem_upgrade/other_subsystem_upgrade as anything in subtypesof(/datum/surgery_operation/limb/subsystem_upgrade))
		if(other_subsystem_upgrade::status_effect_gained::id != status_effect_gained::id)
			continue
		if(other_subsystem_upgrade::required_bodytype != required_bodytype)
			continue
		incompatible_surgeries += (other_subsystem_upgrade.rnd_name || other_subsystem_upgrade.name)

	return ..() + list("the patient must not have undergone [english_list(incompatible_surgeries, and_text = " OR ")] prior")

/datum/surgery_operation/limb/subsystem_upgrade/state_check(obj/item/bodypart/limb)
	if(limb.body_zone != required_zone)
		return FALSE
	if(limb.owner.has_status_effect(status_effect_gained))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/subsystem_upgrade/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	limb.owner.apply_status_effect(status_effect_gained)
	if(limb.owner.ckey)
		SSblackbox.record_feedback("tally", "subsystem_upgrade", 1, status_effect_gained)

/datum/surgery_operation/limb/subsystem_upgrade/muscled_veins
	name = "muscled veins"
	rnd_name = "Hydraulics Redundancy Subroutine (Muscled Veins)"
	desc = "Add redundancies to a robotic patient's hydraulic system, allowing it to pump fluids without an engine or pump."
	status_effect_gained = /datum/status_effect/subsystem_upgrade/heart/muscled_veins

/datum/surgery_operation/limb/subsystem_upgrade/muscled_veins/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start wrapping muscles around [limb.owner]'s blood vessels."),
		span_notice("[surgeon] starts wrapping muscles around [limb.owner]'s blood vessels."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s blood vessels."),
	)
	display_pain(limb.owner, "Your entire body burns in agony!")

/datum/surgery_operation/limb/subsystem_upgrade/muscled_veins/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("You reshape [limb.owner]'s blood vessels, adding a muscled membrane!"),
		span_notice("[surgeon] reshapes [limb.owner]'s blood vessels, adding a muscled membrane!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s blood vessels."),
	)
	display_pain(limb.owner, "You can feel your heartbeat's powerful pulses ripple through your body!")

/datum/surgery_operation/limb/subsystem_upgrade/nerve_splicing
	name = "splice nerves"
	rnd_name = "Reinforced Servos (Spliced Nerves)"
	desc = "Upgrade a synthetic patient's movement servos, allowing it to better resist stuns."
	time = 15.5 SECONDS
	status_effect_gained = /datum/status_effect/subsystem_upgrade/nerves/spliced

/datum/surgery_operation/limb/subsystem_upgrade/nerve_splicing/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start splicing together [limb.owner]'s nerves."),
		span_notice("[surgeon] starts splicing together [limb.owner]'s nerves."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s nervous system."),
	)
	display_pain(limb.owner, "Your entire body goes numb!")

/datum/surgery_operation/limb/subsystem_upgrade/nerve_splicing/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("You successfully splice [limb.owner]'s nervous system!"),
		span_notice("[surgeon] successfully splices [limb.owner]'s nervous system!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s nervous system."),
	)
	display_pain(limb.owner, "You regain feeling in your body; It feels like everything's happening around you in slow motion!")

/datum/surgery_operation/limb/subsystem_upgrade/nerve_grounding
	name = "ground nerves"
	rnd_name = "Reinforced Capacitors (Grounded Nerves)"
	desc = "Install an additional capacitor bank designed to abdorb electrical shocks."
	time = 15.5 SECONDS
	status_effect_gained = /datum/status_effect/subsystem_upgrade/nerves/grounded

/datum/surgery_operation/limb/subsystem_upgrade/nerve_grounding/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start rerouting [limb.owner]'s nerves."),
		span_notice("[surgeon] starts rerouting [limb.owner]'s nerves."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s nervous system."),
	)
	display_pain(limb.owner, "Your entire body goes numb!")

/datum/surgery_operation/limb/subsystem_upgrade/nerve_grounding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("You successfully reroute [limb.owner]'s nervous system!"),
		span_notice("[surgeon] successfully reroutes [limb.owner]'s nervous system!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s nervous system."),
	)
	display_pain(limb.owner, "You regain feeling in your body! You feel energized!")

/datum/surgery_operation/limb/subsystem_upgrade/ligament_reinforcement
	name = "strengthen ligaments"
	rnd_name = "Anchor Point Reinforcement (Ligament Reinforcement)"
	desc = "Reinforce a robotic patient's limb joints to prevent dismemberment, at the cost of making nerve connections easier to interrupt."
	status_effect_gained = /datum/status_effect/subsystem_upgrade/ligaments/reinforced

/datum/surgery_operation/limb/subsystem_upgrade/ligament_reinforcement/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start reinforcing [limb.owner]'s ligaments."),
		span_notice("[surgeon] starts reinforcing [limb.owner]'s ligaments."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s ligaments."),
	)
	display_pain(limb.owner, "Your limbs burn with severe pain!")

/datum/surgery_operation/limb/subsystem_upgrade/ligament_reinforcement/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("You reinforce [limb.owner]'s ligaments!"),
		span_notice("[surgeon] reinforces [limb.owner]'s ligaments!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s ligaments."),
	)
	display_pain(limb.owner, "Your limbs feel more secure, but also more frail.")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding
	name = "cortex folding"
	rnd_name = "Neuropathing Reinforcement (Cortex Folding)"
	desc = "Reprogram a robotic patient's neural network in a downright eldritch programming language, giving space to non-standard neural patterns."
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_MORBID | OPERATION_LOCKED | OPERATION_NO_PATIENT_REQUIRED
	status_effect_gained = /datum/status_effect/subsystem_upgrade/cortex // Not actually applied, simply for compatibility checks
	required_zone = BODY_ZONE_CHEST

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/state_check(obj/item/bodypart/limb)
	. = ..()
	if (!.)
		return
	var/obj/item/organ/brain/brain = locate() in limb
	if(isnull(brain))
		return FALSE
	return !HAS_TRAIT_FROM(brain, TRAIT_SPECIAL_TRAUMA_BOOST, SUBSYSTEM_UPGRADE_TRAIT)

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	var/obj/item/organ/brain/brain = locate() in limb
	if(!isnull(brain))
		ADD_TRAIT(brain, TRAIT_SPECIAL_TRAUMA_BOOST, SUBSYSTEM_UPGRADE_TRAIT)

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start folding [limb.owner]'s cerebral cortex."),
		span_notice("[surgeon] starts folding [limb.owner]'s cerebral cortex."),
		span_notice("[surgeon] starts performing surgery on [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "Your head throbs with gruesome pain, it's nearly too much to handle!")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("You fold [limb.owner]'s cerebral cortex into a fractal pattern!"),
		span_notice("[surgeon] folds [limb.owner]'s cerebral cortex into a fractal pattern!"),
		span_notice("[surgeon] completes the surgery on [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "Your brain feels stronger... and more flexible!")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_folding/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool)
	var/obj/item/organ/brain/brain = locate() in limb
	if(isnull(brain))
		return ..()
	display_results(
		surgeon,
		limb.owner,
		span_warning("You screw up, damaging the brain!"),
		span_warning("[surgeon] screws up, damaging the brain!"),
		span_notice("[surgeon] completes the surgery on [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "Your head throbs with excruciating pain!")
	brain.apply_organ_damage(60)
	brain.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint
	name = "cortex imprinting"
	rnd_name = "Anti-Cascade 2.0 (Cortex Imprinting)"
	desc = "Update a robotic patient's underlying operating system to a \"newer version\", improving overall performance and resilience. \
		Shame about all the adware."
	status_effect_gained = /datum/status_effect/subsystem_upgrade/cortex/imprinted
	required_zone = BODY_ZONE_CHEST

/datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start carving [limb.owner]'s outer cerebral cortex into a self-imprinting pattern."),
		span_notice("[surgeon] starts carving [limb.owner]'s outer cerebral cortex into a self-imprinting pattern."),
		span_notice("[surgeon] starts performing surgery on [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "Your head throbs with gruesome pain, it's nearly too much to handle!")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("You reshape [limb.owner]'s outer cerebral cortex into a self-imprinting pattern!"),
		span_notice("[surgeon] reshapes [limb.owner]'s outer cerebral cortex into a self-imprinting pattern!"),
		span_notice("[surgeon] completes the surgery on [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "Your brain feels stronger... and more resilient!")

/datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool)
	if(!limb.owner.get_organ_slot(ORGAN_SLOT_BRAIN))
		return ..()
	display_results(
		surgeon,
		limb.owner,
		span_warning("You screw up, damaging the brain!"),
		span_warning("[surgeon] screws up, damaging the brain!"),
		span_notice("[surgeon] completes the surgery on [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "Your brain throbs with intense pain; Thinking hurts!")
	limb.owner.adjust_organ_loss(ORGAN_SLOT_BRAIN, 60)
	limb.owner.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
