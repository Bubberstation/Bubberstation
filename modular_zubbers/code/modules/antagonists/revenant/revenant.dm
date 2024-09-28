/mob/living/basic/revenant
	essence = 1
	max_essence = 75
	essence_regen_amount = 1.5
	var/times_tossed = 0
	var/pending_punishment


/mob/living/basic/revenant/get_status_tab_items()
	. = ..()
	. += "Times scattered: [times_tossed]"

/obj/item/ectoplasm/revenant
	icon = 'icons/effects/effects.dmi'
	icon_state = "revenantEctoplasm"

/obj/item/ectoplasm/revenant/proc/become_defeated()
	if(!revenant.pending_punishment)
		alpha = 50
		revenant.pending_punishment = TRUE
		icon = 'modular_zubbers/icons/effects/revenant.dmi'
		icon_state = "scattered"
		to_chat(revenant, span_revenwarning("Your ashes are scattered!"))
		addtimer(CALLBACK(src, PROC_REF(try_reform)), 3 MINUTES, TIMER_OVERRIDE)

/mob/living/basic/revenant/death_reset()
	. = ..()
	if(pending_punishment)
		times_tossed++
		essence_regen_amount = 0.1 // drain a soul to get it back to normal.
		pending_punishment = FALSE
		to_chat(src, span_revenwarning("Your ashes slowly come back together."))
