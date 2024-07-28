/datum/keybinding/human/set_intent
	var/set_intent = NONE

/datum/keybinding/human/set_intent/down(client/user)
	. = ..()
	if(.)
		return

	var/mob/living/carbon/human/human = user.mob
	human.set_combat_mode(set_intent, silent = TRUE)
	return TRUE

/datum/keybinding/human/set_intent/help
	name = "set_intent_help"
	full_name = "Set intent to Help"
	hotkey_keys = list("1")
	keybind_signal = COMSIG_KB_HUMAN_SET_INTENT_HELP_DOWN
	set_intent = INTENT_HELP

/datum/keybinding/human/set_intent/disarm
	name = "set_intent_disarm"
	full_name = "Set intent to Disarm"
	hotkey_keys = list("2")
	keybind_signal = COMSIG_KB_HUMAN_SET_INTENT_DISARM_DOWN
	set_intent = INTENT_DISARM

/datum/keybinding/human/set_intent/grab
	name = "set_intent_grab"
	full_name = "Set intent to Grab"
	hotkey_keys = list("3")
	keybind_signal = COMSIG_KB_HUMAN_SET_INTENT_GRAB_DOWN
	set_intent = INTENT_GRAB

/datum/keybinding/human/set_intent/harm
	name = "set_intent_harm"
	full_name = "Set intent to Harm"
	hotkey_keys = list("4")
	keybind_signal = COMSIG_KB_HUMAN_SET_INTENT_HARM_DOWN
	set_intent = INTENT_HARM


/datum/keybinding/living/disable_combat_mode/can_use(client/user)
	return ..() && !ishuman(user.mob)

/datum/keybinding/living/enable_combat_mode/can_use(client/user)
	return ..() && !ishuman(user.mob)
