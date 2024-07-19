/datum/keybinding/human/set_intent_help
	name = "set_intent_help"
	full_name = "Set intent to Help"
	hotkey_keys = list("1")

/datum/keybinding/human/set_intent_disarm
	name = "set_intent_help"
	full_name = "Set intent to Disarm"
	hotkey_keys = list("2")

/datum/keybinding/human/set_intent_grab
	name = "set_intent_help"
	full_name = "Set intent to Grab"
	hotkey_keys = list("3")

/datum/keybinding/human/set_intent_harm
	name = "set_intent_help"
	full_name = "Set intent to Harm"
	hotkey_keys = list("4")


/datum/keybinding/living/disable_combat_mode/can_use(client/user)
	return ..() && !ishuman(user.mob)

/datum/keybinding/living/enable_combat_mode/can_use(client/user)
	return ..() && !ishuman(user.mob)
