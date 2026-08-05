/datum/quirk/robot_limb_detach
	name = "Cybernetic Limb Mounts"
	desc = "You are able to detach and reattach any installed robotic limbs with very little effort, as long as they're in good condition. Right Click yourself while targeting a limb to remove it."
	gain_text = span_notice("Internal sensors report limb disengagement protocols are ready and waiting.")
	lose_text = span_notice("ERROR: LIMB DISENGAGEMENT PROTOCOLS OFFLINE.")
	medical_record_text = "Patient bears quick-attach and release limb joint cybernetics."
	value = 4
	mob_trait = TRAIT_ROBOTIC_LIMBATTACHMENT
	icon = FA_ICON_HANDSHAKE_SIMPLE_SLASH
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/robot_limb_detach/add(client/client_source)
	quirk_holder.AddElement(/datum/element/robot_self_amputation)

/datum/quirk/robot_limb_detach/remove()
	quirk_holder.RemoveElement(/datum/element/robot_self_amputation)

/// Give to a human to allow them to self amputate their mechanical limbs
/datum/element/robot_self_amputation

/datum/element/robot_self_amputation/Attach(datum/target)
	. = ..()

	if(!iscarbon(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_MOB_ATTACK_HAND, PROC_REF(pre_self_amputate))


/datum/element/robot_self_amputation/Detach(datum/source, ...)
	UnregisterSignal(source, COMSIG_MOB_ATTACK_HAND)
	. = ..()

/datum/element/robot_self_amputation/proc/pre_self_amputate(mob/living/carbon/amputee, mob/amputee_again, mob/living/target, datum/martial_art/attacker_style, modifiers)
	SIGNAL_HANDLER

	if(target != amputee)
		return

	if(!LAZYACCESS(modifiers, RIGHT_CLICK))
		return

	var/obj/item/bodypart/targeted_limb = amputee.get_bodypart(check_zone(amputee.zone_selected))

	if(!targeted_limb)
		return

	// Chest removal Fail
	if (targeted_limb.body_zone == BODY_ZONE_CHEST)
		return

	// Head removal fail for people who can't live without one
	if (targeted_limb.body_zone == BODY_ZONE_HEAD && !issynthetic(amputee))
		return

	// Organic Limb Fail
	if (IS_ORGANIC_LIMB(targeted_limb))
		return

	if(HAS_TRAIT(amputee, TRAIT_NODISMEMBER))
		to_chat(amputee, span_warning("ERROR: LIMB DISENGAGEMENT PROTOCOLS OFFLINE. Seek out a maintenance technician."))
		return

	if (amputee.handcuffed)
		to_chat(amputee, span_alert("You can't get a good enough grip with your hands bound."))
		return

	if (length(targeted_limb.wounds) >= 1)
		amputee.balloon_alert(amputee, "can't detach wounded limbs!")
		playsound(amputee, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	INVOKE_ASYNC(src, PROC_REF(self_amputate), amputee, targeted_limb)

/datum/element/robot_self_amputation/proc/self_amputate(mob/living/carbon/amputee, obj/item/bodypart/targeted_limb)
	amputee.balloon_alert(amputee, "detaching limb...")
	playsound(amputee, 'sound/items/tools/rped.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	amputee.visible_message(span_notice("[amputee] shuffles [amputee.p_their()] [targeted_limb.name] forward, actuators hissing and whirring as [amputee.p_they()] disengage[amputee.p_s()] the limb from its mount..."))

	if(!do_after(amputee, 10 SECONDS))
		amputee.balloon_alert(amputee, "interrupted!")
		return
	if(amputee.handcuffed) //Prevents removing your arms if you get handcuffed part way through
		return

	playsound(amputee, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	amputee.visible_message(span_notice("With a gentle twist, [amputee] finally prises [amputee.p_their()] [targeted_limb.name] free from its socket."))
	targeted_limb.drop_limb()
	amputee.put_in_hands(targeted_limb)
	amputee.balloon_alert(amputee, "limb detached!")
	if(prob(5))
		playsound(amputee, 'sound/items/champagne_pop.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	else
		playsound(amputee, 'sound/items/deconstruct.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
