/datum/element/dullahan_head

/datum/element/dullahan_head/Attach(datum/target)
	. = ..()
	RegisterSignal(target, COMSIG_MOB_ATTACK_HAND, PROC_REF(pre_detach))

/datum/element/dullahan_head/Detach(datum/source, ...)
	UnregisterSignal(source, COMSIG_MOB_ATTACK_HAND)
	. = ..()

/datum/element/dullahan_head/proc/pre_detach(mob/living/carbon/dullahan, mob/attacker, mob/living/target, datum/martial_art/attacker_style, modifiers)
	SIGNAL_HANDLER
	if(target != dullahan)
		return NONE
	if(!LAZYACCESS(modifiers, RIGHT_CLICK))
		return NONE
	var/obj/item/bodypart/targeted_limb = dullahan.get_bodypart(check_zone(dullahan.zone_selected))
	if(!targeted_limb)
		return NONE
	if(targeted_limb.body_zone != BODY_ZONE_HEAD)
		return NONE
	INVOKE_ASYNC(src, PROC_REF(detach_action), dullahan, targeted_limb)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/element/dullahan_head/proc/detach_action(mob/living/carbon/dullahan, obj/item/bodypart/targeted_limb)
	dullahan.balloon_alert(dullahan, "detaching head...")
	playsound(dullahan, 'sound/effects/magic/demon_consume.ogg', 45, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	dullahan.visible_message(span_notice("[dullahan] tightly grasps [dullahan.p_their()] head from the sides, flesh and sinew stretching audibly as [dullahan.p_they()] pulls it free from the neck..."))
	if(!do_after(dullahan, 5 SECONDS))
		dullahan.balloon_alert(dullahan, "interrupted!")
		return
	if(dullahan.handcuffed)
		dullahan.balloon_alert(dullahan, "can't detach while restrained!")
		return
	dullahan.visible_message(span_notice("With a gentle twist, [dullahan] finally pries [dullahan.p_their()] head free from its shoulders, with a sickening crack!"))
	targeted_limb.drop_limb()
	dullahan.put_in_hands(targeted_limb)
	dullahan.balloon_alert(dullahan, "head detached!")
	playsound(dullahan, 'sound/effects/wounds/crackandbleed.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
