// A surgery that repairs the patient's NIF
/datum/surgery_operation/organ/repair_nif
	name = "Repair NIF"
	desc = "A surgical procedure that restores the integrity of an installed NIF."
	implements = list(
		TOOL_MULTITOOL = 1,
		TOOL_HEMOSTAT = 2.85,
		TOOL_SCREWDRIVER = 6.67,
	)
	target_type = /obj/item/organ/cyberimp/brain/nif
	time = 12 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN | SURGERY_BONE_SAWED | SURGERY_ORGANS_CUT
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/repair_nif/on_preop(obj/item/organ/cyberimp/brain/nif/installed_nif, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		installed_nif.owner,
		span_notice("You begin to restore the integrity of [FORMAT_ORGAN_OWNER(installed_nif)]'s NIF..."),
		span_notice("[surgeon] begins to fix [FORMAT_ORGAN_OWNER(installed_nif)]'s NIF."),
		span_notice("[surgeon] begins to perform repairs on [FORMAT_ORGAN_OWNER(installed_nif)]'s NIF."),
	)

/datum/surgery_operation/organ/repair_nif/on_success(obj/item/organ/cyberimp/brain/nif/installed_nif, mob/living/surgeon, tool, list/operation_args)
	display_results(
		surgeon,
		installed_nif.owner,
		span_notice("You succeed in restoring the integrity of [FORMAT_ORGAN_OWNER(installed_nif)]'s NIF."),
		span_notice("[surgeon] successfully repairs [FORMAT_ORGAN_OWNER(installed_nif)]'s NIF!"),
		span_notice("[surgeon] completes the repair on [FORMAT_ORGAN_OWNER(installed_nif)]'s NIF."),
	)
	installed_nif.durability = installed_nif.max_durability
	installed_nif.send_message("Restored to full integrity!")

	return ..()

/datum/surgery_operation/organ/repair_nif/on_failure(obj/item/organ/cyberimp/brain/nif/installed_nif, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		installed_nif.owner,
		span_warning("You screw up, causing [FORMAT_ORGAN_OWNER(installed_nif)] brain damage!"),
		span_warning("[surgeon] screws up, while trying to repair [FORMAT_ORGAN_OWNER(installed_nif)]'s NIF!"),
		span_notice("[surgeon] completes the repair on [FORMAT_ORGAN_OWNER(installed_nif)]'s NIF."),
	)
	installed_nif.owner.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20)
	return FALSE

