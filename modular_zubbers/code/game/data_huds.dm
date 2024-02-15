/mob/living/carbon
	var/flickering_wound_hud = FALSE
	var/flickering_virus_hud = FALSE

/mob/living/carbon/med_hud_set_status()
	var/image/holder = hud_list?[STATUS_HUD]
	if (isnull(holder))
		return

	var/icon/I = icon(icon, icon_state, dir)
	var/virus_threat = check_virus()
	holder.pixel_y = I.Height() - world.icon_size
	if(HAS_TRAIT(src, TRAIT_XENO_HOST))
		holder.icon_state = "hudxeno"
	else if(stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH)))
		if(can_defib_client())
			holder.icon_state = "huddefib"
		else
			holder.icon_state = "huddead"
	else
		if(!flickering_wound_hud)
			switch(virus_threat)
				if(DISEASE_SEVERITY_UNCURABLE)
					holder.icon_state = "hudill6"
				if(DISEASE_SEVERITY_BIOHAZARD)
					holder.icon_state = "hudill5"
				if(DISEASE_SEVERITY_DANGEROUS)
					holder.icon_state = "hudill4"
				if(DISEASE_SEVERITY_HARMFUL)
					holder.icon_state = "hudill3"
				if(DISEASE_SEVERITY_MEDIUM)
					holder.icon_state = "hudill2"
				if(DISEASE_SEVERITY_MINOR)
					holder.icon_state = "hudill1"
				if(DISEASE_SEVERITY_NONTHREAT)
					holder.icon_state = "hudill0"
				if(DISEASE_SEVERITY_POSITIVE)
					holder.icon_state = "hudbuff"
				if(null)
					holder.icon_state = "hudhealthy"
// Wound huds
		if(virus_threat && flickering_virus_hud)
			return
		var/highest_severity_found = FALSE
		for (var/datum/wound/wound in all_wounds)
			if (wound.severity == WOUND_SEVERITY_CRITICAL)
				holder.icon_state = "hudcriticalwound"
				highest_severity_found = TRUE
			else if (wound.severity == WOUND_SEVERITY_SEVERE && !highest_severity_found)
				holder.icon_state = "hudseverewound"
				highest_severity_found = TRUE
			else if (wound.severity == WOUND_SEVERITY_MODERATE && !highest_severity_found)
				holder.icon_state = "hudmoderatewound"
				highest_severity_found = TRUE
		if(highest_severity_found && !flickering_wound_hud && virus_threat)
			addtimer(CALLBACK(src, PROC_REF(update_hud)), 1 SECONDS)
			flickering_wound_hud = TRUE

/mob/living/carbon/proc/update_hud(post_cooldown)
	flickering_wound_hud = FALSE
	if(!post_cooldown)
		flickering_virus_hud = TRUE
		addtimer(CALLBACK(src, PROC_REF(update_hud), TRUE), 1 SECONDS)
		return med_hud_set_status()
	flickering_virus_hud = FALSE
	return med_hud_set_status()
