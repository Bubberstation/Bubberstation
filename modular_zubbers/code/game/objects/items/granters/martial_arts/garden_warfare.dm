/obj/item/book/granter/martial/garden_warfare
	martial = /datum/martial_art/gardern_warfare
	name = "vegetable parchment"
	martial_name = "Garden Warfare"
	desc = "A scroll, filled with a ton of text. Looks like it says something about combat and... plants?"
	greet = "<span class='sciradio'>You know the martial art of Garden Warfare! Now you control your body better, then other phytosians do, allowing you to extend vines from your body and impale people with splinters. \
	You can check what combos can you do, and their effect by using Remember the basics verb in Garden Warfare tab.</span>"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	remarks = list("I didn't know that my body grows sprinklers...", "I am able to snatch people with vines? Interesting.", "Wow, strangling people is brutal.")   ///Kill me please for this cringe // I hate you

/obj/item/book/granter/martial/garden_warfare/can_learn(mob/user)
	if(!ispodperson(user))
		to_chat(user, span_warning("You see that this scroll says something about natural abilitites of podpeople, but, unfortunately, you are not one of them."))
		return FALSE
	return ..()

/obj/item/book/granter/martial/garden_warfare/on_reading_finished(mob/living/carbon/user)
	..()
	if(!uses)
		desc = "It's completely blank."
