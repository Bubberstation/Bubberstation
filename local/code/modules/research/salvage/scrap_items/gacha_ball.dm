/obj/item/scrap/gacha_ball
	icon_state = "gacha_ball"
	name = "gacha ball"
	desc = "No refunds."
	pickup_sound = 'sound/items/handling/materials/plastic_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/plastic_drop.ogg'

/obj/item/scrap/micro_generator/randomize_credit_cost()
	return rand(1, 80)

/obj/item/scrap/gacha_ball/attack_self(mob/user, modifiers)
	. = ..()
	moveToNullspace()
	var/obj/item/toy/plush/skyrat/chosen_plush = pick(subtypesof(/obj/item/toy/plush/skyrat))
	var/obj/item/thing = new chosen_plush(get_turf(user))
	user.visible_message(span_notice("[user] pops open \the [src], finding \a [thing] inside!"))
	user.put_in_hands(thing)
	thing.add_fingerprint(user)
	playsound(thing, 'sound/items/handling/materials/plastic_drop.ogg', 50, TRUE)

	qdel(src)
