/obj/item/melee/breaching_hammer
	name = "D-4 tactical hammer"
	desc = "A metallic-plastic composite breaching hammer, looks like a whack with this would severly harm or tire someone."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	icon_state = "peacekeeper_hammer"
	inhand_icon_state = "peacekeeper_hammer"
	worn_icon_state = "classic_baton"
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 15
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("whacks","breaches","bulldozes","flings","thwachs")
	attack_verb_simple = list("breach","hammer","whack","slap","thwach","fling")
	obj_flags = 0

	/// Delay between door hits
	var/breaching_delay = 2 SECONDS
	/// The door we aim to breach
	/// If we are in the process of breaching
	var/breaching = FALSE
	/// The person breaching , initially us but we receive a signal with another one
	var/breacher = null
	/// the amount that the force is multiplied by , that is then applied as damage to the door.
	var/breaching_multipler = 2.5

/obj/item/melee/breaching_hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneecapping)


/// Removes any form of tracking from the user and the item , make sure to call it on he proper item
/obj/item/melee/breaching_hammer/proc/remove_track(mob/living/carbon/human/user)
	REMOVE_TRAIT(user, TRAIT_AIRLOCK_SHOCKIMMUNE, REF(src))
	breaching = FALSE
	user.balloon_alert(user, "you put your hammer down!")
	breacher = null

/obj/item/melee/breaching_hammer/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(target, /obj/structure/table))
		var/obj/smash = target
		smash.deconstruct(FALSE)

	else if(istype(target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/opening = target
		ADD_TRAIT(user, TRAIT_AIRLOCK_SHOCKIMMUNE, REF(src))
		try_breaching(opening, user)

/obj/item/melee/breaching_hammer/proc/try_breaching(obj/machinery/door/airlock/target, mob/living/carbon/human/user)
	if(breaching || (user == breacher))
		return FALSE
	if(!(user.Adjacent(target)))
		remove_track(user)
		return NONE
	breaching = TRUE
	breacher = user
	INVOKE_ASYNC(src, TYPE_PROC_REF(/obj/item/melee/breaching_hammer, breaching_loop), user, target)
	user.balloon_alert(user, "you begin breaching the door!")

/// Keeps looping until the door is breached or conditions fail
/obj/item/melee/breaching_hammer/proc/breaching_loop(mob/living/user, obj/target)
	while(!user.stat && target && user.Adjacent(target) && target.get_integrity() >= 1)
		if(!do_after(user, breaching_delay, target))
			break
		if(QDELETED(target))
			break
		target.take_damage(force * breaching_multipler)
		playsound(target, 'sound/items/weapons/sonic_jackhammer.ogg', 70)
		target.visible_message(span_warning("[target] begins to cave in and deform with each blow from [src]!"), span_warning("We are breaching [target]."), \
		span_hear("you hear a thud of metal against metal."))
		user.do_attack_animation(target, used_item = src)
	remove_track(user)
