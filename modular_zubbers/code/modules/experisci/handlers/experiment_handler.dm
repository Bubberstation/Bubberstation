/datum/component/experiment_handler/proc/bs_ignored_handheld_experiment_attempt(datum/source, atom/target, mob/user, proximity_flag, params)
	SIGNAL_HANDLER
	if ((selected_experiment == null && !(config_flags & EXPERIMENT_CONFIG_ALWAYS_ACTIVE)) || config_flags & EXPERIMENT_CONFIG_SILENT_FAIL)
		return .
	if (!should_run_handheld_experiment(source, target, user))
		playsound(user, 'sound/machines/buzz-sigh.ogg', 25)
		to_chat(user, span_notice("[target] is not related to your currently selected experiment."))
	try_run_handheld_experiment(source, target, user, params)
	. |= COMPONENT_AFTERATTACK_PROCESSED_ITEM
	return .
