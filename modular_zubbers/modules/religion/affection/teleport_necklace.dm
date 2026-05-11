/obj/item/clothing/neck/affection_necklace
	name = "blessed necklace"
	desc = "A necklace imbued with divine affection."
	icon = 'modular_zubbers/icons/obj/religion_sects/affection/affection_items.dmi'
	icon_state = "affection_neck"
	worn_icon = 'icons/mob/clothing/neck.dmi'
	worn_icon_state = "beads"

	var/datum/weakref/chaplain_ref

/obj/item/clothing/neck/affection_necklace/equipped(mob/user, slot)
	. = ..()

	if(slot == ITEM_SLOT_NECK)
		user.AddComponent(/datum/component/necklace_summon_action, src)

/obj/item/clothing/neck/affection_necklace/dropped(mob/user)
	. = ..()
	qdel(user.GetComponent(/datum/component/necklace_summon_action))

/datum/component/necklace_summon_action
	var/obj/item/clothing/neck/affection_necklace/necklace
	var/datum/action/cooldown/spell/summon_chaplain/action

/datum/component/necklace_summon_action/Initialize(obj/item/clothing/neck/affection_necklace/new_necklace)
	. = ..()

	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	necklace = new_necklace

	action = new(parent)
	action.necklace = necklace
	action.Grant(parent)

/datum/component/necklace_summon_action/Destroy(force)
	QDEL_NULL(action)
	necklace = null
	return ..()

/datum/action/cooldown/spell/summon_chaplain
	name = "Summon Chaplain"
	desc = "Call the chaplain to your side, destroying the necklace in the process."
	button_icon_state = "summons"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

	var/obj/item/clothing/neck/affection_necklace/necklace
	var/turf/destination_turf

/datum/action/cooldown/spell/summon_chaplain/cast(mob/living/user)
	. = ..()
	if(!necklace)
		Remove(user)
		return
	if(!isfloorturf(get_turf(user)))
		return

	var/mob/living/chaplain = necklace.chaplain_ref?.resolve()

	if(!chaplain)
		to_chat(user, span_warning("The necklace has lost its blessing."))
		return

	destination_turf = get_turf(user)
	to_chat(user, span_notice("You call for aid!"))
	qdel(necklace)
	INVOKE_ASYNC(src, PROC_REF(prompt_chaplain), chaplain, user)

/datum/action/cooldown/spell/summon_chaplain/proc/prompt_chaplain(mob/living/chaplain, mob/living/user)
	if(chaplain.GetComponent(/datum/component/temporary_return))
		to_chat(user, span_warning("The chaplain is already answering another call."))
		return
	if(chaplain.incapacitated || chaplain.stat >= UNCONSCIOUS)
		to_chat(user, span_warning("But nobody came..."))
		return

	var/choice = tgui_alert(chaplain, "[user] calls for your comfort.", "Divine Summons", list("Accept", "Decline"), timeout = 30 SECONDS)

	if(choice != "Accept")
		if(user)
			to_chat(user, span_warning("But nobody came..."))
		return

	perform_summon(chaplain, user)

/datum/action/cooldown/spell/summon_chaplain/proc/perform_summon(mob/living/chaplain, mob/living/user)
	if(!chaplain || !user)
		return

	var/turf/original_turf = get_turf(chaplain)
	var/turf/target_turf = destination_turf

	do_teleport(chaplain, target_turf)
	playsound(chaplain, 'sound/effects/pray.ogg', 25, FALSE, -1)
	chaplain.visible_message(span_notice("A divine light descends as [chaplain] arrives!"))
	qdel(necklace)

	qdel(chaplain.GetComponent(/datum/component/temporary_return))
	chaplain.AddComponent(/datum/component/temporary_return, original_turf, target_turf)

/obj/effect/temp_visual/spotlight/short
	duration = 2 SECONDS

/datum/component/temporary_return
	var/turf/original_turf
	var/turf/summon_center

	var/datum/action/cooldown/spell/return_action/return_spell

/datum/component/temporary_return/Initialize(turf/original, turf/center)
	. = ..()

	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	original_turf = original
	summon_center = center

	return_spell = new(parent)
	return_spell.return_component = src
	return_spell.Grant(parent)

	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(check_distance))

/datum/component/temporary_return/proc/check_distance(mob/living/source)
	SIGNAL_HANDLER

	if(get_dist(get_turf(source), summon_center) > 3)
		return_to_origin()

/datum/component/temporary_return/proc/return_to_origin()
	var/mob/living/called = parent

	if(!called || !original_turf)
		qdel(src)
		return

	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	do_teleport(called, original_turf)

	return_spell.Remove()
	qdel(return_spell)
	qdel(src)

/datum/action/cooldown/spell/return_action
	name = "Return"
	desc = "Return to your original location."
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

	var/datum/component/temporary_return/return_component

/datum/action/cooldown/spell/return_action/cast(mob/living/user)
	. = ..()
	if(return_component)
		return_component.return_to_origin()



