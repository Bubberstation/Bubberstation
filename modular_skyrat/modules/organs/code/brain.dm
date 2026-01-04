//Unifying vox brains and android brains, so that when one is updated the other is as well.

//The accessible cybernetic brain
/obj/item/organ/brain/cybernetic/cortical
	name = "cortically-augmented brain"
	desc = "A brain which has been, in some part, mechanized."
	icon = 'modular_skyrat/master_files/icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-c"
	organ_flags = ORGAN_ORGANIC | ORGAN_ROBOTIC | ORGAN_VITAL | ORGAN_PROMINENT
	emp_dmg_mult = 1.5 //Note that the base damage is 20/10
	emp_dmg_max = 150

//Extra effects
/obj/item/organ/brain/cybernetic/cortical/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(owner.stat == DEAD)
		return
	switch(severity)
		if(1)
			owner.set_jitter_if_lower(30 SECONDS)
			owner.adjust_stutter(30 SECONDS)
			owner.adjust_confusion(10 SECONDS)
		if(2)
			owner.set_jitter_if_lower(15 SECONDS)
			owner.adjust_stutter(15 SECONDS)
			owner.adjust_confusion(3 SECONDS)


// It's still organic
/obj/item/organ/brain/cybernetic/cortical/brain_damage_examine()
	if(suicided)
		return span_info("Its circuitry is smoking slightly. They must not have been able to handle the stress of it all.")
	if(brainmob && (decoy_override || brainmob.client || brainmob.get_ghost()))
		if(organ_flags & ORGAN_FAILING)
			return span_info("It seems to still have a bit of energy within it, but it's rather damaged... You may be able to restore it with some <b>mannitol</b> or a <b>multitool</b> .")
		else if(damage >= BRAIN_DAMAGE_DEATH*0.5)
			return span_info("You can feel the small spark of life still left in this one, but it's got some bruises. You may be able to restore it with some <b>mannitol</b> or a <b>multitool</b> .")
		else
			return span_info("You can feel the small spark of life still left in this one.")
	else
		return span_info("This one is completely devoid of life.")

// Hybrid repair option
/obj/item/organ/brain/cybernetic/cortical/check_for_repair(obj/item/item, mob/user)
	if(damage && item.is_drainable() && item.reagents.has_reagent(/datum/reagent/medicine/mannitol) && (organ_flags & ORGAN_ORGANIC)) //ganic repair option
		if(brainmob?.health <= HEALTH_THRESHOLD_DEAD) //if the brain is fucked anyway, do nothing
			to_chat(user, span_warning("[src] is far too damaged, there's nothing else we can do for it!"))
			return TRUE

		user.visible_message(span_notice("[user] starts to slowly pour the contents of [item] onto [src]."), span_notice("You start to slowly pour the contents of [item] onto [src]."))
		if(!do_after(user, 3 SECONDS, src))
			to_chat(user, span_warning("You failed to pour the contents of [item] onto [src]!"))
			return TRUE
		var/and_bright_shade = !shade_color ? "" : " and turn a slightly brighter shade of [shade_color]"
		user.visible_message(span_notice("[user] pours the contents of [item] onto [src], causing it to reform its original shape[and_bright_shade]."), span_notice("You pour the contents of [item] onto [src], causing it to reform its original shape[and_bright_shade]."))
		var/amount = item.reagents.get_reagent_amount(/datum/reagent/medicine/mannitol)
		var/healto = max(0, damage - amount * 2)
		item.reagents.remove_all(ROUND_UP(item.reagents.total_volume / amount * (damage - healto) * 0.5)) //only removes however much solution is needed while also taking into account how much of the solution is mannitol
		set_organ_damage(healto) //heals 2 damage per unit of mannitol, and by using "set_organ_damage", we clear the failing variable if that was up
		return TRUE
	else if (item.tool_behaviour == TOOL_MULTITOOL && (organ_flags & ORGAN_ROBOTIC)) //robotic repair option
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

//New vox Brain
/obj/item/organ/brain/cybernetic/cortical/vox
	name = "vox-augmented brain"
	desc = "A brain which has been in some part mechanized. The components are seamlessly integrated into the flesh."
	emp_dmg_mult = 1 //Nobody notices the brain damage anyways wink wink

//surplus; TBI to prosthetic organ quirk
//note that this is a direct child of the android brain, and is thus not organic
/obj/item/organ/brain/cybernetic/surplus
	name = "surplus augmented brain"
	desc = "A brain which has been in some part mechanized. It looks a bit cheap."
	maxHealth = BRAIN_DAMAGE_DEATH*0.5 //200 -> 100, at time of creation
	emp_dmg_max = 999

/obj/item/organ/brain/cybernetic/surplus/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dangerous_organ_removal, /*surgical = */ TRUE)

