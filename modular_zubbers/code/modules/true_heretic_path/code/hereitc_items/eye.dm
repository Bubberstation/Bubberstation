/obj/item/watching_eye
	name = "watching eye"
	desc = "A strange gem encased in an even stranger metal. Looks like it could shatter when thrown."

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_misc.dmi'
	icon_state = "watching_eye"

	var/active = FALSE

	COOLDOWN_DECLARE(reactivation_cooldown)

/obj/item/watching_eye/examine(mob/user)
	. = ..()

	if(IS_HERETIC(user))
		. += span_velvet("This forever watching eye deals toxin damage to any non-heretic it sees, as long as it is on the ground. It is currently [active ? "on" : "off, and can be activated in hand to turn on"].")

	if(active)
		. += span_warning("The eye watches you [IS_HERETIC(user) ? "carefully" : "menacingly"]...")

/obj/item/watching_eye/attack_self(mob/user)

	/*
	if(!IS_HERETIC(user))
		to_chat(user,span_warning("You don't know how to use [src]!"))
		return
	*/

	if(!COOLDOWN_FINISHED(src,reactivation_cooldown))
		to_chat(user,span_warning("[src] is not ready to be deployed yet!"))
		return

	if(loc != user)
		return

	if(!user.dropItemToGround(src))
		return

	user.visible_message(
		span_warning("[src] vibrates menacingly as [user] places it on [src.loc]..."),
		span_notice("[src] vibrates menacingly as you place it on [src.loc].")
	)

	update_aura()

	return TRUE

/obj/item/watching_eye/Initialize()

	ADD_TRAIT(src, TRAIT_INNATELY_FANTASTICAL_ITEM,EXILE_UNIQUE)

	. = ..()

	AddComponent(/datum/component/damage_aura,\
		range = 5, \
		requires_visibility = TRUE, \
		toxin_damage = 1, \
		immune_factions = list(FACTION_HERETIC), \
		damage_message = span_boldwarning("Your body wilts and withers as it comes near [src]'s aura."),\
		message_probability = 7, \
		current_owner = src, \
	)

	update_aura()

/obj/item/watching_eye/proc/update_aura()

	SIGNAL_HANDLER

	var/datum/component/damage_aura/aura = GetComponent(/datum/component/damage_aura)
	if(!aura)
		return

	if(isturf(src.loc))
		START_PROCESSING(SSaura, aura)
		RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(update_aura))
		icon_state = "watching_eye_open"
		active = TRUE
	else
		STOP_PROCESSING(SSaura, aura)
		UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
		icon_state = "watching_eye_closed"
		active = FALSE

	COOLDOWN_START(src, reactivation_cooldown, 2 SECONDS) //Prevents spam.
