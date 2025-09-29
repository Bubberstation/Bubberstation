/datum/quirk/well_trained
	name = "Well-Trained"
	desc = "You absolutely love being dominated. The thought of someone with a stronger character than yours is enough to make you act up. They can snap their fingers to send you to the floor."
	icon = "fa-sort-down"
	medical_record_text = "Patient can be easily swayed by a sufficiently assertive individual"
	// Yes, it should be neutral. Yes, this is a bad idea. This is funny and multiple people are saying it's time to be funny.
	value = -1
	gain_text = "<span class='notice'>You feel like being someone's pet</span>"
	lose_text = "<span class='notice'>You no longer feel like being a pet...</span>"
	quirk_flags = QUIRK_HIDE_FROM_SCAN | QUIRK_PROCESSES
	erp_quirk = TRUE
	var/mob/living/carbon/human/last_dom

/datum/quirk/well_trained/add(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINING, PROC_REF(on_dom_examine))

/datum/quirk/well_trained/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_MOB_EXAMINING)

/datum/quirk/well_trained/proc/on_dom_examine(atom/source, mob/living/dom, list/examine_list)
	SIGNAL_HANDLER

	if(!istype(dom))
		return
	if(!dom.has_quirk(/datum/quirk/dominant_aura) || (dom == quirk_holder))
		return
	if(dom.stat == DEAD)
		return
	examine_list += span_purple("You can't look at <b>[dom]</b> for long before flustering away")

	if(TIMER_COOLDOWN_FINISHED(dom, DOMINANT_COOLDOWN_EXAMINE))
		to_chat(dom, span_purple("<b>[source]</b> tries to look at you but immediately looks away with a red face..."))
		TIMER_COOLDOWN_START(dom, DOMINANT_COOLDOWN_EXAMINE, 15 SECONDS)
		INVOKE_ASYNC(quirk_holder, TYPE_PROC_REF(/mob, emote), "blush") // Needs to be aynsc because of the cooldown.
		quirk_holder.dir = turn(get_dir(quirk_holder, dom), pick(-90, 90))

/datum/quirk/well_trained/process(seconds_per_tick)
	if(quirk_holder.stat == DEAD) // Doms can't be dead
		return
	if(!TIMER_COOLDOWN_FINISHED(quirk_holder, NOTICE_COOLDOWN)) // 15 second Early return
		return
	if(!quirk_holder)
		return
	. = FALSE
	// handles calculating nearby dominant quirk holders.
	var/list/mob/living/carbon/human/doms = viewers(world.view / 2, quirk_holder)
	var/closest_distance
	for(var/mob/living/carbon/human/dom in doms)
		if(dom != quirk_holder && dom.has_quirk(/datum/quirk/dominant_aura)) // Does the detected players have dom aura quirk and is not src player
			if(!closest_distance || get_dist(quirk_holder, dom) <= closest_distance) // If original dom is not closest, set a new one
				. = dom // set parent to new dom.
				closest_distance = get_dist(quirk_holder, dom) // set new closest distance.
	if(!.) // If there's no dom nearby.
		last_dom = null
		quirk_holder.add_mood_event(DOMINANT_MOOD, /datum/mood_event/dominant/need)
		return

	if(last_dom) // Same dominant, don't rerun code.
		TIMER_COOLDOWN_START(quirk_holder, NOTICE_COOLDOWN, 15 SECONDS)
		return

	last_dom = . // Set new dom and run new code

	var/list/notices = list(
		"You feel someone's presence making you more submissive.",
		"The thought of being commanded floods you with lust.",
		"You really want to be called a pet.",
		"Someone's presence is making you all flustered.",
		"You start getting excited and sweating."
	)
	quirk_holder.add_mood_event(DOMINANT_MOOD, /datum/mood_event/dominant/good_boy)
	to_chat(quirk_holder, span_purple(pick(notices)))
	TIMER_COOLDOWN_START(quirk_holder, NOTICE_COOLDOWN, 15 SECONDS)
