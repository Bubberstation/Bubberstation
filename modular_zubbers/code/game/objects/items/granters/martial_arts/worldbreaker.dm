/obj/item/book/granter/martial/worldbreaker
	martial = /datum/martial_art/worldbreaker
	name = "prototype worldbreaker compound"
	martial_name = "Worldbreaker"
	desc = "A foul concoction made by reverse engineering chemicals compounds found in an ancient Vxtrin military outpost."
	greet = span_sciradio("You feel weirdly good, good enough to shake the world to it's very core. \
	Your plates feel like they are growing past their normal limits. The protection will come in handy, but it will eventually slow you down.\
	You can think about all the things you are now capable of by using the Worldbreaker tab.")
	icon = 'icons/obj/drinks.dmi'
	icon_state = "flaming_moe"
	remarks = list(
		"Is... it bubbling?",
		"What's that gross residue on the sides of the vial?",
		"Am I really considering drinking this?",
		"I'm pretty sure I just saw a dead fly dissolve in it.",
		"This is temporary, right?",
		"I sure hope someone's tested this.")
	book_sounds = list('sound/items/drink.ogg') //it's a drink, not a book

/obj/item/book/granter/martial/worldbreaker/on_reading_start(mob/user)
	to_chat(user, span_notice("You raise \the [src] to your lips and take a sip..."))

/obj/item/book/granter/martial/worldbreaker/can_learn(mob/user)
	if(!isipc(user))
		to_chat(user, span_warning("There is no way in hell I'm drinking this."))
		return FALSE
	return ..()

/obj/item/book/granter/martial/worldbreaker/on_reading_finished(mob/living/carbon/user)
	..()
	if(!uses)
		var/obj/item/reagent_containers/glass/bottle/vial/empty = new(get_turf(user))
		qdel(src)
		user.put_in_active_hand(empty)
