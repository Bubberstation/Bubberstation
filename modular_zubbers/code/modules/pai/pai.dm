// pAI
/mob/living/silicon/pai
	/// Whetever this pAI has leashing enabled
	var/holo_leash = FALSE
/mob/living/silicon/pai/get_status_tab_items()
	. = ..()
	if(!holo_leash)
		. += "Emitter set to: Move"
	else
		. += "Emitter set to: Project"
// Suicide is disabled, so we give them a new proc to trigger self deletion to leave the round cleanly without help
/mob/living/silicon/pai/proc/pai_cryo()
	if(incapacitated)
		return
	switch(alert("Are you sure you wish to wipe yourself? This will ghost you",,"Yes.","No."))
		if("Yes.")
			fold_in(TRUE)
			send_applicable_messages()
			ghostize(FALSE)
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 30, TRUE)
			LAZYNULL(mind?.special_roles)
			qdel(src)
		else
			return
