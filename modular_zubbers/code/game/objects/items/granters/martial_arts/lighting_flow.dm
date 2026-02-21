/obj/item/book/granter/martial/lightning_flow
	name = "glowing parchment"
	desc = "A scroll made of unusual paper, written for ethereals looking to defend themselves while exploring the material world."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	martial = /datum/martial_art/lightning_flow
	martial_name = "Lightning Flow"
	greet = span_sciradio("You have learned lightning flow. Weave through your enemies like a bolt of lightning.\
		Use Focus in the Lightning Flow tab to remember the moves.")
	remarks = list(
		"I can't quite make out the signature.",
		"Hold on, it's just that easy?",
		"Why am I feeling nostalgia?",
		"The paper feels weirdly... tense?",
		"I had no clue this was possible here."
	)

/obj/item/book/granter/martial/lightning_flow/can_learn(mob/user)
	if(!isethereal(user))
		if(user.get_selected_language())
			to_chat(user, span_warning("This language looks nothing like [user.get_selected_language()]."))
		else
			to_chat(user, span_warning("I can't understand a word of this."))
		return FALSE
	return ..()

/obj/item/book/granter/martial/lightning_flow/on_reading_finished(mob/living/carbon/user)
	..()
	if(!uses)
		desc = "It's completely blank."
