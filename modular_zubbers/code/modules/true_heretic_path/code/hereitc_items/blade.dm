/obj/item/melee/sickly_blade/exile
	name = "\improper cold iron dagger"
	desc = "A small dagger, sharp and cold to the touch. There is nothing more brutal than a simple blade wielded with robustness."
	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	icon_state = "dagger"
	inhand_icon_state = "dagger"
	after_use_message = "The Exile hears your call..."








/obj/item/melee/sickly_blade/exile/upgrade
	name = "\improper elder's insanity sword"
	desc = "A dark plasma-edged sword that flickers with strange energy. Just looking at it makes you feel uneasy."
	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_weapons_inventory.dmi'
	icon_state = "sword"
	inhand_icon_state = "sword"
	after_use_message = "The Exile hears your call..."

	force = 24 //Previously 20
	throwforce = 5 //Previously 10
	wound_bonus = 10 //Previously 5
	bare_wound_bonus = 10 //Previously 15
	toolspeed = 0.5 //Previously 0.375
	demolition_mod = 1.2 //Previously 0.8
	armour_penetration = 50


/datum/movespeed_modifier/sanity

/obj/item/melee/sickly_blade/examine(mob/user)
	. = ..()
	if(!check_usability(user))
		return
	. += span_velvet("Or can you?")

/obj/item/melee/sickly_blade/exile/upgrade/afterattack(atom/target, mob/user, click_parameters)

	user.visible_message(
		span_warning("[user] attempts to shatter the blade, but the blade shatters their mind instead!"),
		span_danger("You attempt to shatter the blade, but the blade shatters your mind instead!")
	)


	set_sanity(SANITY_INSANE)

	return



/obj/item/melee/sickly_blade/exile/upgrade/check_usability(mob/living/user)
	return TRUE