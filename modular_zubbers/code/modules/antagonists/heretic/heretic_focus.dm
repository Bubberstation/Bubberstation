/// Makes an item a heretic focus, allowing heretics to cast forbidden school spells while it's worn
/datum/element/heretic_focus

/datum/element/heretic_focus/Attach(datum/target)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(target, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(target, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))

	var/obj/item/item_target = target
	if(ismob(item_target.loc))
		var/mob/wearer = item_target.loc
		if(IS_HERETIC(wearer) && (!item_target.slot_flags || wearer.get_item_by_slot(item_target.slot_flags) == item_target))
			ADD_TRAIT(wearer, TRAIT_ALLOW_HERETIC_CASTING, ELEMENT_TRAIT(target))

/datum/element/heretic_focus/Detach(obj/item/source)
	. = ..()
	UnregisterSignal(source, list(COMSIG_ATOM_EXAMINE, COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
	if(isliving(source.loc))
		REMOVE_TRAIT(source.loc, TRAIT_ALLOW_HERETIC_CASTING, ELEMENT_TRAIT(source))

/datum/element/heretic_focus/proc/on_examine(obj/item/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!IS_HERETIC(user))
		return

	examine_list += span_notice("Allows you to cast advanced acolyte spells when worn.")

/datum/element/heretic_focus/proc/on_equip(obj/item/source, mob/user, slot)
	SIGNAL_HANDLER

	if(!IS_HERETIC(user))
		return
	if(source.slot_flags && !(source.slot_flags & slot))
		return

	ADD_TRAIT(user, TRAIT_ALLOW_HERETIC_CASTING, ELEMENT_TRAIT(source))

/datum/element/heretic_focus/proc/on_drop(obj/item/source, mob/user)
	SIGNAL_HANDLER

	REMOVE_TRAIT(user, TRAIT_ALLOW_HERETIC_CASTING, ELEMENT_TRAIT(source))

/datum/antagonist/heretic/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/our_mob = mob_override || owner.current
	RegisterSignals(our_mob, list(COMSIG_MOB_BEFORE_SPELL_CAST, COMSIG_MOB_SPELL_ACTIVATED), PROC_REF(check_focus))

/datum/antagonist/heretic/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/our_mob = mob_override || owner.current
	UnregisterSignal(our_mob, list(COMSIG_MOB_BEFORE_SPELL_CAST, COMSIG_MOB_SPELL_ACTIVATED))

/datum/antagonist/heretic/proc/check_focus(mob/living/source, datum/action/cooldown/spell/spell)
	SIGNAL_HANDLER

	if(spell.school != SCHOOL_FORBIDDEN)
		return NONE
	if(HAS_TRAIT(source, TRAIT_ALLOW_HERETIC_CASTING) || ascended)
		return NONE

	source.balloon_alert(source, "you need a focus!")
	return SPELL_CANCEL_CAST

/datum/heretic_knowledge/amber_focus
	desc = "Sculpts an Amber Focus.<br>\
		A focus must be worn in order to cast more advanced spells."
	cost = 0
	is_starting_knowledge = TRUE
	drafting_tier = 0

/obj/item/clothing/neck/heretic_focus/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/heretic_focus)

/obj/item/clothing/neck/eldritch_amulet/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/heretic_focus)

/obj/item/clothing/head/hooded/cult_hoodie/eldritch/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/heretic_focus)

/obj/item/melee/cultblade/haunted/Initialize(mapload, mob/soul_to_bind, mob/awakener, do_bind = TRUE)
	. = ..()
	AddElement(/datum/element/heretic_focus)

/obj/item/codex_cicatrix/attack_self(mob/user, modifiers)
	var/was_open = book_open
	. = ..()
	if(!was_open && book_open)
		AddElement(/datum/element/heretic_focus)

/obj/item/codex_cicatrix/close_book()
	. = ..()
	RemoveElement(/datum/element/heretic_focus)

/datum/action/cooldown/spell/pointed/projectile/furious_steel/Grant(mob/grant_to)
	. = ..()
	if(owner && IS_HERETIC(owner))
		RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_ALLOW_HERETIC_CASTING), PROC_REF(on_focus_lost))

/datum/action/cooldown/spell/pointed/projectile/furious_steel/Remove(mob/remove_from)
	UnregisterSignal(remove_from, SIGNAL_REMOVETRAIT(TRAIT_ALLOW_HERETIC_CASTING))
	return ..()

/datum/action/cooldown/spell/pointed/projectile/furious_steel/proc/on_focus_lost(mob/source)
	SIGNAL_HANDLER

	unset_click_ability(source, refund_cooldown = TRUE)

/datum/action/cooldown/spell/shadow_cloak/cloak_mob(mob/living/cast_on)
	. = ..()
	RegisterSignal(cast_on, SIGNAL_REMOVETRAIT(TRAIT_ALLOW_HERETIC_CASTING), PROC_REF(on_focus_lost))

/datum/action/cooldown/spell/shadow_cloak/uncloak_mob(mob/living/cast_on, show_message = TRUE)
	UnregisterSignal(cast_on, SIGNAL_REMOVETRAIT(TRAIT_ALLOW_HERETIC_CASTING))
	return ..()

/datum/action/cooldown/spell/shadow_cloak/proc/on_focus_lost(mob/living/source)
	SIGNAL_HANDLER

	uncloak_mob(source, show_message = FALSE)
	source.visible_message(
		span_warning("[source] suddenly appears from the shadows!"),
		span_userdanger("As you lose your focus, you are pulled out of the shadows!"),
	)
	StartCooldown(uncloak_time / 3)

/datum/status_effect/caretaker_refuge/on_apply()
	. = ..()
	if(.)
		RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_ALLOW_HERETIC_CASTING), PROC_REF(on_focus_lost))

/datum/status_effect/caretaker_refuge/on_remove()
	UnregisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_ALLOW_HERETIC_CASTING))
	return ..()

/datum/status_effect/caretaker_refuge/proc/on_focus_lost()
	SIGNAL_HANDLER

	to_chat(owner, span_danger("Without a focus, your refuge weakens and dissipates!"))
	qdel(src)
