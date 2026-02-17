#define TRACKED_TIME "tracked_time"
#define TRACKED_VICTIM "tracked_victim"

/datum/component/antag_metric_tracker
	var/mob/living/tracked_mob
	var/datum/mind/tracked_mind

	var/list/tracked_victims = list()
	var/kills = 0
	var/lifetime = 0
	var/is_dead = FALSE
	var/tracking = FALSE

/datum/component/antag_metric_tracker/Initialize(datum/mind/_tracked_mind)
	if(!istype(_tracked_mind))
		return COMPONENT_INCOMPATIBLE
	tracked_mind = _tracked_mind
	tracked_mob = tracked_mind.current
	if(!tracked_mob || !isliving(tracked_mob))
		return COMPONENT_INCOMPATIBLE

	START_PROCESSING(SSdcs, src)
	tracking = TRUE

/datum/component/antag_metric_tracker/RegisterWithParent()
	RegisterSignal(tracked_mind, COMSIG_MIND_TRANSFERRED, PROC_REF(on_mind_transferred))
	RegisterSignal(tracked_mind, COMSIG_QDELETING, PROC_REF(stop_tracking))
	if(tracked_mob)
		RegisterSignal(tracked_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death))
		RegisterSignal(tracked_mob, COMSIG_QDELETING, PROC_REF(on_mob_qdel))

/datum/component/antag_metric_tracker/UnregisterFromParent()
	UnregisterSignal(tracked_mind, list(COMSIG_MIND_TRANSFERRED, COMSIG_QDELETING))
	if(tracked_mob)
		UnregisterSignal(tracked_mob, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	tracked_mob = null

/datum/component/antag_metric_tracker/proc/register_victim(mob/living/victim)
	if(victim == tracked_mob || !victim.ckey || !victim.client)
		return
	var/ckey = victim.ckey
	if(ckey in tracked_victims)
		var/list/entry = tracked_victims[ckey]
		var/mob/living/old = entry[TRACKED_VICTIM]
		if(old && old != victim)
			UnregisterSignal(old, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
		entry[TRACKED_VICTIM] = victim
	else
		tracked_victims[ckey] = list(TRACKED_VICTIM = victim)

	RegisterSignal(victim, COMSIG_LIVING_DEATH, PROC_REF(on_victim_killed))
	RegisterSignal(victim, COMSIG_QDELETING, PROC_REF(on_victim_lost))

/datum/component/antag_metric_tracker/proc/on_victim_killed(mob/living/victim)
	SIGNAL_HANDLER
	if(victim.ckey && unregister_victim(victim.ckey))
		kills++

/datum/component/antag_metric_tracker/proc/on_victim_lost(mob/living/victim)
	SIGNAL_HANDLER
	if(victim.ckey)
		unregister_victim(victim.ckey)

/datum/component/antag_metric_tracker/proc/unregister_victim(ckey)
	if(!(ckey in tracked_victims))
		return FALSE
	var/list/entry = tracked_victims[ckey]
	var/mob/living/victim = entry[TRACKED_VICTIM]
	if(victim)
		UnregisterSignal(victim, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	tracked_victims -= ckey
	return TRUE

/datum/component/antag_metric_tracker/proc/on_mind_transferred(datum/source, mob/living/previous_body)
	SIGNAL_HANDLER
	if(tracked_mob)
		UnregisterSignal(tracked_mob, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	tracked_mob = tracked_mind.current
	if(tracked_mob)
		RegisterSignal(tracked_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death))
		RegisterSignal(tracked_mob, COMSIG_QDELETING, PROC_REF(on_mob_qdel))
	tracked_victims.Cut()
	kills = 0

/datum/component/antag_metric_tracker/proc/on_death(mob/living/source)
	SIGNAL_HANDLER
	is_dead = TRUE

/datum/component/antag_metric_tracker/proc/on_mob_qdel(mob/living/source)
	SIGNAL_HANDLER
	tracked_mob = null

/datum/component/antag_metric_tracker/proc/stop_tracking(datum/source)
	SIGNAL_HANDLER
	tracked_mob = null
	Destroy()

/datum/component/antag_metric_tracker/process(delta_time)
	if(!tracking || !tracked_mob || QDELETED(tracked_mob) || !isliving(tracked_mob) || tracked_mob.client?.is_afk())
		return
	lifetime += delta_time

/datum/component/antag_metric_tracker/Destroy(force)
	STOP_PROCESSING(SSdcs, src)
	for(var/ckey in tracked_victims)
		unregister_victim(ckey)
	UnregisterFromParent()
	return ..()

#undef TRACKED_TIME
#undef TRACKED_VICTIM
