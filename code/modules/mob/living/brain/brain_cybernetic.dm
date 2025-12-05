/obj/item/organ/brain/cybernetic
	name = "cybernetic brain"
	desc = "A mechanical brain found inside of androids. Not to be confused with a positronic brain."
	icon_state = "brain-c"
	organ_flags = ORGAN_ROBOTIC | ORGAN_VITAL
	failing_desc = "seems to be broken, and will not work without repairs."
	shade_color = null
	var/emp_dmg_mult = 1 //BUBBER EDIT - Variable multiplier for damage from EMPs. Note the base damage is 20.
	var/emp_dmg_max = 999 ///BUBBER EDIT - Threshold before the organ simply stops taking damage from EMPs. Defaults to kill


/obj/item/organ/brain/cybernetic/brain_damage_examine()
	if(suicided)
		return span_info("Its circuitry is smoking slightly. They must not have been able to handle the stress of it all.")
	if(brainmob && (decoy_override || brainmob.client || brainmob.get_ghost()))
		if(organ_flags & ORGAN_FAILING)
			return span_info("It seems to still have a bit of energy within it, but it's rather damaged... You may be able to repair it with a <b>multitool</b>.")
		else if(damage >= BRAIN_DAMAGE_DEATH*0.5)
			return span_info("You can feel the small spark of life still left in this one, but it's got some dents. You may be able to restore it with a <b>multitool</b>.")
		else
			return span_info("You can feel the small spark of life still left in this one.")
	else
		return span_info("This one is completely devoid of life.")

/obj/item/organ/brain/cybernetic/check_for_repair(obj/item/item, mob/user)
	if (item.tool_behaviour == TOOL_MULTITOOL) //attempt to repair the brain
		if (brainmob?.health <= HEALTH_THRESHOLD_DEAD) //if the brain is fucked anyway, do nothing
			to_chat(user, span_warning("[src] is far too damaged, there's nothing else we can do for it!"))
			return TRUE

		if (DOING_INTERACTION(user, src))
			to_chat(user, span_warning("you're already repairing [src]!"))
			return TRUE

		user.visible_message(span_notice("[user] slowly starts to repair [src] with [item]."), span_notice("You slowly start to repair [src] with [item]."))
		var/did_repair = FALSE
		while(damage > 0)
			if(item.use_tool(src, user, 3 SECONDS, volume = 50))
				did_repair = TRUE
				set_organ_damage(max(0, damage - 20))
			else
				break

		if (did_repair)
			if (damage > 0)
				user.visible_message(span_notice("[user] partially repairs [src] with [item]."), span_notice("You partially repair [src] with [item]."))
			else
				user.visible_message(span_notice("[user] fully repairs [src] with [item], causing its warning light to stop flashing."), span_notice("You fully repair [src] with [item], causing its warning light to stop flashing."))
		else
			to_chat(user, span_warning("You failed to repair [src] with [item]!"))

		return TRUE
	return FALSE

/obj/item/organ/brain/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
//BUBBER EDIT BEGIN - can't be emp'd if dead
	if(owner.stat == DEAD)
		return
//BUBBER EDIT END
	switch(severity)
		if (EMP_HEAVY)
			to_chat(owner, span_boldwarning("You feel [pick("like your brain is being fried", "a sharp pain in your head")]!")) //BUBBER EDIT - added alert text for getting EMP'd.
			owner.adjust_organ_loss(ORGAN_SLOT_BRAIN, (20*emp_dmg_mult), emp_dmg_max) //BUBBER EDIT - cap implemented
		if (EMP_LIGHT)
			to_chat(owner, span_warning("You feel [pick("disoriented", "confused", "dizzy")].")) //BUBBER EDIT - added alert text for getting EMP'd.
			owner.adjust_organ_loss(ORGAN_SLOT_BRAIN, (10*emp_dmg_mult), emp_dmg_max) //BUBBER EDIT - cap implemented

