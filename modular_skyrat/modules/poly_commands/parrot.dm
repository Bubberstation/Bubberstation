/*
* Parrot commands: Made modular
*/

/mob/living/simple_animal/parrot
	/// Whether the parrot is on a human's shoulder or not
	var/buckled_to_human = FALSE

/mob/living/simple_animal/parrot/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq, list/spans, list/message_mods = list(), message_range)
	. = ..()
	if(check_command(message, speaker))
		return
	if(speaker != src && prob(50)) //Dont imitate ourselves
		if(!radio_freq || prob(10))
			if(speech_buffer.len >= 500)
				speech_buffer -= pick(speech_buffer)
			speech_buffer |= html_decode(raw_message)
	if(speaker == src && !client) //If a parrot squawks in the woods and no one is around to hear it, does it make a sound? This code says yes!
		return message

/mob/living/simple_animal/parrot/proc/perch_on_human(mob/living/carbon/human/human_target)
	if(!human_target)
		return
	forceMove(get_turf(human_target))
	if(human_target.buckle_mob(src, TRUE))
		pixel_y = 9
		pixel_x = pick(-8,8) //pick left or right shoulder
		icon_state = icon_sit
		parrot_state = PARROT_PERCH
		buckled_to_human = TRUE
		to_chat(src, span_notice("You sit on [human_target]'s shoulder."))

/*
* Parrot commands: new code
*/

/mob/living/simple_animal/parrot/proc/check_command()
	return FALSE // Simply return false for non-Poly parrots

/mob/living/simple_animal/parrot/poly/check_command(message, speaker)
	var/mob/living/carbon/human/human_target = speaker
	if(!istype(human_target))
		return FALSE
	if(!(human_target.mind?.assigned_role.title == JOB_CHIEF_ENGINEER))
		return FALSE
	if(!(findtext(message, "poly")))
		return FALSE
	if(findtext(message, "perch") || findtext(message, "up"))
		command_perch(speaker)
		return TRUE
	else if(findtext(message, "off") || findtext(message, "down"))
		command_hop_off(speaker)
		return TRUE
	else
		return FALSE

/mob/living/simple_animal/parrot/poly/proc/command_perch(mob/living/carbon/human/human_target)
	if (!buckled)
		buckled_to_human = FALSE
	if(human_target.buckled_mobs?.len >= human_target.max_buckled_mobs)
		return
	if(buckled_to_human)
		emote("me", EMOTE_VISIBLE, "gives [human_target] a confused look, squawking softly.")
		return
	if(get_dist(src, human_target) > 1 || buckled) // Only adjacent
		emote("me", EMOTE_VISIBLE, "tilts their head at [human_target], before bawking loudly and staying put.")
		return
	emote("me", EMOTE_VISIBLE, "obediently hops up onto [human_target]'s shoulder, spreading their wings for a moment before settling down.")
	perch_on_human(human_target)

/mob/living/simple_animal/parrot/poly/proc/command_hop_off(mob/living/carbon/human/human_target)
	if (!buckled)
		buckled_to_human = FALSE
	if(!buckled_to_human || !buckled)
		emote("me", EMOTE_VISIBLE, "gives [human_target] a confused look, squawking softly.")
		return

	icon_state = icon_living
	parrot_state = PARROT_WANDER
	if(buckled)
		to_chat(src, span_notice("You are no longer sitting on [buckled]."))
		buckled.unbuckle_mob(src, TRUE)
		emote("me", EMOTE_VISIBLE, "squawks and hops off of [buckled], flying away.")
	buckled = null
	buckled_to_human = FALSE
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)
