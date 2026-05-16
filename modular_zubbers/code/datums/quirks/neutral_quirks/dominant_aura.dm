/datum/quirk/dominant_aura
	name = "Dominant Aura"
	desc = "You are assertive enough to command your more obedient cohorts. At a snap of your fingers, you can compel their attention-- or send them to the floor."
	icon = "fa-sort-up"
	medical_record_text = "Patient displays a highly assertive personality."
	value = 0
	gain_text = span_notice("You feel like making someone your pet.")
	lose_text = span_notice("You feel less assertive than before.")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	erp_quirk = TRUE // Disables on ERP config.

/datum/quirk_constant_data/dominant_aura
	associated_typepath = /datum/quirk/dominant_aura
	customization_options = list(
		/datum/preference/toggle/dominant_aura/gender_pref/male,
		/datum/preference/toggle/dominant_aura/gender_pref/female,
		/datum/preference/toggle/dominant_aura/gender_pref/plural,
		/datum/preference/toggle/dominant_aura/gender_pref/neuter,
		/datum/preference/toggle/dominant_aura/gender_pref/other,
		/datum/preference/toggle/dominant_aura/snap,
		/datum/preference/toggle/dominant_aura/snap2,
		/datum/preference/toggle/dominant_aura/snap3,
		/datum/preference/toggle/dominant_aura/clicker,
		/datum/preference/toggle/dominant_aura/sub_inspect_dom,
		/datum/preference/toggle/dominant_aura/sub_sense_dom,
	)

/// This next section is for quirk preferences, which is how personalization of the quirk is saved to the character slot.
/datum/preference/toggle/dominant_aura
	abstract_type = /datum/preference/toggle/dominant_aura
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

	default_value = TRUE

/datum/preference/toggle/dominant_aura/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences) //Unsure what this does. Revisit later
	return FALSE

/// Most of the functionalities of Dominant Aura and Well-Trained require both the dom and sub to share a preference for each other. Gender preferences are selected via the quirk menu and stored as character prefs.
/datum/preference/toggle/dominant_aura/gender_pref
	abstract_type = /datum/preference/toggle/dominant_aura/gender_pref

/datum/preference/toggle/dominant_aura/gender_pref/male
	savefile_key = "dom_aura__prefers_males"
/datum/preference/toggle/dominant_aura/gender_pref/female
	savefile_key = "dom_aura__prefers_females"
/datum/preference/toggle/dominant_aura/gender_pref/plural
	savefile_key = "dom_aura__prefers_plurals"
/datum/preference/toggle/dominant_aura/gender_pref/neuter
	savefile_key = "dom_aura__prefers_neuters"
/datum/preference/toggle/dominant_aura/gender_pref/other ///This was not coded with any specific use case in mind. Just figured it'd be a good idea.
	savefile_key = "dom_aura__prefers_other"

/// Players can also opt-out of most interactions even if all other requirements are met.
/datum/preference/toggle/dominant_aura/sub_sense_dom
	savefile_key = "dom_aura__sub_sense_dom"
/datum/preference/toggle/dominant_aura/snap
	savefile_key = "dom_aura__snap"
/datum/preference/toggle/dominant_aura/snap2
	savefile_key = "dom_aura__snap2"
/datum/preference/toggle/dominant_aura/snap3
	savefile_key = "dom_aura__snap3"
/datum/preference/toggle/dominant_aura/clicker
	savefile_key = "dom_aura__clicker"
/datum/preference/toggle/dominant_aura/sub_inspect_dom
	savefile_key = "dom_aura__sub_inspect_dom"


/datum/quirk/dominant_aura/proc/check_if_sub_is_preferred(mob/living/carbon/human/sub)
	if(!quirk_holder.client) //sanity
		return
	switch(sub.gender)
		if(MALE)
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/gender_pref/male)
		if(FEMALE)
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/gender_pref/female)
		if(PLURAL)
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/gender_pref/plural)
		if(NEUTER)
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/gender_pref/neuter)
		else
			return quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/gender_pref/other)

/datum/quirk/dominant_aura/proc/check_if_dom_sub_mutually_preferred(mob/living/carbon/human/sub)
	if(!check_if_sub_is_preferred(sub))
		return FALSE
	var/datum/quirk/well_trained/sub_quirk = sub.get_quirk(/datum/quirk/well_trained)
	if(!sub_quirk.check_if_dom_is_preferred(quirk_holder))
		return FALSE
	else
		return TRUE

/datum/quirk/dominant_aura/add(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINING, PROC_REF(on_sub_examine))
	RegisterSignal(quirk_holder, COMSIG_MOB_EMOTE, PROC_REF(on_snap))

/datum/quirk/dominant_aura/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_MOB_EXAMINING)
	UnregisterSignal(quirk_holder, COMSIG_MOB_EMOTE)

/datum/quirk/dominant_aura/proc/on_sub_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!istype(user))
		return
	var/mob/living/carbon/human/sub = user
	if(!sub.has_quirk(/datum/quirk/well_trained))
		return
	if(!check_if_dom_sub_mutually_preferred(sub))
		return
	if(sub.stat == DEAD)
		return
	examine_list += span_purple("[sub.p_They()] seem[sub.p_s()] submissive towards you.")

/datum/quirk/dominant_aura/proc/on_snap(atom/source, datum/emote/emote_args)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(handle_snap), source, emote_args)

/datum/quirk/dominant_aura/proc/handle_snap(atom/source, datum/emote/emote_args)

	. = FALSE
	var/list/emote_list = list("snap", "snap2", "snap3")
	if(locate(emote_args.key) in emote_list)
		return
	if(!TIMER_COOLDOWN_FINISHED(quirk_holder, DOMINANT_COOLDOWN_SNAP))
		return

	for(var/mob/living/carbon/human/sub in hearers(world.view / 2, quirk_holder))
		if(sub == quirk_holder || sub.stat == DEAD || (HAS_TRAIT(sub, TRAIT_QUICKREFLEXES)))
			continue
		if(!sub.has_quirk(/datum/quirk/well_trained))
			continue
		if(!check_if_dom_sub_mutually_preferred(sub))
			return
		var/good_x = "pet"
		switch(sub.gender)
			if(MALE)
				good_x = "boy"
			if(FEMALE)
				good_x = "girl"

		switch(emote_args.key)
			if("snap")
				if(quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/snap) && sub.client.prefs.read_preference(/datum/preference/toggle/well_trained/snap))
					sub.dir = get_dir(sub, quirk_holder)
					sub.emote("me", 1, "faces towards <b>[quirk_holder]</b> at attention!", TRUE)
					to_chat(sub, span_purple("<b>[quirk_holder]</b>'s snap shoots down your spine and puts you at attention."))
					. = TRUE

			if("snap2")
				if(quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/snap2) && sub.client.prefs.read_preference(/datum/preference/toggle/well_trained/snap2))
					sub.dir = get_dir(sub, quirk_holder)
					sub.Immobilize(0.3 SECONDS)
					sub.emote("me",1,"hunches down in response to <b>[quirk_holder]'s</b> snapping.", TRUE)
					to_chat(sub, span_purple("You hunch down and freeze in place in response to <b>[quirk_holder]</b> snapping their fingers."))
					. = TRUE

			if("snap3")
				if(quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/snap3) && sub.client.prefs.read_preference(/datum/preference/toggle/well_trained/snap3))
					sub.KnockToFloor(knockdown_amt = 0.1 SECONDS)
					step(sub, get_dir(sub, quirk_holder))
					sub.emote("me",1,"falls to the floor and crawls closer to <b>[quirk_holder]</b>, following their command.",TRUE)
					sub.do_jitter_animation(0.1 SECONDS)
					to_chat(sub, span_purple("You throw yourself on the floor like a pathetic beast and crawl towards <b>[quirk_holder]</b> like a good, submissive [good_x]."))
					. = TRUE


//Gotta check for borg module
	for(var/mob/living/silicon/robot/borg_sub in hearers(world.view / 2, quirk_holder))
		if(!borg_sub.has_quirk(/datum/quirk/well_trained) || (borg_sub == quirk_holder) || (HAS_TRAIT(borg_sub, TRAIT_QUICKREFLEXES)))
			continue
		if(borg_sub.stat == DEAD)
			continue
		var/good_x = "pet"
		switch(borg_sub.gender)
			if(MALE)
				good_x = "boy"
			if(FEMALE)
				good_x = "girl"

		switch(emote_args.key)
			if("snap")
				if(quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/snap) && borg_sub.client.prefs.read_preference(/datum/preference/toggle/well_trained/snap))
					borg_sub.dir = get_dir(borg_sub, quirk_holder)
					borg_sub.emote("me", 1, "faces towards <b>[quirk_holder]</b> at attention!", TRUE)
					to_chat(borg_sub, span_purple("<b>[quirk_holder]</b>'s snap shoots down your spine and puts you at attention."))
					. = TRUE

			if("snap2")
				if(quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/snap2) && borg_sub.client.prefs.read_preference(/datum/preference/toggle/well_trained/snap2))
					borg_sub.dir = get_dir(borg_sub, quirk_holder)
					borg_sub.robot_lay_down()
					borg_sub.Stun(0.3 SECONDS)
					borg_sub.emote("me",1,"hunches down in response to <b>[quirk_holder]'s</b> snapping.", TRUE)
					to_chat(borg_sub, span_purple("You hunch down and freeze in place in response to <b>[quirk_holder]</b> snapping their fingers."))
					. = TRUE

			if("snap3")
				if(quirk_holder.client.prefs.read_preference(/datum/preference/toggle/dominant_aura/snap3) && borg_sub.client.prefs.read_preference(/datum/preference/toggle/well_trained/snap3))
					step(borg_sub, get_dir(borg_sub, quirk_holder))
					borg_sub.robot_lay_down()
					borg_sub.Stun(0.3 SECONDS)
					borg_sub.emote("me",1,"crawls closer to <b>[quirk_holder]</b> and lays down, following their command.",TRUE)
					borg_sub.do_jitter_animation(0.1 SECONDS)
					to_chat(borg_sub, span_purple("You crawl towards <b>[quirk_holder]</b> and lay down like a good, submissive [good_x]."))
					. = TRUE

	if(.)
		TIMER_COOLDOWN_START(quirk_holder, DOMINANT_COOLDOWN_SNAP, 10 SECONDS) // 1/10th of a second knockdown with a 10 seconds cooldown on a neutral quirk.

