/obj/structure/flora/tree/pine/xmas/millionaire //not really a tree but the code is close enough
	icon = 'modular_zubbers/icons/obj/fluff/bonus.dmi'
	icon_state = "bonusnt"
	pixel_x = 0
	name = "bonus bag pile"
	desc = "A pile of bonus bags. Try to find one with your name on it!"
	var/gift_type = /obj/item/storage/box/papersack/millionaire_bonus
	var/unlimited = FALSE
	var/static/list/took_bonus

/obj/structure/flora/tree/pine/xmas/millionaire/Initialize(mapload)
	. = ..()
	if(!took_bonus)
		took_bonus = list()

/obj/structure/flora/tree/pine/xmas/millionaire/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!user.ckey)
		return

	if(took_bonus[user.ckey] && !unlimited)
		to_chat(user, span_warning("You already claimed your bonus!"))
		return
	to_chat(user, span_warning("After a bit of rummaging, you locate a bonus bag with your name on it!"))

	if(!unlimited)
		took_bonus[user.ckey] = TRUE

	var/obj/item/G = new gift_type(src)
	user.put_in_hands(G)
