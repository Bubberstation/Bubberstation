/mob/living/basic/revenant
	essence = 1
	max_essence = 60
	essence_regen_amount = 1
	var/times_tossed = 0
	var/pending_punishment


/mob/living/basic/revenant/get_status_tab_items()
	. = ..()
	. += "Times scattered: [times_tossed]"



/obj/item/ectoplasm/revenant/proc/become_defeated()
	if(!revenant.pending_punishment)
		alpha = 0
		revenant.pending_punishment = TRUE
		to_chat(revenant, span_revenwarning("Your spirit is put to rest... for now."))
		sleep(3 MINUTES)

/mob/living/basic/revenant/death_reset()
	. = ..()
	if(pending_punishment)
		times_tossed++
/* 		var/datum/action/cooldown/spell/aoe/revenant/ability = pick(abilities)
		ability.locked = initial(ability.locked) */
		essence_regen_amount = 0.05 // drain a soul to get it back to normal.
		pending_punishment = FALSE
		to_chat(src, span_revenwarning("Your ashes slowly come back together."))
