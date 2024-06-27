/datum/quirk/well_trained
	name = "Well-Trained"
	desc = "You absolutely love being dominated. The thought of someone with a stronger character than yours is enough to make you act up."
	icon = "fa-sort-down"
	medical_record_text = "Patient can be easily swayed by a sufficiently assertive individual"
	// Yes, it should be neutral. Yes, this is a bad idea. This is funny and multiple people are saying it's time to be funny.
	value = -1
	gain_text = "<span class='notice'>You feel like being someone's pet</span>"
	lose_text = "<span class='notice'>You no longer feel like being a pet...</span>"
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_HIDE_FROM_SCAN | QUIRK_PROCESSES
	erp_quirk = TRUE
	var/mood_category = "dom_trained"
	var/mob/living/carbon/human/last_dom

/datum/quirk/well_trained/add(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINING, PROC_REF(on_dom_examine))

/datum/quirk/well_trained/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_MOB_EXAMINING)

/datum/quirk/well_trained/proc/on_dom_examine(atom/source, mob/living/user, list/examine_list)
	SIGNAL_HANDLER

	if(!ishuman(user))
		return
	if(user.stat == DEAD)
		return

	var/mob/living/carbon/human/dom = user
	if(!dom.has_quirk(/datum/quirk/dominant_aura) || (dom == quirk_holder))
		return

	examine_list += span_purple("You can't look at [quirk_holder] for long for long before flustering away")
	if(TIMER_COOLDOWN_FINISHED(user, DOMINANT_COOLDOWN_EXAMINE))
		to_chat(dom, span_purple("<b>[user]</b> tries to look at you but immedietly looks away with a red face..."))
		TIMER_COOLDOWN_START(user, DOMINANT_COOLDOWN_EXAMINE, 15 SECONDS)
		INVOKE_ASYNC(quirk_holder, TYPE_PROC_REF(/mob, emote), "blush") // Needs to be aynsc because of the cooldown.
		quirk_holder.dir = turn(get_dir(quirk_holder, dom), pick(-90, 90))
/datum/quirk/well_trained/process(seconds_per_tick)
	if(quirk_holder.stat == DEAD)
		return
	if(!TIMER_COOLDOWN_FINISHED(quirk_holder, NOTICE_COOLDOWN))
		return
	if(!quirk_holder)
		return
	// Check for male, female, or other
	var/good_x = "pet"
	switch(quirk_holder.gender)
		if(MALE)
			good_x = "boy"
		if(FEMALE)
			good_x = "girl"

	. = FALSE
	var/list/mob/living/carbon/human/doms = viewers(5, quirk_holder)
	var/closest_distance
	for(var/mob/living/carbon/human/dom in doms)
		if(dom != quirk_holder && dom.has_quirk(/datum/quirk/dominant_aura))
			if(!closest_distance || get_dist(quirk_holder, dom) <= closest_distance)
				. = dom
				closest_distance = get_dist(quirk_holder, dom)
	if(!.)
		last_dom = null
		quirk_holder.add_mood_event("dominant", /datum/mood_event/dominant/need)
		return

	if(last_dom)
		TIMER_COOLDOWN_START(quirk_holder, NOTICE_COOLDOWN, 15 SECONDS)
		return

	last_dom = .

	var/list/notices = list(
		"You feel someone's presence making you more submissive.",
		"The thought of being commanded floods you with lust.",
		"You really want to be called a good [good_x].",
		"Someone's presence is making you all flustered.",
		"You start getting excited and sweating."
	)
	quirk_holder.add_mood_event("dominant", /datum/mood_event/dominant/good_boy)
	to_chat(quirk_holder, span_purple(pick(notices)))
	TIMER_COOLDOWN_START(quirk_holder, NOTICE_COOLDOWN, 15 SECONDS)
