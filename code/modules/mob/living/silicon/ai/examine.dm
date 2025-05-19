/mob/living/silicon/ai/examine(mob/user)
	. = list("<span class='info'>This is [icon2html(src, user)] <EM>[src]</EM>!", EXAMINE_SECTION_BREAK) //SKYRAT EDIT CHANGE
	if(stat == DEAD)
		. += span_deadsay("[p_They()] appear[p_s()] to be powered-down.")
	. += span_notice("[p_Their()] floor <b>bolts</b> are [is_anchored ? "tightened" : "loose"].")
	if(is_anchored)
		if(!opened)
			if(!emagged)
				. += span_notice("[p_Their()] access panel is [stat == DEAD ? "damaged" : "closed and locked"], but could be <b>pried</b> open.")
			else
				. += span_warning("[p_Their()] access panel lock is sparking, the cover can be <b>pried</b> open.")
		else
			. += span_notice("[p_Their()] neural network connection could be <b>cut</b>, the access panel cover can be <b>pried</b> back into place.")
	if(stat != DEAD)
		if (getBruteLoss())
			if (getBruteLoss() < 30)
				. += span_warning("[p_They()] look[p_s()] slightly dented.")
			else
				. += span_warning("<B>[p_They()] look[p_s()] severely dented!</B>")
		if (getFireLoss())
			if (getFireLoss() < 30)
				. += span_warning("[p_They()] look[p_s()] slightly charred.")
			else
				. += span_warning("<B>[p_Their()] casing is melted and heat-warped!</B>")
		if(deployed_shell)
			. += "The wireless networking light is blinking."
		else if (!shunted && !client)
			. += "[src]Core.exe has stopped responding! NTOS is searching for a solution to the problem..."
	//SKYRAT EDIT ADDITION BEGIN - CUSTOMIZATION
	. += get_silicon_flavortext()
	//SKYRAT EDIT ADDITION END
	. += "</span>"

	. += ..()
