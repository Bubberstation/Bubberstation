/obj/item/slimecross/regenerative/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return
	var/mob/living/H = interacting_with
	if(H.stat == DEAD)
		to_chat(user, span_warning("[src] will not work on the dead!"))
		return ITEM_INTERACT_BLOCKING
	if(H != user)
		user.visible_message(span_notice("[user] crushes [src] over [H], the milky goo quickly regenerating all of [H.p_their()] injuries!"),
			span_notice("You squeeze [src], and it bursts over [H], the milky goo regenerating [H.p_their()] injuries."))
	else
		user.visible_message(span_notice("[user] crushes [src] over [user.p_them()]self, the milky goo quickly regenerating all of [user.p_their()] injuries!"),
			span_notice("You squeeze [src], and it bursts in your hand, splashing you with milky goo which quickly regenerates your injuries!"))
	core_effect_before(H, user)
	user.do_attack_animation(interacting_with)
	H.revive(HEAL_ALL)
	core_effect(H, user)
	playsound(H, 'sound/effects/splat.ogg', 40, TRUE)
	qdel(src)
	return ITEM_INTERACT_SUCCESS