/obj/item/book/manual/wiki/security_space_law
	name = "Corporate Regulations"
	desc = "A set of Nanotrasen regulations for keeping law, order, and procedure followed within their space stations."
	starting_title = "Corporate Regulations"
	page_link = "Corporate_Regulations"

/obj/item/book/manual/wiki/security_space_law/attack_self(mob/user) // Was in /tg/ folder, moved it here, made it 100% chance to learn language since you can spam it inhand anyhow. Saves us all from carpal tunnel.
	if(user.can_read(src) && !user.has_language(/datum/language/legalese, SPOKEN_LANGUAGE))
		to_chat(user, span_notice("As you inhale the book's contents, you feel more sophisticated. After reading Space Law just once, you feel like you are an expert in pretending you know Latin. You can now speak Legalese."))
		user.grant_language(/datum/language/legalese, SPOKEN_LANGUAGE) //can speak but not understand
	else
		.=..()


/obj/item/book/manual/wiki/security_space_law/weighted
	name = "Corporate Regulations: Collector's Edition"
	desc = "A set of Nanotrasen guidelines for keeping law and order on their space stations. This one's quite heavy due to its extra pages and metal-plated cover."
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "SpaceLawWeighted"
	force = 13
	throwforce = 13
	attack_verb_continuous = list("educates", "reprimands", "prosecutes", "teaches a lesson to")
	attack_verb_simple = list("educate", "reprimand", "prosecute", "remind","teach a lesson to")

/obj/item/book/manual/wiki/security_space_law/weighted/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!isliving(target))
		return

	var/mob/living/living_target = target

	if(user == living_target)
		return

	if(living_target.stat == DEAD)
		return

	if(prob(10))
		living_target.grant_language(/datum/language/legalese, SPOKEN_LANGUAGE) //IMMA TEACH YOU A LESSON
