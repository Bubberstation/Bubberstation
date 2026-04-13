GLOBAL_VAR_INIT(processors_cursed, FALSE)

/datum/heretic_knowledge/telecomms_corruption
	name = "The Owl's Secrets"
	desc = "Allows you to combine a radio, ears, and a bluespace crystal to cast a curse on the station's telecommunication processors. \
	This curse will drain sanity on anyone wearing a radio and garble messages for five minutes. Has a twenty minute cooldown after cast."
	gain_text = "The Owl is a great listener. But a whisper of the knowledge it has gained is enough to send a man to an asylum."
	required_atoms = list(
		/obj/item/radio,
		/obj/item/organ/ears,
		/obj/item/stack/ore/bluespace_crystal
	)
	cost = 2
	research_tree_icon_path = 'icons/obj/machines/telecomms.dmi'
	research_tree_icon_state = "blackbox_b"
	drafting_tier = 1
	STATIC_COOLDOWN_DECLARE(heretic_corruption)

/datum/heretic_knowledge/telecomms_corruption/can_be_invoked(datum/antagonist/heretic/invoker)
	. = ..()
	if (!.)
		return FALSE

	if (!COOLDOWN_FINISHED(src, heretic_corruption))
		return FALSE

	return TRUE

/datum/heretic_knowledge/telecomms_corruption/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()

	GLOB.processors_cursed = TRUE
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(relieve_processor_curse)), 5 MINUTES)

	for (var/obj/machinery/telecomms/message_server/iter_server in GLOB.telecomm_machines)
		if (iter_server.z != user.z)
			continue
		iter_server.emp_act(EMP_HEAVY)

	for (var/obj/machinery/telecomms/processor/iter_processor in GLOB.telecomm_machines)
		iter_processor.update_appearance(UPDATE_OVERLAYS)

	COOLDOWN_START(src, heretic_corruption, 20 MINUTES)

/proc/relieve_processor_curse()
	GLOB.processors_cursed = FALSE

	for (var/obj/machinery/telecomms/processor/iter_processor in GLOB.telecomm_machines)
		iter_processor.update_appearance(UPDATE_OVERLAYS)

