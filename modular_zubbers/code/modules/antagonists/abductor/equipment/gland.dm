/obj/item/organ/heart/gland/Start()
	active = 1

	owner?.mind?.add_antag_datum(/datum/antagonist/abductee)

	COOLDOWN_START(src, activation_cooldown, rand(cooldown_low, cooldown_high))


	if(!ownerCheck() || !active_mind_control)
		return
	to_chat(owner, span_userdanger("You feel the compulsion fade, and you <i>completely forget</i> about your previous orders."))
	owner.clear_alert("mind_control")
	active_mind_control = FALSE


/obj/item/organ/heart/gland/on_mob_remove(mob/living/carbon/gland_owner, special, movement_flags)
	. = ..()
	gland_owner?.mind?.remove_antag_datum(/datum/antagonist/abductee)
