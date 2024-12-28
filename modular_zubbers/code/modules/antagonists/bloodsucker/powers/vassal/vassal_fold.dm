/datum/action/cooldown/bloodsucker/ghoul_blood
	name = "Help Ghoul"
	desc = "Bring an ex-Ghoul back into the fold, or create blood using a bag. RMB: Check Ghoul status."
	button_icon_state = "power_torpor"
	power_explanation = "Help Ghoul:\n\
		Use this power while you have an ex-Ghoul grabbed to bring them back into the fold. \
		Use this power with a bloodbag in your hand to instead fill it with Vampiric Blood which \
		can be used to reset ex-ghoul deconversion timers. \
		Right-Click will show the status of all Ghouls."
	check_flags = NONE
	purchase_flags = NONE
	bloodcost = 10
	cooldown_time = 10 SECONDS
	level_current = -1
	///Bloodbag we have in our hands.
	var/obj/item/reagent_containers/blood/bloodbag
	///Weakref to a target we're bringing into the fold.
	var/datum/weakref/target_ref

/datum/action/cooldown/bloodsucker/ghoul_blood/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/ghoul/revenge/revenge_ghoul = IS_REVENGE_GHOUL(owner)
	if(revenge_ghoul)
		return FALSE

	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		if(!revenge_ghoul.ex_ghouls.len)
			owner.balloon_alert(owner, "no ghouls!")
			return FALSE
		return TRUE

	if(owner.pulling && isliving(owner.pulling))
		var/mob/living/pulled_target = owner.pulling
		var/datum/antagonist/ex_ghoul/former_ghoul = IS_EX_GHOUL(pulled_target)
		if(!former_ghoul)
			owner.balloon_alert(owner, "not a former ghoul!")
			return FALSE
		target_ref = WEAKREF(owner.pulling)
		return TRUE

	var/blood_bag = locate(/obj/item/reagent_containers/blood) in user.held_items
	if(!blood_bag)
		owner.balloon_alert(owner, "blood bag needed!")
		return FALSE
	if(istype(blood_bag, /obj/item/reagent_containers/blood/o_minus/bloodsucker))
		owner.balloon_alert(owner, "already bloodsucker blood!")

	bloodbag = blood_bag
	return TRUE

/datum/action/cooldown/bloodsucker/ghoul_blood/ActivatePower(trigger_flags)
	. = ..()
	var/datum/antagonist/ghoul/revenge/revenge_ghoul = IS_REVENGE_GHOUL(owner)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		for(var/datum/antagonist/ex_ghoul/former_ghouls as anything in revenge_ghoul.ex_ghouls)
			var/information = "[former_ghouls.owner.current]"
			information += " - has [round(COOLDOWN_TIMELEFT(former_ghouls, blood_timer) / 600)] minutes left of Blood"
			var/turf/open/floor/target_area = get_area(owner)
			if(target_area)
				information += " - currently at [target_area]."
			if(former_ghouls.owner.current.stat >= DEAD)
				information += " - DEAD."

			to_chat(owner, "[information]")

		DeactivatePower()
		return FALSE

	if(target_ref)
		var/mob/living/target = target_ref.resolve()
		var/datum/antagonist/ex_ghoul/former_ghoul = IS_EX_GHOUL(target)
		if(!former_ghoul || former_ghoul.revenge_ghoul)
			target_ref = null
			return
		if(do_after(owner, 5 SECONDS, target))
			former_ghoul.return_to_fold(revenge_ghoul)
		target_ref = null
		DeactivatePower()
		return FALSE

	if(bloodbag)
		var/mob/living/living_owner = owner
		living_owner.blood_volume -= 150
		QDEL_NULL(bloodbag)
		var/obj/item/reagent_containers/blood/o_minus/bloodsucker/new_bag = new(owner.loc)
		owner.put_in_active_hand(new_bag)
		DeactivatePower()
	return TRUE
