
/obj/item/clothing/mask/bridle
	name = "bridle"
	desc = "A Sunny Stables design of a leather horse bridle, complete with blinders and a bit. It's made of several leather straps and metal fittings. You can tighten or loosen the straps to make sure that the blinders and the bit stay in place."
	icon_state = "bridle"
	inhand_icon_state = "sechailer"
	icon = 'modular_zubbers/icons/obj/clothing/mask/mask.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/mask/mask.dmi'
	worn_icon_state = "bridle"
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = NONE
	actions_types = list(
		/datum/action/item_action/bridle_toggle_blinders,
		/datum/action/item_action/bridle_toggle_gag,
	)
	action_slots = ITEM_SLOT_MASK
	var/blinders_enabled = FALSE
	var/gag_enabled = FALSE
	var/blinders_tint = 2
	var/last_blinders_enabled = FALSE
	var/last_gag_enabled = FALSE
	var/straps_locked = FALSE
	var/strip_adjust_delay = 4 SECONDS

/obj/item/clothing/mask/bridle/Initialize(mapload)
	. = ..()
	update_bridle_state()

/obj/item/clothing/mask/bridle/Destroy()
	var/mob/living/carbon/wearer = get_wearer()
	if(wearer)
		remove_gag(wearer)
		wearer.update_tint()
	return ..()

/obj/item/clothing/mask/bridle/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_MASK))
		return
	playsound(user, 'sound/items/equip/toolbelt_equip.ogg', 50, TRUE)
	update_bridle_state(user)
	user.update_action_buttons()

/obj/item/clothing/mask/bridle/dropped(mob/living/carbon/user)
	. = ..()
	if(gag_enabled)
		remove_gag(user)
	if(blinders_enabled)
		user.update_tint()
	user.update_worn_mask()
	user.update_action_buttons()

/obj/item/clothing/mask/bridle/click_alt(mob/user)
	if(!istype(user) || user.incapacitated)
		return CLICK_ACTION_BLOCKING
	cycle_mode(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/bridle/attack_self(mob/user)
	. = ..()
	if(!istype(user) || user.incapacitated)
		return
	straps_locked = !straps_locked
	if(straps_locked)
		to_chat(user, span_notice("You secure the bridle's straps."))
	else
		to_chat(user, span_notice("You loosen the bridle's straps."))

/obj/item/clothing/mask/bridle/proc/get_wearer()
	var/mob/living/carbon/wearer = istype(loc, /mob/living/carbon) ? loc : null
	if(wearer && wearer.get_item_by_slot(ITEM_SLOT_MASK) == src)
		return wearer
	return null

/obj/item/clothing/mask/bridle/proc/should_show_user_message(mob/user)
	if(!user)
		return FALSE
	return user.get_item_by_slot(ITEM_SLOT_MASK) != src

/obj/item/clothing/mask/bridle/proc/locked_message(mob/user)
	if(!user)
		return
	if(should_show_user_message(user))
		to_chat(user, span_notice("The straps are too secure to adjust."))
	else
		to_chat(user, span_warning("The straps are too secure!"))

/obj/item/clothing/mask/bridle/examine(mob/user)
	. = ..()
	var/blinders_state_text = blinders_enabled ? "down" : "up"
	var/gag_state_text = gag_enabled ? "set" : "unset"
	. += span_notice("The blinders are [blinders_state_text], and the bit is [gag_state_text].")

/obj/item/clothing/mask/bridle/proc/update_bridle_state(mob/user, notify_wearer = TRUE)
	var/mob/living/carbon/wearer = get_wearer()
	worn_icon_state = blinders_enabled ? "bridle_blinders" : "bridle"
	tint = blinders_enabled ? blinders_tint : 0
	flags_cover = gag_enabled ? MASKCOVERSMOUTH : NONE
	if(wearer)
		if(blinders_enabled != last_blinders_enabled)
			if(notify_wearer)
				var/blinders_action
				var/blinders_action_self
				var/blinders_effect
				var/blinders_self
				if(blinders_enabled)
					blinders_action = "lowers"
					blinders_action_self = "lower"
					blinders_effect = "obscuring your vision"
					blinders_self = "lower, obscuring your vision"
				else
					blinders_action = "raises"
					blinders_action_self = "raise"
					blinders_effect = "restoring your sight"
					blinders_self = "raise, restoring your sight"
				if(user && user != wearer)
					to_chat(wearer, span_userdanger("[user] [blinders_action] the bridle's blinders, [blinders_effect]."))
				else if(user)
					to_chat(wearer, span_notice("You [blinders_action_self] the bridle's blinders, [blinders_effect]."))
				else
					to_chat(wearer, span_notice("The bridle's blinders [blinders_self]."))
			last_blinders_enabled = blinders_enabled
		if(gag_enabled != last_gag_enabled)
			if(notify_wearer)
				var/gag_action
				var/gag_action_self
				var/gag_effect
				var/gag_self
				if(gag_enabled)
					gag_action = "sets"
					gag_action_self = "set"
					gag_effect = "muffling your speech"
					gag_self = "fits in your mouth, muffling your speech"
				else
					gag_action = "loosens"
					gag_action_self = "loosen"
					gag_effect = "letting you speak freely"
					gag_self = "loosens, allowing you to speak freely"
				if(user && user != wearer)
					to_chat(wearer, span_userdanger("[user] [gag_action] the bridle's bit, [gag_effect]."))
				else if(user)
					to_chat(wearer, span_notice("You [gag_action_self] the bridle's bit, [gag_effect]."))
				else
					to_chat(wearer, span_notice("The bridle's bit [gag_self]."))
			last_gag_enabled = gag_enabled
		wearer.update_tint()
		wearer.update_worn_mask()
		if(gag_enabled)
			apply_gag(wearer)
		else
			remove_gag(wearer)

/obj/item/clothing/mask/bridle/proc/toggle_blinders(mob/user)
	if(straps_locked)
		locked_message(user)
		return
	blinders_enabled = !blinders_enabled
	if(should_show_user_message(user))
		var/blinders_action
		if(blinders_enabled)
			blinders_action = "lower"
		else
			blinders_action = "raise"
		to_chat(user, span_notice("You [blinders_action] the bridle's blinders."))
	update_bridle_state(user)

/obj/item/clothing/mask/bridle/proc/toggle_gag(mob/user)
	if(straps_locked)
		locked_message(user)
		return
	gag_enabled = !gag_enabled
	if(should_show_user_message(user))
		var/gag_action
		if(gag_enabled)
			gag_action = "secure"
		else
			gag_action = "loosen"
		to_chat(user, span_notice("You [gag_action] the bridle's bit."))
	update_bridle_state(user)

/obj/item/clothing/mask/bridle/proc/cycle_mode(mob/user)
	if(straps_locked)
		locked_message(user)
		return
	if(!blinders_enabled && !gag_enabled)
		set_mode(TRUE, FALSE, user)
		return
	if(blinders_enabled && !gag_enabled)
		set_mode(FALSE, TRUE, user)
		return
	if(!blinders_enabled && gag_enabled)
		set_mode(TRUE, TRUE, user)
		return
	set_mode(FALSE, FALSE, user)

/obj/item/clothing/mask/bridle/proc/set_mode(new_blinders, new_gag, mob/user, notify_wearer = TRUE)
	if(straps_locked)
		locked_message(user)
		return
	blinders_enabled = new_blinders
	gag_enabled = new_gag
	if(user)
		var/balloon_state
		if(blinders_enabled && gag_enabled)
			balloon_state = "blinders + bit"
		else if(blinders_enabled)
			balloon_state = "blinders"
		else if(gag_enabled)
			balloon_state = "bit"
		else
			balloon_state = "none"
		if(should_show_user_message(user))
			balloon_alert(user, "mode: [balloon_state]")
	if(should_show_user_message(user))
		var/state_text
		if(blinders_enabled && gag_enabled)
			state_text = "blinders and bit"
		else if(blinders_enabled)
			state_text = "blinders"
		else if(gag_enabled)
			state_text = "bit"
		else
			state_text = "none"
		to_chat(user, span_notice("Bridle set to: [state_text]."))
	update_bridle_state(user, notify_wearer)

/obj/item/clothing/mask/bridle/proc/strip_adjust(mob/living/carbon/wearer, mob/living/stripper)
	if(!wearer || !stripper)
		return
	if(straps_locked)
		locked_message(stripper)
		return
	if(wearer.get_item_by_slot(ITEM_SLOT_MASK) != src)
		return
	if(!stripper.Adjacent(wearer))
		wearer.balloon_alert(stripper, "can't reach!")
		return
	if(!do_after(stripper, strip_adjust_delay, wearer))
		return
	var/old_blinders = blinders_enabled
	var/old_gag = gag_enabled
	var/new_blinders
	var/new_gag
	if(!blinders_enabled && !gag_enabled)
		new_blinders = TRUE
		new_gag = FALSE
	else if(blinders_enabled && !gag_enabled)
		new_blinders = FALSE
		new_gag = TRUE
	else if(!blinders_enabled && gag_enabled)
		new_blinders = TRUE
		new_gag = TRUE
	else
		new_blinders = FALSE
		new_gag = FALSE
	var/list/parts = list()
	if(old_blinders != new_blinders)
		parts += (new_blinders ? "lower the bridle's blinders" : "raise the bridle's blinders")
	if(old_gag != new_gag)
		parts += (new_gag ? "set the bridle's bit" : "loosen the bridle's bit")
	var/action_text = parts.len ? jointext(parts, " and ") : "adjust the bridle"
	to_chat(stripper, span_notice("You [action_text]."))
	set_mode(new_blinders, new_gag, stripper, TRUE)

/datum/strippable_item/mob_item_slot/mask/get_alternate_actions(atom/source, mob/user, obj/item/item)
	. = ..()
	var/obj/item/clothing/mask/bridle/bridle = item
	if(!istype(bridle))
		return
	. += "adjust_bridle"

/datum/strippable_item/mob_item_slot/mask/perform_alternate_action(atom/source, mob/user, action_key, obj/item/item)
	if(!..())
		return
	var/obj/item/clothing/mask/bridle/bridle = item
	if(!istype(bridle))
		return
	if(action_key == "adjust_bridle")
		bridle.strip_adjust(source, user)

/obj/item/clothing/mask/bridle/proc/apply_gag(mob/living/carbon/wearer)
	if(!wearer || wearer.get_item_by_slot(ITEM_SLOT_MASK) != src)
		return
	UnregisterSignal(wearer, list(COMSIG_MOB_SAY, COMSIG_MOB_PRE_EMOTED))
	RegisterSignal(wearer, COMSIG_MOB_SAY, PROC_REF(muzzle_talk))
	RegisterSignal(wearer, COMSIG_MOB_PRE_EMOTED, PROC_REF(emote_override))

/obj/item/clothing/mask/bridle/proc/remove_gag(mob/living/carbon/wearer)
	if(!wearer)
		return
	UnregisterSignal(wearer, list(COMSIG_MOB_SAY, COMSIG_MOB_PRE_EMOTED))

/obj/item/clothing/mask/bridle/proc/emote_override(mob/living/source, key, params, type_override, intentional, datum/emote/emote)
	SIGNAL_HANDLER
	if(emote.muzzle_ignore)
		return NONE
	if(emote.key in list("snort", "neigh", "neigh2")) //Can still do horse emotes because DUH
		return NONE
	if(!emote.hands_use_check && (emote.emote_type & EMOTE_AUDIBLE))
		source.audible_message("makes a [pick("strong ", "weak ", "")]noise.", audible_message_flags = EMOTE_MESSAGE|ALWAYS_SHOW_SELF_MESSAGE)
		return COMPONENT_CANT_EMOTE
	return NONE

/obj/item/clothing/mask/bridle/proc/muzzle_talk(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if(HAS_TRAIT(source, TRAIT_SIGN_LANG))
		return
	var/spoken_message = speech_args[SPEECH_MESSAGE]
	if(spoken_message)
		var/list/words = splittext(spoken_message, " ")
		var/yell_suffix = copytext(spoken_message, findtext(spoken_message, "!"))
		spoken_message = ""

		for(var/ind = 1 to length(words))
			var/new_word = ""
			for(var/i = 1 to length(words[ind]) + rand(-1,1))
				new_word += "m"
			new_word += "f"
			words[ind] = yell_suffix ? uppertext(new_word) : new_word
		spoken_message = "[jointext(words, " ")][yell_suffix]"
	speech_args[SPEECH_MESSAGE] = spoken_message

/datum/action/item_action/bridle_toggle_blinders
	name = "Toggle blinders"
	desc = "Adjust the bridle blinders."

/datum/action/item_action/bridle_toggle_blinders/Trigger(trigger_flags)
	var/obj/item/clothing/mask/bridle/bridle = target
	if(istype(bridle))
		bridle.toggle_blinders(owner)

/datum/action/item_action/bridle_toggle_gag
	name = "Toggle gag"
	desc = "Adjust the bridle bit."

/datum/action/item_action/bridle_toggle_gag/Trigger(trigger_flags)
	var/obj/item/clothing/mask/bridle/bridle = target
	if(istype(bridle))
		bridle.toggle_gag(owner)
