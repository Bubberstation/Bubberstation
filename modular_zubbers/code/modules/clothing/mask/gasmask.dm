/obj/item/clothing/mask/gas
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/gas/welding
	flags_inv = HIDEEYES|HIDEFACE|HIDESNOUT

/obj/item/clothing/mask/gas/modulator
	name = "modified gas mask"
	desc = "An older model of gas mask issued for use on station to help protect against airborne hazards. This one appears to be \
		heavily modified, and the filter assembly has been replaced with a voice modulator to make the wearer sound more robotic."
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	max_filters = 0
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	///Our SPEAKING name while our voice is cloaked. Defaults to "Unknown", but can be set by var editing.
	var/modulated_name = "Unknown"
	///Used to store a special name if they wearer has one before equipping the mask.
	var/previous_special_name = null
	///If we are actually using the voice changer or not
	var/modulate_voice = TRUE

/obj/item/clothing/mask/gas/modulator/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/clothing/mask/gas/modulator/examine(mob/user)
	. = ..()
	. += span_notice("Its voice modulator is currently [modulate_voice ? "enabled" : "disabled"]. <b>Alt-click</b> to toggle it.")

/obj/item/clothing/mask/gas/modulator/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You examine [src] closer, and notice a warning label on the side of the voice analyzer module.. \
		\"Please enunciate words CLEARLY and PRECISELY for device to function.\"</i>")

/obj/item/clothing/mask/gas/modulator/click_alt(mob/user)
	modulate_voice = !modulate_voice
	balloon_alert(user, "voice modulator [modulate_voice ? "enabled":"disabled"]")
	update_voice(user)

	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/gas/modulator/equipped(mob/user, slot)
	. = ..()
	if ((slot & ITEM_SLOT_MASK))
		RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speech))
		RegisterSignal(user, SIGNAL_ADDTRAIT(TRAIT_SIGN_LANG), PROC_REF(update_voice))
		RegisterSignal(user, SIGNAL_REMOVETRAIT(TRAIT_SIGN_LANG), PROC_REF(update_voice))
	else
		UnregisterSignal(user, list(COMSIG_MOB_SAY, SIGNAL_ADDTRAIT(TRAIT_SIGN_LANG), SIGNAL_REMOVETRAIT(TRAIT_SIGN_LANG)))

	update_voice(user)

/obj/item/clothing/mask/gas/modulator/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_MOB_SAY, SIGNAL_ADDTRAIT(TRAIT_SIGN_LANG), SIGNAL_REMOVETRAIT(TRAIT_SIGN_LANG)))
	update_voice(user)

/obj/item/clothing/mask/gas/modulator/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[modulate_voice ? "Disable":"Enable"] voice modulator"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/clothing/mask/gas/modulator/proc/update_voice(mob/user)
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/human_user = user
	var/obj/item/organ/tongue/user_tongue = human_user.get_organ_slot(ORGAN_SLOT_TONGUE)

	if(!user_tongue)
		return

	if(HAS_TRAIT(human_user, TRAIT_SIGN_LANG))
		user_tongue.temp_say_mod = "signs"
		human_user.override_voice = previous_special_name
		previous_special_name = null
		return

	if(human_user.override_voice != modulated_name)
		previous_special_name = human_user.override_voice

	if(human_user.wear_mask == src && modulate_voice)
		human_user.override_voice = modulated_name
		user_tongue.temp_say_mod = "states"
		return

	human_user.override_voice = previous_special_name
	user_tongue.temp_say_mod = initial(user_tongue.temp_say_mod)
	previous_special_name = null

/obj/item/clothing/mask/gas/modulator/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	if (!modulate_voice || HAS_TRAIT(source, TRAIT_SIGN_LANG))
		return

	speech_args[SPEECH_SPANS] |= SPAN_ROBOT
