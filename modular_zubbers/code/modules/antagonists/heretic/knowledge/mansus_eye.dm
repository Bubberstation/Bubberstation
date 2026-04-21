// cd, visibility duration
GLOBAL_LIST_INIT(mansus_eye_commands_regex, list(
	construct_mansus_eye_regex("silence") = list(60 SECONDS, 10 SECONDS),
	construct_mansus_eye_regex("blind") = list(120 SECONDS, 40 SECONDS),
	construct_mansus_eye_regex("sleep") = list(300 SECONDS, 60 SECONDS),
	construct_mansus_eye_regex("deafen") = list(30 SECONDS, 10 SECONDS),
))

/proc/construct_mansus_eye_regex(string)
	var/regex/our_regex = new /regex("\\b([string])\\b", "i")
	return our_regex

/datum/heretic_knowledge/limited_amount/mansus_eye
	name = "Watching Eye"
	desc = "Transmute a pair of eyes, a sheet of plasmaglass, and a blindfold into a Watching Eye, a small item that you can look through as if it \
	was a camera with x-ray vision. While the eye is not contained within anything, you can utter a phrase out of a small list - such as blind, deafen - \
	to create a localized effect on targets the eye could see without x-ray vision. Only one eye can exist at a time - be careful with it."
	gain_text = "It is said the Owl gifted mankind sight. Humans could see far more, once, until the Owl realized its mistake and plucked out our \
	third eye. But through an elaborate process, one can still obtain - and open, that missing eye."
	research_tree_icon_path = 'modular_zubbers/code/modules/antagonists/heretic/icons/heretic_misc.dmi'
	research_tree_icon_state = "watching_eye_open"
	required_atoms = list(/obj/item/organ/eyes = 1, /obj/item/stack/sheet/plasmaglass = 1, /obj/item/clothing/glasses/blindfold = 1)
	result_atoms = list(/obj/item/mansus_eye)
	limit = 1
	drafting_tier = 2

/obj/item/mansus_eye
	name = "watching eye"
	desc = "An eerie eye stares back at you, unblinking, tracking your every movement."
	icon = 'modular_zubbers/code/modules/antagonists/heretic/icons/heretic_misc.dmi'
	icon_state = "watching_eye_open"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	w_class = WEIGHT_CLASS_SMALL
	var/datum/action/cooldown/mansus_eye/action
	var/datum/weakref/owner
	/// Our camera display popup
	var/atom/movable/screen/map_view/cam_screen
	/// How far can we actually see? Ranges higher than one can be used to see through walls.
	var/cam_range = 9
	/// Detects when we move to update the camera view
	var/datum/movement_detector/tracker
	COOLDOWN_DECLARE(ability_cooldown)

	alpha = 30 // transparent asf

/obj/item/mansus_eye/Initialize(mapload)
	. = ..()

	action = new /datum/action/cooldown/mansus_eye(src)
	action.linked_eye = src
	tracker = new /datum/movement_detector(src, CALLBACK(src, PROC_REF(update_view)))
	cam_screen = new
	cam_screen.generate_view("heretic_eye_popup_map")

/obj/item/mansus_eye/Destroy(force)
	. = ..()

	QDEL_NULL(action)
	QDEL_NULL(cam_screen)
	QDEL_NULL(tracker)
	owner = null

/obj/item/mansus_eye/examine(mob/user)
	. = ..()

	. += span_warning("Allows its user to view its surroundings with x-ray vision, and create localized negative effects on those nearby.")
	. += span_boldnotice("This item is heavily limited. If stored in a secure place, its owner is unlikely to get a new one.")

	if (owner == null && IS_HERETIC_OR_MONSTER(user))
		. += span_hypnophrase("Use the eye in-hand to bind to it, enabling its use.")

/obj/item/mansus_eye/proc/on_view_enabled(client/owner_client)
	var/mob/living/curr_mob = owner.resolve()
	if (isnull(curr_mob))
		return
	owner_client.setup_popup("heretic_eye_popup", 18, 18, 1, "Mind's Eye")
	cam_screen.display_to(curr_mob)
	to_chat(curr_mob, span_warning("You blink twice, and look through your distant eye."))
	to_chat(curr_mob, span_boldnotice("Speaking certain phrases will cause localized effects around your eye. Check your ability description for info."))
	RegisterSignal(owner_client, COMSIG_POPUP_CLEARED, PROC_REF(on_screen_clear))
	RegisterSignal(owner_client.mob, COMSIG_MOVABLE_SAY_QUOTE, PROC_REF(intercept_commands))
	update_view()

/obj/item/mansus_eye/proc/on_screen_clear(client/source, window)
	SIGNAL_HANDLER
	cam_screen.hide_from_client(source)
	UnregisterSignal(source, COMSIG_POPUP_CLEARED)
	if (source.mob)
		UnregisterSignal(source.mob, COMSIG_MOVABLE_SAY_QUOTE)

/obj/item/mansus_eye/proc/intercept_commands(atom/movable/source, list/message_args)
	SIGNAL_HANDLER

	var/raw_command = LOWER_TEXT(message_args[1])
	if (!raw_command)
		return
	var/command
	var/regex/found_regex
	for (var/regex/iter_regex as anything in GLOB.mansus_eye_commands_regex)
		var/result = iter_regex.Find(raw_command)
		if (result)
			command = LOWER_TEXT(iter_regex.group[1])
			found_regex = iter_regex
			break

	if (!command)
		return

	var/mob/living/owner_mob = owner.resolve()
	if (!COOLDOWN_FINISHED(src, ability_cooldown))
		if (isnull(owner_mob))
			return
		to_chat(owner_mob, span_warning("Your eye is still recovering from its last use..."))
		balloon_alert(owner_mob, "on cooldown!")
		return

	if (!isturf(loc))
		if (!isnull(owner_mob))
			to_chat(owner_mob, span_warning("Your eye can't act while in a container!"))
		return

	var/list/spec = GLOB.mansus_eye_commands_regex[found_regex]
	COOLDOWN_START(src, ability_cooldown, spec[1])
	animate(src, alpha = 255, time = 2 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(become_invisible)), spec[2])
	if (!isnull(owner_mob))
		balloon_alert(owner_mob, "success!")
		to_chat(owner_mob, span_warning("You speak, and the eye obeys."))

	var/list/targets = get_hearers_in_view(cam_range, src)

	switch (command)
		if ("silence")
			for (var/mob/living/iter_living in targets)
				if (IS_HERETIC_OR_MONSTER(iter_living))
					continue
				if (iter_living.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND))
					to_chat(iter_living, span_warning("You feel something gazing at you, but its quickly deflected by your antimagic."))
					continue
				iter_living.adjust_silence_up_to(30 SECONDS, 60 SECONDS)
				to_chat(iter_living, span_userdanger("You feel an invisible thread come over your lips! Something within view is staring at you!"))
		if ("blind")
			for (var/mob/living/iter_living in targets)
				if (IS_HERETIC_OR_MONSTER(iter_living))
					continue
				if (iter_living.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND))
					to_chat(iter_living, span_warning("You feel something gazing at you, but its quickly deflected by your antimagic."))
					continue
				iter_living.adjust_temp_blindness_up_to(15 SECONDS, 60 SECONDS)
				to_chat(iter_living, span_userdanger("You suddenly lose the ability to see! Something within view is staring at you!"))
		if ("deafen")
			for (var/mob/living/carbon/iter_living in targets)
				if (IS_HERETIC_OR_MONSTER(iter_living))
					continue
				if (iter_living.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND))
					to_chat(iter_living, span_warning("You feel something gazing at you, but its quickly deflected by your antimagic."))
					continue
				var/obj/item/organ/ears/ears = iter_living.get_organ_slot(ORGAN_SLOT_EARS)
				if (isnull(ears))
					return
				ears.adjust_temporary_deafness(30 SECONDS)
				to_chat(iter_living, span_userdanger("You suddenly lose the ability to hear! Something within view is staring at you!"))
		if ("sleep")
			for (var/mob/living/carbon/iter_living in targets)
				if (IS_HERETIC_OR_MONSTER(iter_living))
					continue
				if (iter_living.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND))
					to_chat(iter_living, span_warning("You feel something gazing at you, but its quickly deflected by your antimagic."))
					continue
				iter_living.adjust_drowsiness_up_to(15 SECONDS, 120 SECONDS)
				iter_living.adjust_eye_blur_up_to(30 SECONDS, 120 SECONDS)
				iter_living.adjust_stamina_loss(20)
				to_chat(iter_living, span_userdanger("Something within your view gazes at you, and you suddenly feel tired..."))

/obj/item/mansus_eye/proc/become_invisible()
	animate(src, alpha = initial(src.alpha), time = 2 SECONDS)

/obj/item/mansus_eye/proc/update_view()//this doesn't do anything too crazy, just updates the vis_contents of its screen obj
	cam_screen.vis_contents.Cut()
	for(var/turf/visible_turf in range(cam_range, get_turf(src)))//fuck you usr
		cam_screen.vis_contents += visible_turf

/obj/item/mansus_eye/attack_self(mob/user, modifiers)
	if (!isliving(user))
		return FALSE

	var/mob/living/living_user = user

	if (!IS_HERETIC_OR_MONSTER(living_user))
		living_user.adjust_temp_blindness_up_to(3 SECONDS, 10 SECONDS)
		to_chat(living_user, span_userdanger("The eye stares back!"))
		return TRUE

	if (isnull(owner?.resolve()))
		set_new_owner(living_user)
		return TRUE

	to_chat(living_user, span_warning("This eye is already claimed by an Acolyte!"))
	balloon_alert(living_user, "already claimed!")
	return TRUE

/obj/item/mansus_eye/proc/set_new_owner(mob/living/carbon/new_owner, silent = FALSE)
	var/mob/living/carbon/old_owner = owner?.resolve()
	if (new_owner == old_owner)
		return

	if (!isnull(old_owner))
		action.Remove(old_owner)
	owner = WEAKREF(new_owner)
	action.Grant(new_owner)
	if (!silent)
		to_chat(new_owner, span_notice("The eye binds to you, and you sense its cognition behind your own..."))

/datum/action/cooldown/mansus_eye
	name = "watching eye"
	desc = "Activates your third, distant eye, and allows you to look through it. While the window is open, speaking certain phrases will have \
	certain effects. \n\
	<b>Silence</b>: Mutes everyone in view for a brief period.\n\
	<b>Deafen</b>: Deafens everyone in view for a brief period.\n\
	<b>Blind</b>: Blinds everyone in view for a brief period.\n\
	<b>Sleep</b>: Afflicts everoyne in view with drowsiness and eye blur.\n\
	Every time a phrase is uttered, the eye will briefly become visible and will also go on cooldown for some time.\
	The effects only apply if the eye could see the target without x-ray vision."
	button_icon = 'modular_zubbers/code/modules/antagonists/heretic/icons/heretic_misc.dmi'
	button_icon_state = "watching_eye_open"
	background_icon_state = "bg_heretic"
	cooldown_time = 1 SECONDS
	overlay_icon_state = "bg_heretic_border"
	var/obj/item/mansus_eye/linked_eye

/datum/action/cooldown/mansus_eye/Activate(atom/target)
	. = ..()
	var/client/owner_client = owner.client

	if(!owner_client)
		return FALSE
	if(owner_client.screen_maps["heretic_eye_popup_map"]) //alright, the popup this object uses is already IN use, so the window is open. no point in doing any other work here, so we're good.
		return FALSE

	linked_eye.on_view_enabled(owner_client)
