/obj/item/book/granter/martial/flyingfang
	martial = /datum/martial_art/flyingfang
	name = "strange tablet"
	martial_name = "Flying Fang"
	desc = "A tablet with strange pictograms that appear to detail some kind of fighting technique."
	force = 10
	greet = "<span class='sciradio'>You have learned the ancient martial art of Flying Fang! Your unarmed attacks have become somewhat more effective,  \
	and you are more resistant to damage and stun-based weaponry. However, you are also unable to use any ranged weaponry or armor. You can learn more about your newfound art by using the Recall Teachings verb in the Flying Fang tab.</span>"
	icon = 'icons/obj/library.dmi'
	icon_state = "stone_tablet"
	remarks = list("Feasting on the insides of your enemies...", "Some of these techniques look a bit dizzying...", "Not like I need armor anyways...", "Don't get shot, whatever that means...")

/obj/item/book/granter/martial/flyingfang/can_learn(mob/user)
	if(!islizard(user))
		to_chat(user, span_warning("You can't tell if this is some poorly written fanfiction or an actual guide to something."))
		return FALSE
	return ..()

/obj/item/book/granter/martial/flyingfang/on_reading_finished(mob/living/carbon/user)
	..()
	if(!uses)
		desc = "It's completely blank."
		name = "blank tablet"
		icon_state = "stone_tablet_blank"
