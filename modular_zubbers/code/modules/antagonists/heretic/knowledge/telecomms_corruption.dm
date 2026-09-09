GLOBAL_VAR_INIT(processors_cursed, FALSE)

/datum/heretic_knowledge/telecomms_corruption
	name = "The Owl's Secrets"
	desc = "Allows you to combine a radio, ears, and a bluespace crystal to cast a curse on the station's telecommunication processors. \
	This curse will drain sanity on anyone wearing a radio and garble messages for five minutes. Can only be used twice."
	gain_text = "The Owl is a great listener. But a whisper of the knowledge it has gained is enough to send a man to an asylum."
	required_atoms = list(
		/obj/item/radio = 1,
		/obj/item/organ/ears = 1,
		/obj/item/stack/ore/bluespace_crystal = 1
	)
	research_tree_icon_path = 'icons/obj/machines/telecomms.dmi'
	research_tree_icon_state = "blackbox_b"
	drafting_tier = 1
	var/uses_left = 2

/datum/heretic_knowledge/telecomms_corruption/can_be_invoked(datum/antagonist/heretic/invoker)
	. = ..()
	if (!.)
		return FALSE

	if (GLOB.processors_cursed)
		return FALSE

	return TRUE

/datum/heretic_knowledge/telecomms_corruption/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if (!.)
		return FALSE

	if (uses_left <= 0)
		user.balloon_alert(user, "out of uses!")
		return FALSE

/datum/heretic_knowledge/telecomms_corruption/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()

	GLOB.processors_cursed = TRUE
	uses_left--
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(relieve_processor_curse)), 5 MINUTES)

	for (var/obj/machinery/telecomms/message_server/iter_server in GLOB.telecomm_machines)
		if (iter_server.z != user.z)
			continue
		iter_server.emp_act(EMP_HEAVY)

	for (var/obj/machinery/telecomms/processor/iter_processor in GLOB.telecomm_machines)
		iter_processor.update_appearance(UPDATE_OVERLAYS)

	return TRUE

/proc/relieve_processor_curse()
	GLOB.processors_cursed = FALSE

	for (var/obj/machinery/telecomms/processor/iter_processor in GLOB.telecomm_machines)
		iter_processor.update_appearance(UPDATE_OVERLAYS)

