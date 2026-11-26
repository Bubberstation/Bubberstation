/datum/discipline/auspex
	name = "Auspex"
	discipline_explanation = "Auspex is a Discipline that grants vampires supernatural senses, letting them peer far further and see things best left unseen.\n\
		The malkavians especially have a bond with it, being seers at heart."
	icon_state = "auspex"

	// Lists of abilities granted per level
	level_1 = list(/datum/action/cooldown/vampire/auspex)
	level_2 = list(/datum/action/cooldown/vampire/auspex/two)
	level_3 = list(/datum/action/cooldown/vampire/auspex/three)
	level_4 = list(/datum/action/cooldown/vampire/auspex/four)
	vassal_power = /datum/action/cooldown/vampire/auspex

/datum/discipline/auspex/malkavian
	level_5 = list(/datum/action/cooldown/vampire/auspex/four, /datum/action/cooldown/vampire/astral_projection)

/**
 *	# Auspex
 *
 *	Level 1 - Raise sightrange by 2, project sight 2 tiles ahead.
 *	Level 2 - Raise sightrange by 3, project sight 4 tiles ahead. Meson Vision
 *	Level 3 - Raise sightrange by 5, project sight 6 tiles ahead.
 *	Level 4 - Raise sightrange by 7, project sight 8 tiles ahead. Xray Vision
 *	Level 5 - For Malkavians: Gain ability to astral project like a wizard.
 */
/datum/action/cooldown/vampire/auspex
	name = "Auspex"
	desc = "Sense the vitae of any creature directly, and use your keen senses to widen your perception."
	button_icon_state = "power_auspex"
	power_explanation = "- Level 1: When Activated, you will see further. \n\
					- Level 2: When Activated, you will see further, be able to sense walls and the layout of rooms, and, upon examining a fellow Kindred, be able to tell if they have committed Diablerie. \n\
					- Level 3: When Activated, You still have meson vision, same as level 2, but even more range. \n\
					- Level 4: When Activated, you will see further, and be able to sense anything in sight, seeing through walls and barriers as if they were glass."
	vampire_power_flags = BP_AM_TOGGLE | BP_AM_STATIC_COOLDOWN
	vitaecost = 50
	constant_vitaecost = 1
	cooldown_time = 10 SECONDS
	var/add_meson = FALSE
	var/add_xray = FALSE
	var/zoom_out_amt = 2
	var/zoom_amt = 6
	var/see_diablerie = FALSE


	var/looking = FALSE
	var/mob/listening_to

/datum/action/cooldown/vampire/auspex/two
	name = "Auspex"
	vitaecost = 40
	constant_vitaecost = 2
	zoom_out_amt = 4
	zoom_amt = 7
	add_meson = TRUE
	see_diablerie = TRUE

/datum/action/cooldown/vampire/auspex/three
	name = "Auspex"
	vitaecost = 30
	constant_vitaecost = 3
	zoom_out_amt = 6
	zoom_amt = 8
	add_meson = TRUE
	see_diablerie = TRUE

/datum/action/cooldown/vampire/auspex/four
	name = "Auspex"
	vitaecost = 20
	constant_vitaecost = 4
	zoom_out_amt = 10
	zoom_amt = 10
	add_xray = TRUE
	see_diablerie = TRUE

/datum/action/cooldown/vampire/auspex/get_power_desc_extended()
	. = "Sense the vitae of any creature directly, and use your keen senses to widen your perception by [zoom_out_amt] tiles, looking [zoom_amt] tiles ahead of you."
	if(add_xray)
		. += " You will see through walls and barriers as if they were glass."
	else if(add_meson)
		. += " You will sense walls and the layout of rooms."
	. += " Moving ends it."

/datum/action/cooldown/vampire/auspex/get_power_explanation_extended()
	. = list()
	. += "When Activated, your view widens by [zoom_out_amt] tiles and shifts [zoom_amt] tiles in the direction you are facing. Turn around to look elsewhere."
	. += "Moving from your spot will end the power."
	if(add_xray)
		. += "While active you sense anything in sight, seeing through walls and barriers as if they were glass."
	else if(add_meson)
		. += "While active you sense walls and the layout of rooms."
	if(see_diablerie)
		. += "While active, examining a fellow Kindred will tell you if they have committed Diablerie."
	. += "Higher levels see further and cost less to activate, but more to maintain. Walls are sensed from level 2, and seen through at level 4."

/datum/action/cooldown/vampire/auspex/activate_power()
	. = ..()
	if(!looking)
		lookie()

/datum/action/cooldown/vampire/auspex/deactivate_power()
	. = ..()
	if(looking)
		unlooky()

/datum/action/cooldown/vampire/auspex/proc/lookie()
	SIGNAL_HANDLER

	if(!listening_to)
		RegisterSignals(owner, list(COMSIG_MOVABLE_MOVED, COMSIG_MOB_LOGOUT), PROC_REF(deactivate_power))
		RegisterSignal(owner, COMSIG_ATOM_POST_DIR_CHANGE, PROC_REF(lookie))
	listening_to = owner
	var/client/client = owner?.client
	if(!client)
		return
	var/_x = 0
	var/_y = 0
	switch(owner.dir)
		if(NORTH)
			_y = zoom_amt
		if(EAST)
			_x = zoom_amt
		if(SOUTH)
			_y = -zoom_amt
		if(WEST)
			_x = -zoom_amt

	if(!looking)
		client.view_size.setBoth(zoom_out_amt, zoom_out_amt)
	client.pixel_x = ICON_SIZE_X * _x
	client.pixel_y = ICON_SIZE_Y * _y
	looking = TRUE

	if(see_diablerie)
		ADD_TRAIT(owner, TRAIT_SEE_DIABLERIE, REF(src))

	if(add_meson)
		ADD_TRAIT(owner, TRAIT_MESON_VISION, REF(src))

	if(add_xray)
		ADD_TRAIT(owner, TRAIT_XRAY_VISION, REF(src))

	owner.update_sight()

/datum/action/cooldown/vampire/auspex/proc/unlooky()
	SIGNAL_HANDLER

	if(listening_to)
		UnregisterSignal(listening_to, list(COMSIG_MOVABLE_MOVED, COMSIG_MOB_LOGOUT, COMSIG_ATOM_POST_DIR_CHANGE))
		listening_to = null

	looking = FALSE
	owner.remove_traits(list(TRAIT_SEE_DIABLERIE, TRAIT_MESON_VISION, TRAIT_XRAY_VISION), REF(src))
	owner.update_sight()

	// do this last in case weird client shit happens and runtimes
	var/client/client = owner.client || owner.canon_client
	if(client)
		client.view_size?.resetToDefault()
		client.pixel_x = 0
		client.pixel_y = 0

/datum/action/cooldown/vampire/auspex/Destroy()
	listening_to = null
	return ..()
