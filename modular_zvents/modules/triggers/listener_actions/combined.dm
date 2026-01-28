/datum/listener_type/combined
	var/list/signals = list()
	var/list/fired_signals = list()

	var/main_trigger
	var/repeat = FALSE

	var/datum/listener_type/real_action
	var/failed_message = "Not ready yet!"
	var/addiction_args_for_other = null

/datum/listener_type/combined/New(atom/_parent)
	..()
	fired_signals = list()

/datum/listener_type/combined/Destroy()
	for(var/key in signals)
		SStriggers.unregister_listener(key, src)
	if(main_trigger)
		SStriggers.unregister_listener(main_trigger, src)
	QDEL_NULL(real_action)
	signals.Cut()
	fired_signals.Cut()
	return ..()

/datum/listener_type/combined/proc/all_recived()
	if(repeat)
		return (length(fired_signals) >= length(signals))
	else
		return (length(fired_signals) == length(signals))

/datum/listener_type/combined/check_ready(mob/user, key)
	if(main_trigger && key != main_trigger)
		return TRUE

	if(main_trigger && !(all_recived()))
		if(user && failed_message)
			to_chat(user, span_warning(failed_message))
		return FALSE
	return TRUE

/datum/listener_type/combined/apply_action(datum/trigger_type/trigger, list/extra_args, key)
	if((key in signals) && (key != main_trigger))
		fired_signals += key

	if(!all_recived())
		return

	if(main_trigger && key != main_trigger)
		return

	real_action.apply_action(trigger, addiction_args_for_other, key)
	if(repeat)
		fired_signals.Cut()
	else
		fired_signals += key

/datum/listener_type/combined/parse_extra_args(listener_type, list/list_of_signals, main_signal = null, failed_message = "Not ready yet!", repeat = FALSE, extra_params)
	if(!listener_type || !length(list_of_signals))
		stack_trace("Combined listener: no action type or signals")
		return FALSE

	src.failed_message = failed_message
	src.repeat = repeat
	main_trigger = main_signal

	for(var/sig in list_of_signals)
		signals += sig
		SStriggers.register_listener(sig, src)

	if(main_trigger && !(main_trigger in signals))
		SStriggers.register_listener(main_trigger, src)

	real_action = new listener_type(parent)
	addiction_args_for_other = extra_params



/datum/listener_type/broadcast
	var/list/broadcast_keys = list()

/datum/listener_type/broadcast/Destroy()
	broadcast_keys.Cut()
	return ..()

/datum/listener_type/broadcast/parse_extra_args(list/keys_to_broadcast)
	if(!islist(keys_to_broadcast) || !length(keys_to_broadcast))
		stack_trace("broadcast listener: no keys to broadcast")
		return FALSE

	broadcast_keys = keys_to_broadcast.Copy()
	return TRUE

/datum/listener_type/broadcast/apply_action(datum/trigger_type/trigger, list/extra_args, key)
	var/list/to_broadcast = list()

	if(length(extra_args) && islist(extra_args))
		to_broadcast = extra_args
	else if(length(broadcast_keys))
		to_broadcast = broadcast_keys.Copy()
	else
		to_broadcast += key

	for(var/bkey in to_broadcast)
		if(!bkey)
			continue
		SStriggers.activate_trigger(bkey, trigger, args)


/obj/effect/mapping_helpers/listener_helper/combined
	name = "Combined Listener Helper"
	listener_type = /datum/listener_type/combined

	var/list/EDITOR_signals = list("button1", "button2")
	var/EDITOR_main_signal = null
	var/EDITOR_fail_message = "Not ready yet!"
	var/EDITOR_repeat = FALSE

	var/EDITOR_action_type = /datum/listener_type/open_door
	var/EDITOR_extra_params = null

/obj/effect/mapping_helpers/listener_helper/combined/Initialize(mapload)
	extra_params = list(
		"list_of_signals" = EDITOR_signals.Copy(),
		"main_signal" = EDITOR_main_signal,
		"failed_message" = EDITOR_fail_message,
		"repeat" = EDITOR_repeat,
		"extra_params" = EDITOR_extra_params
	)

	extra_params["listener_type"] = EDITOR_action_type
	return ..()

/obj/effect/mapping_helpers/listener_helper/broadcast
	name = "Broadcast Listener Helper"
	listener_type = /datum/listener_type/broadcast

	var/list/EDITOR_broadcast_keys = list("")

/obj/effect/mapping_helpers/listener_helper/broadcast/Initialize(mapload)
	if(length(EDITOR_broadcast_keys))
		extra_params = list(
			"keys_to_broadcast" = EDITOR_broadcast_keys.Copy()
		)
	return ..()


/obj/effect/mapping_helpers/listener_helper/combined_broadcast
	name = "Combined → Broadcast Helper"
	listener_type = /datum/listener_type/combined

	var/list/EDITOR_signals = list("lever_a", "lever_b")
	var/EDITOR_main_signal = "master_lever"
	var/EDITOR_fail_message = "The mechanism is not ready..."
	var/EDITOR_repeat = FALSE

	var/list/EDITOR_broadcast_keys = list("vault_open", "disable_traps", "play_success")

/obj/effect/mapping_helpers/listener_helper/combined_broadcast/Initialize(mapload)
	extra_params = list(
		"listener_type" = /datum/listener_type/broadcast,
		"list_of_signals" = EDITOR_signals.Copy(),
		"main_signal" = EDITOR_main_signal,
		"failed_message" = EDITOR_fail_message,
		"repeat" = EDITOR_repeat,
		"extra_params" = EDITOR_broadcast_keys,
	)
	return ..()
