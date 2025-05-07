/datum/config_entry/flag/blinking
	default = TRUE

// blinking won't update without re-running the animate
/datum/config_entry/flag/blinking/vv_edit_var(var_name, var_value)
	. = ..()
	if(var_name == NAMEOF(src, config_entry_value))
		INVOKE_ASYNC(src, PROC_REF(update_blinkers))


/datum/config_entry/flag/blinking/proc/update_blinkers()
	for(var/mob/living/carbon/human/blinker in GLOB.alive_mob_list)
		var/obj/item/organ/eyes/eyes = blinker.get_organ_slot(ORGAN_SLOT_EYES)
		eyes?.blink()
		CHECK_TICK
