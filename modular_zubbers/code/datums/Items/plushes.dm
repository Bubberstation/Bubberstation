/obj/item/toy/plush/attack_self(mob/user)
	. = ..()
	if(stuffed || grenade)
		to_chat(user, span_notice("You pet [src]. D'awww."))
		if(grenade && !grenade.active)
			user.log_message("activated a hidden grenade in [src].", LOG_VICTIM)
			grenade.arm_grenade(user, msg = FALSE, volume = 10)
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_notice("You feel your heart warm up... You don't feel so alone."))

	else
		to_chat(user, span_notice("You try to pet [src], but it has no stuffing. Aww..."))
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_warning("You remember that even stitched companions can't stop the solitude building up inside your heart..."))
