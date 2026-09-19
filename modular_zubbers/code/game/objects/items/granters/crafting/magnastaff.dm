/obj/item/book/granter/crafting_recipe/stunstaff_prime
	name = "diary of a lonely warden"
	desc = "A relatively clean diary. It reeks of pepperspray and copper."
	crafting_recipe_types = list(
		/datum/crafting_recipe/stunstaff_prime
	)
	icon_state = "book1"
	remarks = list(
		"It gets pretty lonely sitting in the brig all shift, doesn't it...?",
		"With all that time on time on your hands, you're bound to come up with something.",
		"A more effective way to apply police brutality...",
		"Overcharge the capacitors... apply a titanium reinforcement...",
		"Why not just use a gun instead?",
		"Ah yes, jam the staff right into an APC. What could go wrong?",
		"It recharges HOW fast between attacks?",
	)

/obj/item/book/granter/crafting_recipe/stunstaff_prime/recoil(mob/living/user)
	to_chat(user, span_warning("The book turns to dust in your hands."))
	qdel(src)
