/datum/objective/heretic_wildcard
	abstract_type = /datum/objective/heretic_wildcard
	var/list/datum/heretic_knowledge/knowledge_to_gain = list()
	var/list/datum/weakref/tracked // lazylist
	var/finish_text = "If youre seeing this the coder made an oopsie!"
	var/knowledge_per_progress
	var/progress = 0
	var/max_progress = INFINITY

/datum/objective/heretic_wildcard/proc/apply_to(datum/antagonist/heretic/our_heretic)
	for (var/datum/heretic_knowledge/iter_knowledge as anything in knowledge_to_gain)
		our_heretic.gain_knowledge(iter_knowledge, HERETIC_KNOWLEDGE_SHOP)
		our_heretic.heretic_shops[HERETIC_KNOWLEDGE_SHOP] -= iter_knowledge
		to_chat(our_heretic.owner, span_boldnotice("To accomplish your objectives, you have been given the [iter_knowledge::name] knowledge node for free."))
		our_heretic.update_data_for_all_viewers()

/datum/objective/heretic_wildcard/proc/increment_progress(datum/antagonist/heretic/our_heretic, atom/target)
	if (is_finished())
		return

	if (!isnull(target))
		if (tracked != null)
			for (var/datum/weakref/iter_weakref in tracked)
				if (iter_weakref.resolve() == target)
					return
		else
			var/datum/weakref/new_ref = WEAKREF(tracked)
			LAZYADD(new_ref, target)
	give_knowledge_for_progress(our_heretic)
	progress++
	if (is_finished())
		completed = TRUE
		do_finished_text_and_flavor(our_heretic)

/datum/objective/heretic_wildcard/proc/give_knowledge_for_progress(datum/antagonist/heretic/our_heretic)
	our_heretic.adjust_knowledge_points(knowledge_per_progress)

/datum/objective/heretic_wildcard/proc/is_finished(datum/antagonist/heretic/our_heretic)
	return (progress >= max_progress)

/datum/objective/heretic_wildcard/proc/do_finished_text_and_flavor(datum/antagonist/heretic/our_heretic)
	to_chat(our_heretic.owner, span_hypnophrase(finish_text))
	to_chat(our_heretic.owner, span_warning("You can no longer obtain knowledge points from your [name] objective, as it has been completed."))
	SEND_SOUND(our_heretic.owner.current, sound('sound/effects/magic/knock.ogg'))
