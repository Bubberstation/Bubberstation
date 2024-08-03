/datum/component/experiment_handler/proc/bs_ignored_handheld_experiment_attempt(datum/source, mob/user, atom/target, proximity_flag, params)
	SIGNAL_HANDLER
	if ((isnull(selected_experiment) && !(config_flags & EXPERIMENT_CONFIG_ALWAYS_ACTIVE)) || config_flags & EXPERIMENT_CONFIG_SILENT_FAIL)
		return
	bs_try_run_handheld_experiment(source, user, target, params)

/datum/component/experiment_handler/proc/bs_try_run_handheld_experiment(datum/source, mob/user, atom/target, params)
	INVOKE_ASYNC(src, PROC_REF(try_run_handheld_experiment_async), source, target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN
