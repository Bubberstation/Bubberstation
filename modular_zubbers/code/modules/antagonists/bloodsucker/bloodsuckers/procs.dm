/datum/antagonist/bloodsucker/proc/on_examine(datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER

	if(!iscarbon(source))
		return
	var/vamp_examine = return_vamp_examine(examiner)
	if(vamp_examine)
		examine_text += vamp_examine

/datum/antagonist/bloodsucker/proc/BuyPowers(powers = list())
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		BuyPower(power)

///Called when a Bloodsucker buys a power: (power)
/datum/antagonist/bloodsucker/proc/BuyPower(datum/action/cooldown/bloodsucker/power)
	for(var/datum/action/cooldown/bloodsucker/current_powers as anything in powers)
		if(current_powers.type == power.type)
			return FALSE
	power = new power()
	powers += power
	power.Grant(owner.current)
	log_uplink("[key_name(owner.current)] purchased [power].")
	return TRUE

///Called when a Bloodsucker loses a power: (power)
/datum/antagonist/bloodsucker/proc/RemovePower(datum/action/cooldown/bloodsucker/power)
	if(power.active)
		power.DeactivatePower()
	powers -= power
	power.Remove(owner.current)

/datum/antagonist/bloodsucker/proc/RemovePowerByPath(datum/action/cooldown/bloodsucker/power_to_remove)
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power?.type == power_to_remove)
			RemovePower(power)

///When a Bloodsucker breaks the Masquerade, they get their HUD icon changed, and Malkavian Bloodsuckers get alerted.
/datum/antagonist/bloodsucker/proc/break_masquerade(mob/admin)
	if(broke_masquerade)
		return
	owner.current.playsound_local(null, 'modular_zubbers/sound/bloodsucker/lunge_warn.ogg', 100, FALSE, pressure_affected = FALSE)
	to_chat(owner.current, span_cult_bold_italic("You have broken the Masquerade!"))
	to_chat(owner.current, span_warning("Bloodsucker Tip: When you break the Masquerade, you become open for termination by fellow Bloodsuckers, and your Vassals are no longer completely loyal to you, as other Bloodsuckers can steal them for themselves!"))
	broke_masquerade = TRUE
	antag_hud_name = "masquerade_broken"
	add_team_hud(owner.current)
	SEND_GLOBAL_SIGNAL(COMSIG_BLOODSUCKER_BROKE_MASQUERADE)

///This is admin-only of reverting a broken masquerade, sadly it doesn't remove the Malkavian objectives yet.
/datum/antagonist/bloodsucker/proc/fix_masquerade(mob/admin)
	if(!broke_masquerade)
		return
	to_chat(owner.current, span_cult_bold_italic("You have re-entered the Masquerade."))
	broke_masquerade = FALSE
	antag_hud_name = "bloodsucker"
	add_team_hud(owner.current)

/datum/antagonist/bloodsucker/proc/give_masquerade_infraction()
	if(broke_masquerade)
		return
	masquerade_infractions++
	if(masquerade_infractions >= 3)
		break_masquerade()
	else
		to_chat(owner.current, span_cult_bold("You violated the Masquerade! Break the Masquerade [3 - masquerade_infractions] more times and you will become a criminal to the Bloodsucker's Cause!"))

/datum/antagonist/bloodsucker/proc/RankUp(force = FALSE)
	if(!owner || !owner.current)
		return
	AdjustUnspentRank(1)
	if(!my_clan)
		to_chat(owner.current, span_notice("You have gained a rank. Join a Clan to spend it."))
		return
	// Spend Rank Immediately?
	if(!istype(owner.current.loc, /obj/structure/closet/crate/coffin))
		to_chat(owner, span_notice("<EM>You have grown more ancient! Sleep in a coffin (or put your Favorite Vassal on a persuasion rack for Ventrue) that you have claimed to thicken your blood and become more powerful.</EM>"))
		if(bloodsucker_level_unspent >= 2)
			to_chat(owner, span_announce("Bloodsucker Tip: If you cannot find or steal a coffin to use, you can build one from wood or metal."))
		return
	SpendRank()

/datum/antagonist/bloodsucker/proc/RankDown()
	AdjustUnspentRank(-1)

/datum/antagonist/bloodsucker/proc/remove_nondefault_powers(return_levels = FALSE)
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		RemovePower(power)
		if(return_levels)
			AdjustUnspentRank(1)

/datum/antagonist/bloodsucker/proc/LevelUpPowers()
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & TREMERE_CAN_BUY)
			continue
		power.upgrade_power()

///Disables all powers, accounting for torpor
/datum/antagonist/bloodsucker/proc/DisableAllPowers(forced = FALSE)
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(forced || ((power.check_flags & BP_CANT_USE_IN_TORPOR) && HAS_TRAIT_FROM_ONLY(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT)))
			if(power.active)
				power.DeactivatePower()

/datum/antagonist/bloodsucker/proc/SpendRank(mob/living/carbon/human/target, cost_rank = TRUE, blood_cost)
	if(!owner || !owner.current || !owner.current.client || (cost_rank && bloodsucker_level_unspent <= 0))
		return
	SEND_SIGNAL(src, BLOODSUCKER_RANK_UP, target, cost_rank, blood_cost)

/datum/antagonist/bloodsucker/proc/GetRank()
	return bloodsucker_level

/datum/antagonist/bloodsucker/proc/AdjustRank(amount)
	bloodsucker_level = max(bloodsucker_level + amount, 0)
	update_rank_hud()

/datum/antagonist/bloodsucker/proc/GetUnspentRank()
	return bloodsucker_level_unspent

/datum/antagonist/bloodsucker/proc/AdjustUnspentRank(amount)
	bloodsucker_level_unspent = max(bloodsucker_level_unspent + amount, 0)
	update_rank_hud()
/**
 * Called when a Bloodsucker reaches Final Death
 * Releases all Vassals and gives them the ex_vassal datum.
 */
/datum/antagonist/bloodsucker/proc/free_all_vassals()
	for(var/datum/antagonist/vassal/all_vassals in vassals)
		// Skip over any Bloodsucker Vassals, they're too far gone to have all their stuff taken away from them
		if(IS_BLOODSUCKER(all_vassals.owner.current))
			all_vassals.owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)
			continue
		if(all_vassals.special_type == REVENGE_VASSAL || !all_vassals.owner)
			continue
		all_vassals.owner.add_antag_datum(/datum/antagonist/ex_vassal)
		all_vassals.owner.remove_antag_datum(/datum/antagonist/vassal)

/**
 * Returns a Vampire's examine strings.
 * Args:
 * viewer - The person examining.
 */
/datum/antagonist/bloodsucker/proc/return_vamp_examine(mob/living/viewer)
	if(!viewer.mind && !isobserver(viewer))
		return FALSE
	// Viewer is Target's Vassal?
	if(!isobserver(viewer) && (viewer.mind.has_antag_datum(/datum/antagonist/vassal) in vassals))
		var/returnString = "\[<span class='warning'><EM>This is your Master!</EM></span>\]"
		var/returnIcon = "[icon2html('modular_zubbers/icons/misc/language.dmi', world, "bloodsucker")]"
		returnString += "\n"
		return returnIcon + returnString
	// Viewer not a Vamp AND not the target's vassal?
	if(!isobserver(viewer) && !viewer.mind.has_antag_datum((/datum/antagonist/bloodsucker)) && !(viewer in vassals))
		if(!(HAS_TRAIT(viewer.mind, TRAIT_BLOODSUCKER_HUNTER) && broke_masquerade))
			return FALSE
	// Default String
	var/returnString = "\[<span class='warning'><EM>[return_full_name()]</EM></span>\]"
	var/returnIcon = "[icon2html('modular_zubbers/icons/misc/language.dmi', world, "bloodsucker")]"

	// In Disguise (Veil)?
	//if (name_override != null)
	//	returnString += "<span class='suicide'> ([real_name] in disguise!) </span>"

	//returnString += "\n"  Don't need spacers. Using . += "" in examine.dm does this on its own.
	return returnIcon + returnString

// Blood level gain is used to give Bloodsuckers more levels if they are being agressive and drinking from real, sentient people.
// The maximum blood that counts towards this
/datum/antagonist/bloodsucker/proc/blood_level_gain()
	var/level_cost = get_level_cost()
	if(blood_level_gain >= level_cost && bloodsucker_blood_volume >= level_cost) // Checks if we have drunk enough blood from the living to allow us to gain a level up as well as checking if we have enough blood to actually use on the level up
		switch(tgui_alert(owner.current, "You have drunk enough blood from the living to thicken your blood, this will cost you [level_cost] blood and give you another level",  "Thicken your blood?.", list("Yes", "No"))) //asks user if they want to spend their blood on a level
			if("Yes")
				AdjustUnspentRank(1) // gives level
				blood_level_gain -= level_cost // Subtracts the cost from the pool of drunk blood
				AdjustBloodVolume(-level_cost) // Subtracts the cost from the bloodsucker's actual blood
				blood_level_gain_amount += 1 // Increments the variable that makes future levels more expensive

/datum/antagonist/bloodsucker/proc/get_level_cost()
	var/level_cost = (0.3 + (0.05 * blood_level_gain_amount))
	level_cost = min(level_cost, BLOOD_LEVEL_GAIN_MAX)
	level_cost = max_blood_volume * level_cost
	return level_cost


/datum/antagonist/bloodsucker/proc/max_vassals()
	return bloodsucker_level

/datum/antagonist/bloodsucker/proc/free_vassal_slots()
	return max(max_vassals() - length(vassals), 0)

/datum/antagonist/bloodsucker/proc/frenzy_enter_threshold()
	return FRENZY_THRESHOLD_ENTER + (humanity_lost * 10)

/datum/antagonist/bloodsucker/proc/frenzy_exit_threshold()
	return FRENZY_THRESHOLD_EXIT + (humanity_lost * 10)

/datum/antagonist/bloodsucker/proc/add_signals_to_heart(mob/living/carbon/human/current_mob)
	if(heart?.resolve())
		remove_signals_from_heart(current_mob)
	var/organ = current_mob.get_organ_slot(ORGAN_SLOT_HEART)
	heart = WEAKREF(organ)
	RegisterSignal(organ, COMSIG_ORGAN_REMOVED, PROC_REF(on_organ_removal))
	RegisterSignal(organ, COMSIG_ORGAN_BEING_REPLACED, PROC_REF(before_organ_replace))

/datum/antagonist/bloodsucker/proc/remove_signals_from_heart(mob/living/carbon/human/current_mob)
	var/organ = heart.resolve()
	if(!organ)
		return
	UnregisterSignal(organ, COMSIG_ORGAN_REMOVED)
	UnregisterSignal(organ, COMSIG_ORGAN_BEING_REPLACED)
	heart = null

/datum/antagonist/bloodsucker/proc/on_organ_removal(obj/item/organ/organ, mob/living/carbon/old_owner)
	SIGNAL_HANDLER
	if(old_owner.get_organ_slot(ORGAN_SLOT_HEART) || organ?.slot != ORGAN_SLOT_HEART || !old_owner.dna.species.mutantheart)
		return
	remove_signals_from_heart(old_owner)
	// You don't run bloodsucker life without a heart or brain
	RegisterSignal(old_owner, COMSIG_ENTER_COFFIN, PROC_REF(regain_heart))
	UnregisterSignal(old_owner, COMSIG_LIVING_LIFE)
	DisableAllPowers(TRUE)
	if(HAS_TRAIT_FROM_ONLY(old_owner, TRAIT_NODEATH, BLOODSUCKER_TRAIT))
		torpor_end(TRUE)
	to_chat(old_owner, span_userdanger("You have lost your [organ?.slot ? organ.slot : "heart"]!"))
	to_chat(old_owner, span_warning("This means you will no longer enter torpor nor revive from death, and you will no longer heal any damage, nor can you use your abilities."))

/datum/antagonist/bloodsucker/proc/on_organ_gain(mob/living/carbon/human/current_mob, obj/item/organ/replacement)
	SIGNAL_HANDLER
	if(replacement.slot != ORGAN_SLOT_HEART)
		return
	// Shit might get really fucked up. Let's try to fix things if it does
	if(current_mob != owner.current)
		UnregisterSignal(current_mob, COMSIG_CARBON_GAIN_ORGAN)
		RegisterSignal(owner.current, COMSIG_CARBON_GAIN_ORGAN)
		add_signals_to_heart(owner.current)
		RegisterSignal(owner.current, COMSIG_LIVING_LIFE, PROC_REF(LifeTick), TRUE)
		CRASH("Somehow the on_organ_gain signal is not on the owner of the bloodsucker datum, called on: [current_mob], bloodsucker datum owner: [owner.current]")
	UnregisterSignal(current_mob, COMSIG_ENTER_COFFIN)
	RegisterSignal(current_mob, COMSIG_LIVING_LIFE, PROC_REF(LifeTick), TRUE) // overriding here due to the fact this can without removing the signal due to before_organ_replace()
	add_signals_to_heart(current_mob)

/// This handles regen_organs replacing organs, without this the bloodsucker would die for a moment due to their heart being removed for a moment
/datum/antagonist/bloodsucker/proc/before_organ_replace(obj/item/organ/old_organ, obj/item/organ/new_organ)
	SIGNAL_HANDLER
	if(new_organ.slot != ORGAN_SLOT_HEART)
		return
	remove_signals_from_heart(owner.current)

/// checks if we're a brainmob inside a brain & the brain is inside a head
/datum/antagonist/bloodsucker/proc/is_head(mob/living/poor_fucker)
	if(!istype(poor_fucker?.loc, /obj/item/organ/internal/brain))
		return
	var/obj/brain = poor_fucker.loc
	if(!istype(brain?.loc, /obj/item/bodypart/head))
		return
	return brain.loc

// helper procs for damage checking, just in case a synth becomes one, let's them heal thesmelves
/datum/antagonist/bloodsucker/proc/getBruteLoss()
	var/mob/living/carbon/human/humie = owner.current
	return issynthetic(humie) ? humie.getBruteLoss() : humie.getBruteLoss_nonProsthetic()

/datum/antagonist/bloodsucker/proc/getFireLoss()
	var/mob/living/carbon/human/humie = owner.current
	return issynthetic(humie) ? humie.getFireLoss() : humie.getFireLoss_nonProsthetic()

/datum/antagonist/bloodsucker/proc/admin_set_blood(mob/admin)
	var/blood = tgui_input_number(admin, "What blood level to set [owner.current]'s to?", "Blood is life.", floor(bloodsucker_blood_volume), max_blood_volume, 0)
	// 0 input is falsey
	if(blood == null)
		return
	SetBloodVolume(blood)

/datum/antagonist/bloodsucker/proc/admin_rankup(mob/admin)
	to_chat(admin, span_notice("[owner.current] has been given a free level"))
	RankUp()

/datum/antagonist/bloodsucker/proc/admin_give_power(mob/admin)
	var/datum/action/cooldown/bloodsucker/power = tgui_input_list(admin, "What power to give [owner.current]?", "Might is right.", all_bloodsucker_powers)
	if(!power)
		return
	BuyPower(power)

/datum/antagonist/bloodsucker/proc/admin_remove_power(mob/admin)
	var/datum/action/cooldown/bloodsucker/power = tgui_input_list(admin, "What power to remove from [owner.current]?", "Might is right.", powers)
	if(!power)
		return
	RemovePower(power)

/datum/antagonist/bloodsucker/proc/admin_set_power_level(mob/admin)
	var/list/valid_powers = list()
	for(var/datum/action/cooldown/bloodsucker/power as anything in powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		valid_powers += power
	var/datum/action/cooldown/bloodsucker/power = tgui_input_list(admin, "What power to set the level of for [owner.current]?", "Might is right.", valid_powers)
	if(!power)
		return
	var/level = tgui_input_number(admin, "What level to set [power] to?", "Might is right.", power.level_current, 30, 0)
	if(level == null)
		return
	power.level_current = level
	power.on_power_upgrade()

/datum/antagonist/bloodsucker/proc/regain_heart(mob/coffin_dweller, obj/structure/closet/crate/coffin/coffin, mob/user)
	SIGNAL_HANDLER
	var/obj/item/organ/heart = locate(/obj/item/organ/internal/heart) in coffin.contents
	if(heart && !coffin_dweller.get_organ_slot(ORGAN_SLOT_HEART))
		to_chat(span_warning("You have regained your heart!"))
		heart.Insert(coffin_dweller)

/datum/antagonist/bloodsucker/proc/shake_head_on_talk(mob/speaker, speech_args)
	var/obj/head = is_head(speaker)
	if(!head)
		return
	var/animation_time = max(2, length_char(speech_args[SPEECH_MESSAGE]) * 0.5)
	head.Shake(duration = animation_time)
