/datum/quirk/robot_limb_detach
	name = "Cybernetic Limb Mounts"
	desc = "You are able to detach and reattach any installed robotic limbs with very little effort, as long as they're in good condition. (Right click on self to use)"
	gain_text = span_notice("Internal sensors report limb disengagement protocols are ready and waiting.")
	lose_text = span_notice("ERROR: LIMB DISENGAGEMENT PROTOCOLS OFFLINE.")
	medical_record_text = "Patient bears quick-attach and release limb joint cybernetics."
	value = 1
	mob_trait = TRAIT_ROBOTIC_LIMBATTACHMENT
	icon = FA_ICON_HANDSHAKE_SIMPLE_SLASH
	quirk_flags = QUIRK_HUMAN_ONLY
	/// The action we add with this quirk in add(), used for easy deletion later
	var/datum/action/cooldown/spell/added_action

/datum/quirk/robot_limb_detach/add(client/client_source)
	quirk_holder.AddElement(/datum/element/robot_self_amputation)
	//var/mob/living/carbon/human/human_holder = quirk_holder
	//var/datum/action/cooldown/spell/robot_self_amputation/limb_action = new /datum/action/cooldown/spell/robot_self_amputation()
	//limb_action.Grant(human_holder)
	//added_action = limb_action

/datum/quirk/robot_limb_detach/remove()
	quirk_holder.RemoveElement(/datum/element/robot_self_amputation)
	//QDEL_NULL(added_action)

/**
/datum/action/cooldown/spell/robot_self_amputation
	name = "Detach a robotic limb"
	desc = "Disengage one of your robotic limbs from your cybernetic mounts. Requires you to not be restrained or otherwise under duress. Will not function on wounded limbs - tend to them first."
	button_icon_state = "autotomy"

	cooldown_time = 20 SECONDS
	spell_requirements = NONE
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_HANDS_BLOCKED | AB_CHECK_INCAPACITATED

/datum/action/cooldown/spell/robot_self_amputation/is_valid_target(atom/cast_on)
	return ishuman(cast_on)

/datum/action/cooldown/spell/robot_self_amputation/cast(mob/living/carbon/human/cast_on)
	. = ..()

	if(HAS_TRAIT(cast_on, TRAIT_NODISMEMBER))
		to_chat(cast_on, span_warning("ERROR: LIMB DISENGAGEMENT PROTOCOLS OFFLINE. Seek out a maintenance technician."))
		return

	var/list/exclusions = list()
	exclusions += BODY_ZONE_CHEST
	if (!issynthetic(cast_on))
		exclusions += BODY_ZONE_HEAD // no decapitating yourself unless you're a synthetic, who keep their brains in their chest

	var/list/robot_parts = list()
	for (var/obj/item/bodypart/possible_part as anything in cast_on.bodyparts)
		if ((possible_part.bodytype & BODYTYPE_ROBOTIC) && !(possible_part.body_zone in exclusions)) //only robot limbs and only if they're not crucial to our like, ongoing life, you know?
			robot_parts += possible_part

	if (!length(robot_parts))
		to_chat(cast_on, "ERROR: Limb disengagement protocols report no compatible cybernetics currently installed. Seek out a maintenance technician.")
		return

	var/obj/item/bodypart/limb_to_detach = tgui_input_list(cast_on, "Limb to detach", "Cybernetic Limb Detachment", sort_names(robot_parts))
	if (QDELETED(src) || QDELETED(cast_on) || QDELETED(limb_to_detach))
		return

	if (length(limb_to_detach.wounds) >= 1)
		cast_on.balloon_alert(cast_on, "can't detach wounded limbs!")
		playsound(cast_on, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	cast_on.balloon_alert(cast_on, "detaching limb...")
	playsound(cast_on, 'sound/items/tools/rped.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	cast_on.visible_message(span_notice("[cast_on] shuffles [cast_on.p_their()] [limb_to_detach.name] forward, actuators hissing and whirring as [cast_on.p_they()] disengage[cast_on.p_s()] the limb from its mount..."))

	if(do_after(cast_on, 10 SECONDS))
		cast_on.visible_message(span_notice("With a gentle twist, [cast_on] finally prises [cast_on.p_their()] [limb_to_detach.name] free from its socket."))
		limb_to_detach.drop_limb()
		cast_on.put_in_hands(limb_to_detach)
		cast_on.balloon_alert(cast_on, "limb detached!")
		if(prob(5))
			playsound(cast_on, 'sound/items/champagne_pop.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		else
			playsound(cast_on, 'sound/items/deconstruct.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	else
		cast_on.balloon_alert(cast_on, "interrupted!")
		playsound(cast_on, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
**/
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

	if(!do_after(amputee, 10 SECONDS, amputee))
		amputee.balloon_alert(amputee, "interrupted!")
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
