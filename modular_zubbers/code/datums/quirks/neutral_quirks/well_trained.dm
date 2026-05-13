/datum/quirk/well_trained
	name = "Well-Trained"
	desc = "You absolutely love being dominated. The thought of someone with a stronger character than yours is enough to make you act up. They can snap their fingers to send you to the floor."
	icon = "fa-sort-down"
	medical_record_text = "Patient can be easily swayed by a sufficiently assertive individual."
	value = 0
	gain_text = "<span class='notice'>You feel like being someone's pet.</span>"
	lose_text = "<span class='notice'>You no longer feel like being a pet...</span>"
	quirk_flags = QUIRK_HIDE_FROM_SCAN | QUIRK_PROCESSES
	erp_quirk = TRUE
	var/mob/living/last_dom

/datum/quirk_constant_data/well_trained
	associated_typepath = /datum/quirk/well_trained
	customization_options = list(
		/datum/preference/toggle/well_trained/gender_pref/male,
		/datum/preference/toggle/well_trained/gender_pref/female,
		/datum/preference/toggle/well_trained/gender_pref/plural,
		/datum/preference/toggle/well_trained/gender_pref/neuter,
		/datum/preference/toggle/well_trained/gender_pref/other,
		/datum/preference/toggle/well_trained/snap,
		/datum/preference/toggle/well_trained/snap2,
		/datum/preference/toggle/well_trained/snap3,
		/datum/preference/toggle/well_trained/clicker,
		/datum/preference/toggle/well_trained/sub_inspect_dom,
		/datum/preference/toggle/well_trained/sub_sense_dom,
	)

/// This next section is for quirk preferences, which is how personalization of the quirk is saved to the character slot.
/datum/preference/toggle/well_trained
	abstract_type = /datum/preference/toggle/well_trained
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

	default_value = TRUE

/datum/preference/toggle/well_trained/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences) //Unsure what this does. Revisit later
	return FALSE

/// Most of the functionalities of Dominant Aura and Well-Trained require both the dom and sub to share a preference for each other. Gender preferences are selected via the quirk menu and stored as character prefs.
/datum/preference/toggle/well_trained/gender_pref
	abstract_type = /datum/preference/toggle/well_trained/gender_pref

/datum/preference/toggle/well_trained/gender_pref/male
	savefile_key = "well_trained__prefers_males"
/datum/preference/toggle/well_trained/gender_pref/female
	savefile_key = "well_trained__prefers_females"
/datum/preference/toggle/well_trained/gender_pref/plural
	savefile_key = "well_trained__prefers_plurals"
/datum/preference/toggle/well_trained/gender_pref/neuter
	savefile_key = "well_trained__prefers_neuters"
/datum/preference/toggle/well_trained/gender_pref/other ///This was not coded with any specific use case in mind. Just figured it'd be a good idea.
	savefile_key = "well_trained__prefers_other"

/// Players can also opt-out of most interactions even if all other requirements are met.
/datum/preference/toggle/well_trained/sub_sense_dom
	savefile_key = "well_trained__sub_sense_dom"
/datum/preference/toggle/well_trained/snap
	savefile_key = "well_trained__snap"
/datum/preference/toggle/well_trained/snap2
	savefile_key = "well_trained__snap2"
/datum/preference/toggle/well_trained/snap3
	savefile_key = "well_trained__snap3"
/datum/preference/toggle/well_trained/clicker
	savefile_key = "well_trained__clicker"
/datum/preference/toggle/well_trained/sub_inspect_dom
	savefile_key = "well_trained__sub_inspect_dom"


/datum/quirk/well_trained/proc/check_if_dom_is_preferred(mob/living/carbon/human/dom)
	if(!quirk_holder.client) //sanity
		return
	switch(dom.gender)
		if(MALE)
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/well_trained/gender_pref/male)
		if(FEMALE)
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/well_trained/gender_pref/female)
		if(PLURAL)
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/well_trained/gender_pref/plural)
		if(NEUTER)
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/well_trained/gender_pref/neuter)
		else
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/well_trained/gender_pref/other)

/datum/quirk/well_trained/proc/check_if_sub_dom_mutually_preferred(mob/living/carbon/human/dom)
	if(!check_if_dom_is_preferred(dom))
		return FALSE
	var/datum/quirk/dominant_aura/dom_quirk = dom.get_quirk(/datum/quirk/dominant_aura)
	if(!dom_quirk.check_if_sub_is_preferred(quirk_holder))
		return FALSE
	else
		return TRUE

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
	if(!check_if_sub_dom_mutually_preferred(dom))
		return
	if(!(quirk_holder.client.prefs.read_preference(/datum/preference/toggle/well_trained/sub_inspect_dom) && dom.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/sub_inspect_dom)))
		return
	if(dom.stat == DEAD)
		return
	examine_list += span_purple("You can't look at <b>[dom]</b> for long before flustering away.")

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
	if(!quirk_holder.client.prefs.read_preference(/datum/preference/toggle/well_trained/sub_sense_dom))
		return //otherwise subs that disable this effect will be permanently mood debuffed
	. = FALSE
	// handles calculating nearby dominant quirk holders.
	var/list/mob/living/carbon/human/humandoms = viewers(world.view / 2, quirk_holder)
	var/list/mob/living/silicon/robot/robodoms = viewers(world.view / 2, quirk_holder)
	var/list/mob/living/doms = humandoms + robodoms
	var/closest_distance
	for(var/mob/living/dom in doms)
		if(dom != quirk_holder && dom.has_quirk(/datum/quirk/dominant_aura)) // Does the detected players have dom aura quirk and is not src player
			if(check_if_sub_dom_mutually_preferred(dom) && dom.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/sub_sense_dom)) // Do we like each others' genders, and does the dom want the aura mechanic
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
