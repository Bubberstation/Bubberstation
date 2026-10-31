#define MODE_DEATH "death"
#define MODE_LIFE "life"
#define MODE_TIMECUTTER "timecutter"


/obj/item/reaping_scythe
	name = "reaping scythe"
	desc = "Death's choice of implement."
	force = 35
	throwforce = 35
	armour_penetration = 200
	demolition_mod = 3
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK 
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "scythe_death"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/64x64_righthand.dmi'
	inhand_icon_state = "scythe_death"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "scythe"
	base_icon_state = "scythe"
	icon_angle = 45
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("reaps", "judges", "rends")
	attack_verb_simple = list("reap", "judge", "rend")

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	obj_flags = UNIQUE_RENAME

	//What mode are we set to?
	var/essence = MODE_DEATH
	//Are we using our effect?
	var/effect

/obj/item/reaping_scythe/attack_self(mob/user)
	switch(essence)
		if(MODE_DEATH)
			essence = MODE_LIFE
			icon_state = "[base_icon_state]_life"
			inhand_icon_state = icon_state
		if(MODE_LIFE)
			essence = MODE_TIMECUTTER
			icon_state = "[base_icon_state]_timecutter"
			inhand_icon_state = icon_state
		if(MODE_TIMECUTTER)
			essence = MODE_DEATH
			icon_state = "[base_icon_state]_death"
			inhand_icon_state = icon_state

	user.balloon_alert(user, "[essence]")
	update_appearance()

/obj/item/reaping_scythe/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return TRUE

	if(!isliving(target))
		return FALSE

	var/slicing = LAZYACCESS(modifiers, RIGHT_CLICK)
	if(slicing)
		return FALSE

	effect = TRUE
	scythe_effect(target, user)
	return TRUE

/obj/item/reaping_scythe/proc/scythe_effect(mob/living/target, mob/living/user)
	if(!effect == TRUE)
		return

	if(essence == MODE_DEATH)
		user.do_attack_animation(target)
		to_chat(target, span_danger("You feel a silent blade cut through you, followed by an eerie stillness. Your life essence fades as your soul is rent from your body, and harvested by the scythe."))
		target.death()

	if(essence == MODE_LIFE)
		user.do_attack_animation(target)
		target.revive(ADMIN_HEAL_ALL, force_grab_ghost = TRUE)
		to_chat(target, span_notice("You feel something cut through you, but you bear no wounds. What life essence has faded from you returns as your body and soul are restored."))

	if(essence == MODE_TIMECUTTER)
		user.do_attack_animation(target)
		to_chat(target, span_danger("You feel something cut through you. Your body and essence halts as your ears are doused in hollow ringing; You are being slowly severed from the timeline."))
		new /obj/structure/chrono_field(target.loc, target)

	effect = FALSE

/obj/item/reaping_scythe/add_item_context(datum/source, list/context, atom/target, mob/living/user)
	if (isturf(target))
		return NONE
	if (isobj(target))
		context[SCREENTIP_CONTEXT_LMB] = "Attack"
	else
		if (essence == MODE_DEATH)
			context[SCREENTIP_CONTEXT_RMB] = "Slash"

			if (user.combat_mode)
				context[SCREENTIP_CONTEXT_LMB] = "Reap"
			else
				context[SCREENTIP_CONTEXT_LMB] = "Reap"
		if (essence == MODE_LIFE)
			context[SCREENTIP_CONTEXT_RMB] = "Slash"

			if (user.combat_mode)
				context[SCREENTIP_CONTEXT_LMB] = "Restore"
			else
				context[SCREENTIP_CONTEXT_LMB] = "Restore"
		if (essence == MODE_TIMECUTTER)
			context[SCREENTIP_CONTEXT_RMB] = "Slash"

			if (user.combat_mode)
				context[SCREENTIP_CONTEXT_LMB] = "Eradicate"
			else
				context[SCREENTIP_CONTEXT_LMB] = "Eradicate"

	return CONTEXTUAL_SCREENTIP_SET

/obj/item/reaping_scythe/chrono
	name = "chrono scythe"
	desc = "A refined tool for chrono agents."
	icon = 'modular_zubbers/icons/obj/weapons/melee.dmi'
	icon_state = "chrono_death"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/64x64_righthand.dmi'
	inhand_icon_state = "chrono_death"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "chrono"
	base_icon_state = "chrono"

#undef MODE_DEATH
#undef MODE_LIFE
#undef MODE_TIMECUTTER
