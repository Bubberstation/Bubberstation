/obj/item/toy/plush/attack_self(mob/user)
	. = ..()
	if(stuffed)
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_notice("You feel your heart warm up... You don't feel so alone."))

	else
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_warning("You remember that even stitched companions can't stop the solitude building up inside your heart..."))
