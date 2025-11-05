#define TRACKED_TIME "tracked_time"
#define TRACKED_VICTIM "tracked_victim"

/datum/component/antag_metric_tracker
	var/mob/living/tracked_mob
	var/datum/mind/tracked_mind
	var/list/tracked_victims = list() // keyed by ckey
	var/list/objectives = list() // cached completed objectives
	var/kills = 0
	var/damage_dealt = 0 // TODO: Hook into actual damage application signal to update
	var/activity_time = 0 // non-AFK time
	var/objectives_completed = 0
	var/disruption_score = 0
	var/influence_score = 0
	var/is_dead = FALSE
	var/victim_track_time = 30 SECONDS
	var/tracking = FALSE
	var/effective_activity_time = 0
	var/burst_activity = 0 // approximate actions in recent window
	var/last_burst_check = 0
	var/burst_window = 5 MINUTES
	var/last_update = 0

	COOLDOWN_DECLARE(update_objectives_cooldown)

/datum/component/antag_metric_tracker/Initialize(datum/mind/_tracked_mind)
	if(!istype(_tracked_mind))
		return COMPONENT_INCOMPATIBLE
	parent = _tracked_mind
	tracked_mob = _tracked_mind.current
	if(!tracked_mob || !isliving(tracked_mob))
		return COMPONENT_INCOMPATIBLE
	last_update = world.time
	tracked_mind = parent

	RegisterWithParent()
	START_PROCESSING(SSdcs, src)
	tracking = TRUE

/datum/component/antag_metric_tracker/RegisterWithParent()
	RegisterSignal(tracked_mind, COMSIG_MIND_TRANSFERRED, PROC_REF(on_mind_transferred), TRUE)
	RegisterSignal(tracked_mind, COMSIG_QDELETING, PROC_REF(on_qdel), TRUE)
	if(tracked_mob)
		RegisterSignal(tracked_mob, COMSIG_LIVING_ATTACK_ATOM, PROC_REF(on_damage_dealt), TRUE)
		RegisterSignal(tracked_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death), TRUE)
		RegisterSignal(tracked_mob, COMSIG_QDELETING, PROC_REF(on_mob_qdel), TRUE)

/datum/component/antag_metric_tracker/UnregisterFromParent()
	UnregisterSignal(tracked_mind, list(COMSIG_MIND_TRANSFERRED, COMSIG_QDELETING))
	if(tracked_mob)
		UnregisterSignal(tracked_mob, list(COMSIG_LIVING_ATTACK_ATOM, COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	tracked_mob = null

/datum/component/antag_metric_tracker/proc/register_victim(mob/living/victim)
	if(victim == tracked_mob || !victim.ckey || !victim.client)
		return
	var/ckey = victim.ckey
	if(ckey in tracked_victims)
		var/list/entry = tracked_victims[ckey]
		var/mob/living/old_victim = entry[TRACKED_VICTIM]
		if(old_victim != victim && old_victim)
			UnregisterSignal(old_victim, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
		entry[TRACKED_TIME] = victim_track_time
		entry[TRACKED_VICTIM] = victim
		RegisterSignals(victim, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_victim_lost))
		return
	var/list/entry = list(TRACKED_VICTIM = victim, TRACKED_TIME = victim_track_time)
	tracked_victims[ckey] = entry
	RegisterSignals(victim, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_victim_lost))

/datum/component/antag_metric_tracker/proc/unregister_victim_by_ckey(ckey)
	if(!(ckey in tracked_victims))
		return FALSE
	var/list/entry = tracked_victims[ckey]
	var/mob/living/victim = entry[TRACKED_VICTIM]
	if(victim)
		UnregisterSignal(victim, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	tracked_victims -= ckey
	return TRUE

/datum/component/antag_metric_tracker/proc/on_victim_lost(mob/living/victim, gibbed)
	SIGNAL_HANDLER
	if(!victim?.ckey)
		return
	var/ckey = victim.ckey
	if(unregister_victim_by_ckey(ckey))
		kills++
		burst_activity += 1 // count kill as recent action

/datum/component/antag_metric_tracker/proc/on_mind_transferred(datum/source, mob/living/previous_body)
	SIGNAL_HANDLER
	tracking = FALSE
	if(tracked_mob)
		UnregisterSignal(tracked_mob, list(COMSIG_LIVING_ATTACK_ATOM, COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	tracked_mob = tracked_mind.current
	if(tracked_mob)
		RegisterSignal(tracked_mob, COMSIG_LIVING_ATTACK_ATOM, PROC_REF(on_damage_dealt), TRUE)
		RegisterSignal(tracked_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death))
		RegisterSignal(tracked_mob, COMSIG_QDELETING, PROC_REF(on_mob_qdel))
	objectives = list()
	objectives_completed = 0
	// Clear all tracked victims on transfer
	for(var/ckey in tracked_victims)
		unregister_victim_by_ckey(ckey)
	tracking = TRUE

/datum/component/antag_metric_tracker/process(delta_time)
	if(!tracking || !tracked_mob || QDELETED(tracked_mob) || !isliving(tracked_mob) || tracked_mob.client?.is_afk() || !tracked_mind)
		return

	activity_time += delta_time

	// Simplified burst: reset window counter every burst_window, otherwise accumulate minor activity
	if(world.time - last_burst_check > burst_window)
		last_burst_check = world.time
		burst_activity = 0 // reset to zero for new window
	burst_activity += delta_time / burst_window // normalized accumulation (0-1 per window)

	effective_activity_time += delta_time * min(1, (kills + objectives_completed + (damage_dealt > 0 ? 1 : 0)) / 3) // cap multiplier

	// Update objectives periodically
	if(COOLDOWN_FINISHED(src, update_objectives_cooldown) && length(tracked_mind.objectives))
		COOLDOWN_START(src, update_objectives_cooldown, 1 MINUTES)
		check_objectives()
		// Count completed from cache
		objectives_completed = 0
		for(var/datum/objective/objective in objectives)
			if(!istype(objective) || QDELETED(objective))
				objectives -= objective
				continue
			if(objective.completed)
				objectives_completed++
				burst_activity += 0.5 // partial credit for objective as recent action

	// Prune and update victim timers safely
	if(!length(tracked_victims))
		return
	for(var/ckey in tracked_victims.Copy()) // Copy to allow safe removal
		var/list/entry = tracked_victims[ckey]
		if(!entry)
			tracked_victims -= ckey
			continue
		var/mob/living/victim = entry[TRACKED_VICTIM]
		if(QDELETED(victim) || victim.ckey != ckey || !victim.client || entry[TRACKED_TIME] <= 0)
			unregister_victim_by_ckey(ckey)
			continue
		entry[TRACKED_TIME] -= delta_time

/datum/component/antag_metric_tracker/proc/on_damage_dealt(mob/living/attacker, atom/attacked, list/modifiers)
	SIGNAL_HANDLER
	if(!tracked_mob || attacked == tracked_mob || !isliving(attacked))
		return
	var/mob/living/victim = attacked
	if(!victim.mind || victim.stat == DEAD)
		return
	// TODO: Extract actual damage from modifiers (e.g., modifiers["damage"]) and add to damage_dealt
	// damage_dealt += calculated_damage
	// if(calculated_damage > 0) burst_activity += calculated_damage / 100
	register_victim(victim)

/datum/component/antag_metric_tracker/proc/on_death(mob/living/source, gibbed)
	SIGNAL_HANDLER
	is_dead = TRUE

/datum/component/antag_metric_tracker/proc/check_objectives()
	if(!tracked_mind || !length(tracked_mind.antag_datums))
		return
	var/list/to_check = tracked_mind.objectives.Copy()
	for(var/datum/objective/objective in to_check)
		if(!istype(objective) || !objective.check_completion())
			continue
		objectives += objective

/datum/component/antag_metric_tracker/proc/on_qdel(datum/source)
	SIGNAL_HANDLER
	tracked_mob = null
	Destroy()

/datum/component/antag_metric_tracker/proc/on_mob_qdel(datum/source)
	SIGNAL_HANDLER
	tracked_mob = null

/datum/component/antag_metric_tracker/proc/add_disruption(points)
	disruption_score += points

/datum/component/antag_metric_tracker/proc/add_influence(points)
	influence_score += points

/datum/component/antag_metric_tracker/Destroy(force, silent)
	STOP_PROCESSING(SSdcs, src)
	for(var/ckey in tracked_victims)
		unregister_victim_by_ckey(ckey)
	UnregisterFromParent()
	return ..()

#undef TRACKED_TIME
#undef TRACKED_VICTIM
