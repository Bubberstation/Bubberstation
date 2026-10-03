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
	// linked_alert is only assigned when the effect is first created, so fall back to the live alert on a refresh.
	var/atom/movable/screen/alert/status_effect/changeling_revival_fatigue/fatigue_alert = linked_alert || owner?.alerts[id]
	if(istype(fatigue_alert))
		fatigue_alert.update_stacks(stacks)

/atom/movable/screen/alert/status_effect/changeling_revival_fatigue
	name = "Revival Fatigue"
	desc = "Our flesh is worn thin from coming back so often. Each stack makes the next Reviving Stasis take half again as long. Stay alive to shed them."
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "asleep"
	/// Maptext overlay showing the current stack count in the corner.
	var/mutable_appearance/stacks_overlay

/atom/movable/screen/alert/status_effect/changeling_revival_fatigue/Destroy()
	QDEL_NULL(stacks_overlay)
	return ..()

/atom/movable/screen/alert/status_effect/changeling_revival_fatigue/proc/update_stacks(stacks)
	name = "Revival Fatigue x[stacks]"
	cut_overlay(stacks_overlay)
	stacks_overlay = new
	stacks_overlay.maptext = MAPTEXT("<span style='color: #dd66dd'>x[stacks]</span>")
	stacks_overlay.transform = stacks_overlay.transform.Translate(3, 2)
	stacks_overlay.layer = layer
	add_overlay(stacks_overlay)

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

/// The stock readout writes to the alert's own maptext, which draws off the bottom edge of the icon. Draw it as a corner overlay instead.
/datum/status_effect/changeling_stasis_countdown/update_shown_duration()
	var/atom/movable/screen/alert/status_effect/changeling_stasis_countdown/stasis_alert = linked_alert || owner?.alerts[id]
	if(istype(stasis_alert))
		stasis_alert.update_time_left(duration)

/atom/movable/screen/alert/status_effect/changeling_stasis_countdown
	name = "Reviving Stasis"
	desc = "We are knitting ourselves back together. When this runs out, we can rise again."
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "stun"
	/// Maptext overlay showing the seconds remaining in the corner.
	var/mutable_appearance/time_left_overlay

/atom/movable/screen/alert/status_effect/changeling_stasis_countdown/Destroy()
	QDEL_NULL(time_left_overlay)
	return ..()

/atom/movable/screen/alert/status_effect/changeling_stasis_countdown/proc/update_time_left(time_left)
	cut_overlay(time_left_overlay)
	time_left_overlay = new
	time_left_overlay.maptext = MAPTEXT("<span style='color: #28c2dd'>[ceil(time_left / (1 SECONDS))]</span>")
	time_left_overlay.transform = time_left_overlay.transform.Translate(3, 2)
	time_left_overlay.layer = layer
	add_overlay(time_left_overlay)
