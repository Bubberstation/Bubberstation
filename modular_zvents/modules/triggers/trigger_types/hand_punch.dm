/datum/trigger_type/hand_punch
	var/use_time = 0
	var/balloon_text = "activated!"
	var/require_right_click = FALSE

/datum/trigger_type/hand_punch/parse_extra_args(use_time, balloon, right_click)
	src.use_time = use_time
	src.balloon_text = balloon
	src.require_right_click = right_click

/datum/trigger_type/hand_punch/subscribe_to_parent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	if(require_right_click)
		RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND_SECONDARY, PROC_REF(on_attack_hand))

/datum/trigger_type/hand_punch/unsubscribe_from_parent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_ATTACK_HAND_SECONDARY))

/datum/trigger_type/hand_punch/proc/on_attack_hand(datum/source, mob/living/user, list/modifiers)
	SIGNAL_HANDLER

	if(!istype(user) || user.stat)
		return

	if(require_right_click && !LAZYACCESS(modifiers, RIGHT_CLICK))
		return

	if(use_time > 0)
		INVOKE_ASYNC(src, PROC_REF(do_hand_act), user)
	else
		do_activate(user)


/datum/trigger_type/hand_punch/proc/do_hand_act(mob/living/user)
	if(!do_after(user, use_time, parent))
		parent.balloon_alert_to_viewers("Interrupted!")
		return
	do_activate(user)

/datum/trigger_type/hand_punch/proc/do_activate(mob/living/user)
	parent.balloon_alert_to_viewers(balloon_text)
	activate_immediate(list(user))


/datum/trigger_type/hand_punch/right_click
	require_right_click = TRUE
	balloon_text = "activated (right click)"



/datum/trigger_type/hand_punch/password
	var/required_code = "000000"
	var/wrong_message = "Invalid password!"

/datum/trigger_type/hand_punch/password/parse_extra_args(r_code, message)
	required_code = r_code
	wrong_message = message

/datum/trigger_type/hand_punch/password/do_activate(mob/living/user)
	var/input = tgui_input_text(user, "Enter password:", "Password Required", default = "", timeout = 30 SECONDS)
	if(QDELETED(src) || QDELETED(user) || !input)
		return

	if(input != required_code)
		parent.balloon_alert_to_viewers(wrong_message)
		return

	parent.balloon_alert_to_viewers("Access granted!")
	INVOKE_ASYNC(src, PROC_REF(finish_activate), user)

/datum/trigger_type/hand_punch/password/proc/finish_activate(mob/living/user)
	if(QDELETED(src))
		return
	activate_immediate(list(user))


/obj/effect/mapping_helpers/trigger_helper/hand_punch
	name = "Trigger Helper - Hand Punch"
	icon_state = "trigger_hand"
	trigger_type = /datum/trigger_type/hand_punch
	var/EDITOR_use_time = 0
	var/EDITOR_balloon = null
	var/EDITOR_right_click = FALSE

/obj/effect/mapping_helpers/trigger_helper/hand_punch/Initialize(mapload)
	if(!length(extra_params))
		extra_params = list()
	if(EDITOR_use_time > 0)
		extra_params["use_time"] = EDITOR_use_time
	if(EDITOR_balloon)
		extra_params["balloon"] = EDITOR_balloon
	if(EDITOR_right_click)
		extra_params["right_click"] = TRUE

	return ..()

/obj/effect/mapping_helpers/trigger_helper/hand_punch/right_click
	name = "Trigger Helper - Hand Punch (Right Click)"
	icon_state = "trigger_hand_right"
	trigger_type = /datum/trigger_type/hand_punch/right_click

	EDITOR_right_click = TRUE

/obj/effect/mapping_helpers/trigger_helper/hand_punch/password
	name = "Trigger Helper - Hand Punch (Password)"
	icon_state = "trigger_password"
	trigger_type = /datum/trigger_type/hand_punch/password

	var/EDITOR_r_code = "00000"
	var/EDITOR_wrong_message = "Invalid password!"

/obj/effect/mapping_helpers/trigger_helper/hand_punch/password/Initialize(mapload)
	extra_params = list(
		"r_code" = EDITOR_r_code,
		"message"  = EDITOR_wrong_message,
	)
	return ..()
