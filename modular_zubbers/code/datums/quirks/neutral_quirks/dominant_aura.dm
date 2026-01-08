/datum/quirk/dominant_aura
	name = "Dominant Aura"
	desc = "Your personality is assertive enough to appear as powerful to other people, so much in fact that the weaker kind can't help but throw themselves at your feet on command."
	icon = "fa-sort-up"
	medical_record_text = "Patient displays a high level of assertiveness within their personality."
	value = 0
	gain_text = span_notice("You feel like making someone your pet.")
	lose_text = span_notice("You feel less assertive than before")
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	erp_quirk = TRUE // Disables on ERP config.

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
	if(sub.stat == DEAD)
		return
	examine_list += span_purple("You can sense submissiveness irradiating from them.")

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
		if(!sub.has_quirk(/datum/quirk/well_trained) || (sub == quirk_holder))
			continue
		if(sub.stat == DEAD)
			continue
		var/good_x = "pet"
		switch(sub.gender)
			if(MALE)
				good_x = "boy"
			if(FEMALE)
				good_x = "girl"

		switch(emote_args.key)
			if("snap")
				sub.dir = get_dir(sub, quirk_holder)
				sub.emote("me", 1, "faces towards <b>[quirk_holder]</b> at attention!", TRUE)
				to_chat(sub, span_purple("<b>[quirk_holder]</b>'s snap shoots down your spine and puts you at attention"))

			if("snap2")
				sub.dir = get_dir(sub, quirk_holder)
				sub.Immobilize(0.3 SECONDS)
				sub.emote("me",1,"hunches down in response to <b>[quirk_holder]'s</b> snapping.", TRUE)
				to_chat(sub, span_purple("You hunch down and freeze in place in response to <b>[quirk_holder]</b> snapping their fingers"))

			if("snap3")
				sub.KnockToFloor(knockdown_amt = 0.1 SECONDS)
				step(sub, get_dir(sub, quirk_holder))
				sub.emote("me",1,"falls to the floor and crawls closer to <b>[quirk_holder]</b>, following their command.",TRUE)
				sub.do_jitter_animation(0.1 SECONDS)
				to_chat(sub, span_purple("You throw yourself on the floor like a pathetic beast and crawl towards <b>[quirk_holder]</b> like a good, submissive [good_x]."))

		. = TRUE

//Gotta check for borg module
	for(var/mob/living/silicon/robot/borg_sub in hearers(world.view / 2, quirk_holder))
		if(!borg_sub.has_quirk(/datum/quirk/well_trained) || (borg_sub == quirk_holder))
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
				borg_sub.dir = get_dir(borg_sub, quirk_holder)
				borg_sub.emote("me", 1, "faces towards <b>[quirk_holder]</b> at attention!", TRUE)
				to_chat(borg_sub, span_purple("<b>[quirk_holder]</b>'s snap shoots down your spine and puts you at attention"))

			if("snap2")
				borg_sub.dir = get_dir(borg_sub, quirk_holder)
				borg_sub.robot_lay_down()
				borg_sub.Stun(0.3 SECONDS)
				borg_sub.emote("me",1,"hunches down in response to <b>[quirk_holder]'s</b> snapping.", TRUE)
				to_chat(borg_sub, span_purple("You hunch down and freeze in place in response to <b>[quirk_holder]</b> snapping their fingers"))

			if("snap3")
				step(borg_sub, get_dir(borg_sub, quirk_holder))
				borg_sub.robot_lay_down()
				borg_sub.Stun(0.3 SECONDS)
				borg_sub.emote("me",1,"crawls closer to <b>[quirk_holder]</b> and lays down, following their command.",TRUE)
				borg_sub.do_jitter_animation(0.1 SECONDS)
				to_chat(borg_sub, span_purple("You crawl towards <b>[quirk_holder]</b> and lay down like a good, submissive [good_x]."))

		. = TRUE

	if(.)
		TIMER_COOLDOWN_START(quirk_holder, DOMINANT_COOLDOWN_SNAP, 10 SECONDS) // 1/10th of a second knockdown with a 10 seconds cooldown on a neutral quirk.

