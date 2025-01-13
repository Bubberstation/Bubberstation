/obj/item/experi_scanner/bluespace
	name = "Bluespace Experi-Scanner"
	desc = "A version of the handheld scanner used for completing the endless experiments of modern science from range."
	icon = 'modular_zubbers/icons/obj/devices/scanner.dmi'
	icon_state = "bs_experiscanner"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/devices_righthand.dmi'

/obj/item/experi_scanner/bluespace/LateInitialize()
	var/static/list/handheld_signals = list(
		COMSIG_ITEM_PRE_ATTACK = TYPE_PROC_REF(/datum/component/experiment_handler, try_run_handheld_experiment),
		COMSIG_ITEM_AFTERATTACK = TYPE_PROC_REF(/datum/component/experiment_handler, ignored_handheld_experiment_attempt),
		COMSIG_RANGED_ITEM_INTERACTING_WITH_ATOM = TYPE_PROC_REF(/datum/component/experiment_handler, bs_ignored_handheld_experiment_attempt),
	)
	AddComponent(/datum/component/experiment_handler, \
		allowed_experiments = list(/datum/experiment/scanning, /datum/experiment/physical), \
		disallowed_traits = EXPERIMENT_TRAIT_DESTRUCTIVE, \
		config_flags = EXPERIMENT_CONFIG_IMMEDIATE_ACTION|EXPERIMENT_CONFIG_WORKS_FROM_RANGE, \
		experiment_signals = handheld_signals, \
	)
