/// Tracks how worn out a changeling's Reviving Stasis has left them, purely so the stack count and the wait are visible on the HUD.
/datum/status_effect/changeling_revival_fatigue
	id = "changeling_revival_fatigue"
	duration = STATUS_EFFECT_PERMANENT
	status_type = STATUS_EFFECT_REFRESH
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/changeling_revival_fatigue
	/// How many stacks of Revival Fatigue we're displaying.
	var/stacks = 0

/datum/status_effect/changeling_revival_fatigue/proc/set_stacks(new_stacks)
	stacks = new_stacks
	var/atom/movable/screen/alert/status_effect/changeling_revival_fatigue/fatigue_alert = linked_alert
	fatigue_alert?.update_stacks(stacks)

/atom/movable/screen/alert/status_effect/changeling_revival_fatigue
	name = "Revival Fatigue"
	desc = "Our flesh is worn thin from coming back so often. Each stack makes the next Reviving Stasis take half again as long. Stay alive to shed them."
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "asleep"

/atom/movable/screen/alert/status_effect/changeling_revival_fatigue/proc/update_stacks(stacks)
	name = "Revival Fatigue x[stacks]"
	maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px'><font color='#dd66dd'>[stacks]</font></div>")

/// Counts down the wait until Reviving Stasis is ready, so the changeling isn't staring at a black screen guessing.
/datum/status_effect/changeling_stasis_countdown
	id = "changeling_stasis_countdown"
	status_type = STATUS_EFFECT_REPLACE
	tick_interval = STATUS_EFFECT_NO_TICK
	show_duration = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/changeling_stasis_countdown

/datum/status_effect/changeling_stasis_countdown/on_creation(mob/living/new_owner, stasis_duration = 1 MINUTES)
	duration = stasis_duration
	return ..()

/// The stock duration readout renders as a centered block the height of the whole icon, which drops the digits off the bottom edge. Pin it to the corner instead.
/datum/status_effect/changeling_stasis_countdown/update_shown_duration()
	if(!linked_alert)
		return
	linked_alert.maptext = MAPTEXT_TINY_UNICODE("[round(duration / 10, 1)]s")

/atom/movable/screen/alert/status_effect/changeling_stasis_countdown
	name = "Reviving Stasis"
	desc = "We are knitting ourselves back together. When this runs out, we can rise again."
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "stun"
	maptext_x = 2
	maptext_y = 2
	maptext_width = 30
	maptext_height = 9
