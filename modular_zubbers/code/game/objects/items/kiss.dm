/obj/item/hand_item/kisser/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(user, TRAIT_HYPNO_KISS) || !iscarbon(interacting_with) || (user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		return ranged_interact_with_atom(interacting_with, user, modifiers)

	visible_message("[user] leans in for a kiss on the lips.")
	if(!do_after(user, 2 SECONDS, interacting_with))
		visible_message("[user] doesn't manage to lock lips with anyone.")
		return ITEM_INTERACT_BLOCKING

	var/mob/living/carbon/victim = interacting_with

	if(user)
		log_combat(user, victim, "[user] hypno kissed [victim]", src)
		user.visible_message(span_danger("[user] kisses [victim] on the lips! [victim] looks flushed!"), span_danger("You kiss [victim] on the lips!"))

	if(!victim.hypnosis_vulnerable())
		to_chat(victim, span_hypnophrase("That kiss made you feel oddly relaxed..."))
		victim.adjust_confusion_up_to(10 SECONDS, 20 SECONDS)
		victim.adjust_dizzy_up_to(20 SECONDS, 40 SECONDS)
		victim.adjust_drowsiness_up_to(20 SECONDS, 40 SECONDS)
		victim.adjust_pacifism(10 SECONDS)
	else
		victim.apply_status_effect(/datum/status_effect/trance, 20 SECONDS, TRUE)

