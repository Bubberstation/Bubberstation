///Adjusts the parent human's arousal value based off the value assigned to `arous.`
/mob/living/carbon/human/proc/adjust_arousal(arous = 0)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return FALSE

	var/arousal_flag = AROUSAL_NONE
	if(arousal >= AROUSAL_MEDIUM)
		arousal_flag = AROUSAL_FULL
	else if(arousal >= AROUSAL_LOW)
		arousal_flag = AROUSAL_PARTIAL

	if(arousal_status != arousal_flag) // Set organ arousal status
		arousal_status = arousal_flag
		if(istype(src, /mob/living/carbon/human))
			var/mob/living/carbon/human/target = src
			for(var/obj/item/organ/genital/target_genital in target.organs)
				if(!target_genital.aroused == AROUSAL_CANT)
					target_genital.aroused = arousal_status
					target_genital.update_sprite_suffix()
			target.update_body()
			SEND_SIGNAL(src, COMSIG_HUMAN_ADJUST_AROUSAL)

	arousal = clamp(arousal + arous, AROUSAL_MINIMUM, AROUSAL_LIMIT)

	if(!has_status_effect(/datum/status_effect/aroused) && arousal)
		apply_status_effect(/datum/status_effect/aroused)

	if(arousal < AROUSAL_LOW)
		if(!arousal)
			remove_status_effect(/datum/status_effect/aroused)

		remove_status_effect(/datum/status_effect/body_fluid_regen/testes)
		remove_status_effect(/datum/status_effect/body_fluid_regen/vagina)

	else
		if(get_organ_slot(ORGAN_SLOT_TESTICLES) && !has_status_effect(/datum/status_effect/body_fluid_regen/testes))
			apply_status_effect(/datum/status_effect/body_fluid_regen/testes)

		if(get_organ_slot(ORGAN_SLOT_VAGINA) && !has_status_effect(/datum/status_effect/body_fluid_regen/vagina))
			apply_status_effect(/datum/status_effect/body_fluid_regen/vagina)

	var/obj/item/organ/genital/breasts/breasts = get_organ_slot(ORGAN_SLOT_BREASTS)

	if(!breasts || !breasts.lactates)
		remove_status_effect(/datum/status_effect/body_fluid_regen/breasts)
	else
		if(!has_status_effect(/datum/status_effect/body_fluid_regen/breasts))
			apply_status_effect(/datum/status_effect/body_fluid_regen/breasts)

	return TRUE

/mob/living/carbon/human/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/mob/living/examinee = source

	if(examinee.client.prefs.read_preference(/datum/preference/toggle/erp) && user.client.prefs.read_preference(/datum/preference/toggle/erp))
		if (arousal > AROUSAL_HIGH)
			examine_list += span_userlove("They seem extremely aroused!")
			return
		if (arousal > AROUSAL_LOW)
			examine_list += span_userlove("They seem pretty aroused")
			return
		if (arousal > AROUSAL_NONE)
			examine_list += span_userlove("They seem slightly aroused")
			return
		else
			examine_list += "They don't seem aroused"

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

