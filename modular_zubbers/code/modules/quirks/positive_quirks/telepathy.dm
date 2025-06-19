/datum/mutation/telepathy
	power_path = /datum/action/cooldown/spell/pointed/telepathy

/datum/action/cooldown/spell/pointed/telepathy
	name = "Telepathic Communication"
	desc = "<b>Left click</b>: point target to project a thought to them. <b>Right click</b>: project to your last thought target, if in range."
	button_icon = 'icons/mob/actions/actions_revenant.dmi'
	button_icon_state = "r_transmit"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	antimagic_flags = MAGIC_RESISTANCE_MIND
	cooldown_time = 1 SECONDS
	cast_range = 7
	/// What's the last mob we point-targeted with this ability?
	var/datum/weakref/last_target_ref
	/// The message we send
	var/message
	/// Are we blocking casts?
	var/blocked = FALSE

/datum/action/cooldown/spell/pointed/telepathy/is_valid_target(atom/cast_on)
	. = ..()
	if (!.)
		return FALSE

	if (!isliving(cast_on))
		to_chat(owner, span_warning("Inanimate objects can't hear your thoughts."))
		owner.balloon_alert(owner, "not a thing with thoughts!")
		return FALSE

	var/mob/living/living_target = cast_on
	if (living_target.stat == DEAD)
		to_chat(owner, span_warning("The disruptive noise of departed resonance inhibits your ability to communicate with the dead."))
		owner.balloon_alert(owner, "can't transmit to the dead!")
		return FALSE

	if (get_dist(living_target, owner) > cast_range)
		owner.balloon_alert(owner, "too far away!")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/telepathy/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST || blocked)
		return

	message = autopunct_bare(capitalize(tgui_input_text(owner, "What do you wish to whisper to [cast_on]?", "[src]", max_length = MAX_MESSAGE_LEN)))
	if(QDELETED(src) || QDELETED(owner) || QDELETED(cast_on) || !can_cast_spell())
		return . | SPELL_CANCEL_CAST

	if(get_dist(cast_on, owner) > cast_range)
		owner.balloon_alert(owner, "they're too far!")
		return . | SPELL_CANCEL_CAST

	if(!message || length(message) == 0)
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

/datum/action/cooldown/spell/pointed/telepathy/Trigger(trigger_flags, atom/target)
	if (trigger_flags & TRIGGER_SECONDARY_ACTION)
		var/mob/living/last_target = last_target_ref?.resolve()

		if(isnull(last_target))
			last_target_ref = null
			owner.balloon_alert(owner, "last target is not available!")
			return
		else if(get_dist(last_target, owner) > cast_range)
			owner.balloon_alert(owner, "[last_target] is too far away!")
			return

		blocked = TRUE

		message = autopunct_bare(capitalize(tgui_input_text(owner, "What do you wish to whisper to [last_target]?", "[src]", max_length = MAX_MESSAGE_LEN)))
		if(QDELETED(src) || QDELETED(owner) || QDELETED(last_target) || !can_cast_spell())
			blocked = FALSE
			return
		send_thought(owner, last_target, message)
		src.StartCooldown()
		blocked = FALSE
		return

	. = ..()

/datum/action/cooldown/spell/pointed/telepathy/cast(mob/living/cast_on)
	. = ..()
	send_thought(owner, cast_on, message)

/datum/action/cooldown/spell/pointed/telepathy/proc/send_thought(mob/living/caster, mob/living/target, message)
	log_directed_talk(caster, target, message, LOG_SAY, tag = "telepathy")

	last_target_ref = WEAKREF(target)

	to_chat(owner, span_boldnotice("You reach out and convey to [target]: \"[span_purple(message)]\""))
	// flub a runechat chat message, do something with the language later
	if(owner.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
		owner.create_chat_message(owner, owner.get_selected_language(), message, list("italics"))
	if(!target.can_block_magic(antimagic_flags, charge_cost = 0) && target.client) //make sure we've got a client before we bother sending anything
		//different messaging if the target has the telepathy mutation themselves themselves
		if (ishuman(target))
			var/mob/living/carbon/human/human_target = target
			var/datum/mutation/telepathy/tele_mut = human_target.dna.get_mutation(/datum/mutation/telepathy)

			if (tele_mut)
				to_chat(target, span_boldnotice("[caster]'s psychic presence resounds in your mind: \"[span_purple(message)]\""))
			else
				to_chat(target, span_boldnotice("A voice echoes in your head: \"[span_purple(message)]\""))

		if(target.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
			target.create_chat_message(target, target.get_selected_language(), message, list("italics")) // it appears over them since they hear it in their head
	else
		owner.balloon_alert(owner, "something blocks your thoughts!")
		to_chat(owner, span_warning("Your mind encounters impassable resistance: the thought was blocked!"))
		return

	// send to ghosts as well i guess
	for(var/mob/dead/ghost as anything in GLOB.dead_mob_list)
		if(!isobserver(ghost))
			continue

		var/from_link = FOLLOW_LINK(ghost, owner)
		var/from_mob_name = span_boldnotice("[owner]")
		var/to_link = FOLLOW_LINK(ghost, target)
		var/to_mob_name = span_name("[target]")

		to_chat(ghost, "[from_link] " + span_purple("<b>\[Telepathy\]</b> [from_mob_name] transmits, \"[message]\"") + " to [to_mob_name] [to_link]")

/datum/quirk/telepathic
	name = "Telepathic"
	desc = "You are able to transmit your thoughts to other living creatures."
	gain_text = span_purple("Your mind roils with psychic energy.")
	lose_text = span_notice("Mundanity encroaches upon your thoughts once again.")
	medical_record_text = "Patient has an unusually enlarged Broca's area visible in cerebral biology, and appears to be able to communicate via extrasensory means."
	value = 3
	icon = FA_ICON_HEAD_SIDE_COUGH
	/// Ref used to easily retrieve the action used when removing the quirk from silicons
	var/datum/weakref/tele_action_ref

/datum/quirk/telepathic/add(client/client_source)
	if (iscarbon(quirk_holder))
		var/mob/living/carbon/human/human_holder = quirk_holder
		human_holder.dna.add_mutation(/datum/mutation/telepathy, MUTATION_SOURCE_QUIRK)
	else if(issilicon(quirk_holder))
		var/mob/living/silicon/robot_holder = quirk_holder
		var/datum/action/cooldown/spell/pointed/telepathy/tele_action = new

		tele_action.Grant(robot_holder)
		tele_action_ref = WEAKREF(tele_action)

/datum/quirk/telepathic/remove()
	var/datum/action/cooldown/spell/pointed/telepathy/tele_action = tele_action_ref?.resolve()
	if(isnull(tele_action))
		tele_action_ref = null
	if(iscarbon(quirk_holder))
		var/mob/living/carbon/human/human_holder = quirk_holder
		human_holder.dna.remove_mutation(/datum/mutation/telepathy, MUTATION_SOURCE_QUIRK)
	else if(issilicon(quirk_holder) && !isnull(tele_action))
		QDEL_NULL(tele_action)
		tele_action_ref = null

/datum/emote/living/telepathy_reply
	key = "treply"
	key_third_person = "treply"
	cooldown = 4 SECONDS

/datum/emote/living/telepathy_reply/run_emote(mob/living/user, params, type_override, intentional)
	if (ishuman(user) && intentional)
		var/mob/living/carbon/human/human_user = user
		var/datum/mutation/telepathy/mutation = human_user.dna.get_mutation(/datum/mutation/telepathy)
		if (mutation)
			var/datum/action/cooldown/spell/pointed/telepathy/tele_action = locate() in user.actions
			// just straight up call the right-click action as is
			if (tele_action)
				tele_action.Trigger(TRIGGER_SECONDARY_ACTION)
				tele_action.blocked = FALSE

	return ..()
