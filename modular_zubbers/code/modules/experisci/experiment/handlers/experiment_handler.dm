/datum/component/experiment_handler/proc/bs_ignored_handheld_experiment_attempt(datum/source, atom/target, mob/user, proximity_flag, params)
	SIGNAL_HANDLER
	if ((isnull(selected_experiment) && !(config_flags & EXPERIMENT_CONFIG_ALWAYS_ACTIVE)) || config_flags & EXPERIMENT_CONFIG_SILENT_FAIL)
		return .
	bs_try_run_handheld_experiment(source, target, user, params)
	. |= COMPONENT_AFTERATTACK_PROCESSED_ITEM
	return .

/datum/component/experiment_handler/proc/bs_try_run_handheld_experiment(datum/source, atom/target, mob/user, params)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(try_run_handheld_experiment_async), source, target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN
