///How much Blood it costs to live.
#define BLOODSUCKER_PASSIVE_BLOOD_DRAIN 0.1

/// Runs from COMSIG_LIVING_LIFE, handles Bloodsucker constant proccesses.
/datum/antagonist/bloodsucker/proc/LifeTick(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	if(!owner)
		INVOKE_ASYNC(src, PROC_REF(HandleDeath))
		return
	if(isbrain(owner.current))
		return
	if(HAS_TRAIT_FROM_ONLY(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT))
		check_end_torpor()
	// Deduct Blood
	if(owner.current.stat == CONSCIOUS && !HAS_TRAIT(owner.current, TRAIT_IMMOBILIZED) && !HAS_TRAIT_FROM_ONLY(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT))
		INVOKE_ASYNC(src, PROC_REF(AdjustBloodVolume), -BLOODSUCKER_PASSIVE_BLOOD_DRAIN) // -.1 currently
	if(HandleHealing())
		if((COOLDOWN_FINISHED(src, bloodsucker_spam_healing)) && bloodsucker_blood_volume > 0)
			to_chat(owner.current, span_notice("The power of your blood begins knitting your wounds..."))
			COOLDOWN_START(src, bloodsucker_spam_healing, BLOODSUCKER_SPAM_HEALING)
	// Standard Updates
	INVOKE_ASYNC(src, PROC_REF(HandleStarving))
	INVOKE_ASYNC(src, PROC_REF(update_blood))

	SEND_SIGNAL(src, COMSIG_BLOODSUCKER_ON_LIFETICK, seconds_per_tick, times_fired)

/datum/antagonist/bloodsucker/proc/on_death(mob/living/source, gibbed)
	SIGNAL_HANDLER
	RegisterSignal(owner.current, COMSIG_LIVING_REVIVE, PROC_REF(on_revive))
	RegisterSignal(src, COMSIG_BLOODSUCKER_ON_LIFETICK, PROC_REF(HandleDeath))

/datum/antagonist/bloodsucker/proc/on_revive(mob/living/source)
	SIGNAL_HANDLER
	UnregisterSignal(owner.current, COMSIG_LIVING_REVIVE)
	UnregisterSignal(src, COMSIG_BLOODSUCKER_ON_LIFETICK)

/**
 * ## BLOOD STUFF
 */

/datum/antagonist/bloodsucker/proc/GetBloodVolume()
	return bloodsucker_blood_volume

/datum/antagonist/bloodsucker/proc/AdjustBloodVolume(value)
	bloodsucker_blood_volume = clamp(bloodsucker_blood_volume + value, 0, max_blood_volume)
	update_blood_hud()

/datum/antagonist/bloodsucker/proc/SetBloodVolume(value)
	bloodsucker_blood_volume = clamp(value, 0, max_blood_volume)
	update_blood_hud()

#define MASQUERADE /datum/action/cooldown/bloodsucker/masquerade

/datum/antagonist/bloodsucker/proc/GetHumanityLost()
	return humanity_lost

/datum/antagonist/bloodsucker/proc/AddHumanityLost(value)
	if(value == 0)
		return
	var/has_masq = is_path_in_list(MASQUERADE, powers)
	if(value + humanity_lost >= HUMANITY_LOST_MAXIMUM)
		if(has_masq)
			RemovePowerByPath(MASQUERADE)
			to_chat(owner.current, span_warning("You hit the maximum amount of lost Humanty, you are far from Human. You've forgotten how to pretend to be like your prey..."))
		else
			to_chat(owner.current, span_hypnophrase("The Beast, it yearns for Blood..."))
	else if(!has_masq)
		BuyPower(MASQUERADE)
		to_chat(owner.current, span_hypnophrase("You've remembered, yet again, how it feels to live again."))
	humanity_lost = clamp(value, 0, HUMANITY_LOST_MAXIMUM)
	to_chat(owner.current, span_warning("You feel as if you [value < 0 ? "gained" : "lost" ] some of your humanity, you will now enter Frenzy at [FRENZY_THRESHOLD_ENTER + (humanity_lost * 10)] Blood."))

#undef MASQUERADE

/// mult: SILENT feed is 1/3 the amount
/datum/antagonist/bloodsucker/proc/handle_feeding(mob/living/carbon/target, mult=1, power_level)
	// Starts at 15 (now 8 since we doubled the Feed time)
	var/feed_amount = 15 + (power_level * 2)
	var/blood_taken = min(feed_amount, target.blood_volume) * mult
	target.blood_volume -= blood_taken

	///////////
	// Shift Body Temp (toward Target's temp, by volume taken)
	owner.current.bodytemperature = ((bloodsucker_blood_volume * owner.current.bodytemperature) + (blood_taken * target.bodytemperature)) / (bloodsucker_blood_volume + blood_taken)
	// our volume * temp, + their volume * temp, / total volume
	///////////
	// Reduce Value Quantity
	if(target.stat == DEAD) // Penalty for Dead Blood
		blood_taken /= 3
	if(!ishuman(target)) // Penalty for Non-Human Blood
		blood_taken /= 2
	// High level vampires get much less blood from mindless targets
	else if(bloodsucker_level >= BLOODSUCKER_HIGH_LEVEL && !target.mind)
		blood_taken /= 4
	else if(!target?.mind) // Penalty for Mindless Blood
		blood_taken /= 2
	//if (!iscarbon(target)) // Penalty for Animals (they're junk food)
	// Apply to Volume
	AdjustBloodVolume(blood_taken)
	// Reagents (NOT Blood!)
	if(target.reagents && target.reagents.total_volume)
		target.reagents.trans_to(owner.current, INGEST, 1) // Run transfer of 1 unit of reagent from them to me.
	owner.current.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, 1) // Play THIS sound for user only. The "null" is where turf would go if a location was needed. Null puts it right in their head.
	total_blood_drank += blood_taken
	return blood_taken

/**
 * ## HEALING
 */

/// Constantly runs on Bloodsucker's LifeTick, and is increased by being in Torpor/Coffins
/datum/antagonist/bloodsucker/proc/HandleHealing(mult = 1)
	var/actual_regen = bloodsucker_regen_rate + additional_regen
	// Don't heal if I'm staked or on Masquerade (+ not in a Coffin). Masqueraded Bloodsuckers in a Coffin however, will heal.
	if(owner.current.am_staked() || (HAS_TRAIT(owner.current, TRAIT_MASQUERADE) && !HAS_TRAIT_FROM_ONLY(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT)))
		return FALSE
	// Garlic in you? No healing for you!
	if(HAS_TRAIT(owner.current, TRAIT_GARLIC_REAGENT))
		return FALSE
	owner.current.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1 * actual_regen * mult) //adjustBrainLoss(-1 * (actual_regen * 4) * mult, 0)
	if(!iscarbon(owner.current)) // Damage Heal: Do I have damage to ANY bodypart?
		return FALSE
	var/mob/living/carbon/user = owner.current
	var/costMult = 1 // Coffin makes it cheaper
	// If you're a synth, you heal prosthetic damage.
	var/bruteLoss = getBruteLoss()
	var/bruteheal = min(bruteLoss, actual_regen) // BRUTE: Always Heal
	var/fireheal = 0 // BURN: Heal in Coffin while Fakedeath, or when damage above maxhealth (you can never fully heal fire)
	// Checks if you're in a coffin here, additionally checks for Torpor right below it.
	var/amInCoffin = istype(user.loc, /obj/structure/closet/crate/coffin)
	if(amInCoffin && HAS_TRAIT_FROM_ONLY(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT))
		if(HAS_TRAIT(owner.current, TRAIT_MASQUERADE) && (COOLDOWN_FINISHED(src, bloodsucker_spam_healing)))
			to_chat(user, span_alert("You do not heal while your Masquerade ability is active."))
			COOLDOWN_START(src, bloodsucker_spam_healing, BLOODSUCKER_SPAM_MASQUERADE)
			return FALSE
		fireheal = min(getFireLoss(), actual_regen)
		mult *= 5 // Increase multiplier if we're sleeping in a coffin.
		costMult /= 2 // Decrease cost if we're sleeping in a coffin.
		user.extinguish_mob()
		user.bodytemperature = user.get_body_temp_normal()
		if(ishuman(user))
			var/mob/living/carbon/human/humie = user
			humie.set_coretemperature(humie.get_body_temp_normal(apply_change = FALSE))
		user.remove_all_embedded_objects() // Remove Embedded!
		if(check_limbs(costMult))
			return TRUE
	// In Torpor, but not in a Coffin? Heal faster anyways.
	else if(HAS_TRAIT_FROM_ONLY(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT))
		var/fireloss = getFireLoss()
		fireheal = min(fireloss, actual_regen) / 1.2 // 20% slower than being in a coffin
		mult *= 3
	// Heal if Damaged
	if((bruteheal + fireheal) && mult != 0) // Just a check? Don't heal/spend, and return.
		// We have damage. Let's heal (one time)
		user.adjustBruteLoss(-bruteheal * mult) // Heal BRUTE / BURN in random portions throughout the body.
		user.adjustFireLoss(-fireheal * mult)
		AdjustBloodVolume(((bruteheal * -0.5) + (fireheal * -1)) * costMult * mult) // Costs blood to heal
		return TRUE

/datum/antagonist/bloodsucker/proc/check_limbs(costMult = 1)
	var/limb_regen_cost = 50 * -costMult
	var/mob/living/carbon/user = owner.current
	var/list/missing = user.get_missing_limbs()
	if(missing.len && (bloodsucker_blood_volume < limb_regen_cost + 5))
		return FALSE
	for(var/missing_limb in missing) //Find ONE Limb and regenerate it.
		user.regenerate_limb(missing_limb, FALSE)
		AdjustBloodVolume(-limb_regen_cost)
		var/obj/item/bodypart/missing_bodypart = user.get_bodypart(missing_limb) // 2) Limb returns Damaged
		missing_bodypart.brute_dam = missing_bodypart.max_damage
		to_chat(user, span_notice("Your flesh knits as it regrows your [missing_bodypart]!"))
		playsound(user, 'sound/magic/demon_consume.ogg', 50, TRUE)
		return TRUE

/*
 *	# Heal Vampire Organs
 *
 *	This is used by Bloodsuckers, these are the steps of this proc:
 *	Step 1 - Cure husking and Regenerate organs. regenerate_organs() removes their Vampire Heart & Eye augments, which leads us to...
 *	Step 2 - Repair any (shouldn't be possible) Organ damage, then return their Vampiric Heart & Eye benefits.
 *	Step 3 - Revive them, clear all wounds, remove any Tumors (If any).
 *
 *	This is called on Bloodsucker's Assign, and when they end Torpor.
 */
/// TODO: Separate this into smaller functions
/datum/antagonist/bloodsucker/proc/heal_vampire_organs(regenerate_heart = FALSE)
	var/mob/living/carbon/bloodsuckeruser = owner.current
	// please don't poison or asphyxiate the immune
	bloodsuckeruser.setToxLoss(0, forced = TRUE)
	bloodsuckeruser.setOxyLoss(0, forced = TRUE)
	if(!bloodsuckeruser)
		return
	if(HAS_TRAIT_FROM_ONLY(bloodsuckeruser, TRAIT_HUSK, CHANGELING_DRAIN) || bloodsuckeruser.has_status_effect(/datum/status_effect/gutted))
		to_chat(bloodsuckeruser, span_danger("Your immortal blood has healed your body from near-irrecoverable damage, but has used nearly all of your blood in doing so!"))
		AddHumanityLost(2)
		SetBloodVolume(min(bloodsucker_blood_volume, frenzy_enter_threshold() * 2))
		bloodsuckeruser.cure_husk(CHANGELING_DRAIN)
	bloodsuckeruser.cure_husk(BURN)
	if(regenerate_heart || bloodsuckeruser.get_organ_slot(ORGAN_SLOT_HEART))
		bloodsuckeruser.regenerate_organs(regenerate_existing = FALSE)
	if(!HAS_TRAIT(bloodsuckeruser, TRAIT_MASQUERADE))
		var/obj/item/organ/internal/heart/current_heart = bloodsuckeruser.get_organ_slot(ORGAN_SLOT_HEART)
		current_heart.Stop()
	var/obj/item/organ/internal/eyes/current_eyes = bloodsuckeruser.get_organ_slot(ORGAN_SLOT_EYES)
	if(current_eyes)
		current_eyes.flash_protect = max(initial(current_eyes.flash_protect) - 1, FLASH_PROTECTION_SENSITIVE)
		current_eyes.color_cutoffs = BLOODSUCKER_SIGHT_COLOR_CUTOFF
		current_eyes.sight_flags = SEE_MOBS
	bloodsuckeruser.update_sight()
	/// Disable gutting for the chest
	var/obj/item/bodypart/chest/target_chest = bloodsuckeruser.get_bodypart(BODY_ZONE_CHEST)
	if(target_chest && !(target_chest.bodypart_flags & BODYPART_UNREMOVABLE))
		target_chest.bodypart_flags |= BODYPART_UNREMOVABLE
	// Sometimes bloodsuckers can get into a loop of reviving and dying, if they somehow get a new body without being revived.
	if(_listen_lookup?[COMSIG_BLOODSUCKER_ON_LIFETICK] || bloodsuckeruser._listen_lookup?[COMSIG_LIVING_REVIVE])
		on_revive()
	if(bloodsuckeruser.stat == DEAD)
		bloodsuckeruser.revive()
	for(var/datum/wound/iter_wound as anything in bloodsuckeruser.all_wounds)
		iter_wound.remove_wound()
	// From [powers/panacea.dm]
	var/list/bad_organs = list(
		bloodsuckeruser.get_organ_by_type(/obj/item/organ/internal/body_egg),
		bloodsuckeruser.get_organ_by_type(/obj/item/organ/internal/zombie_infection)
	)
	for(var/tumors in bad_organs)
		var/obj/item/organ/yucky_organs = tumors
		if(!istype(yucky_organs))
			continue
		to_chat(bloodsuckeruser, span_warning("You feel a little ill for a moment, but it passes. Did you just cough up a tumor?"))
		yucky_organs.Remove(bloodsuckeruser)
		yucky_organs.forceMove(get_turf(bloodsuckeruser))

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			DEATH

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// FINAL DEATH
/datum/antagonist/bloodsucker/proc/HandleDeath()
	// Not "Alive"?
	if(!owner.current)
		FinalDeath()
		return
	// Fire Damage? (above double health)
	if(owner.current.getFireLoss() >= owner.current.maxHealth * 2.5)
		FinalDeath()
		return
	// Staked with a silver stake while "Temp Death" or Asleep
	if(owner.current.StakeCanKillMe())
		FinalDeath()
		return
	// Temporary Death? Convert to Torpor.
	if(HAS_TRAIT_FROM_ONLY(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT) || isbrain(owner.current))
		return
	// Won't torpor without vital organs, as this means they'd revive without a heart
	if(ishuman(owner.current))
		var/mob/living/carbon/human/humie = owner.current
		if(humie.dna.species.mutantheart && !owner.current.get_organ_slot(ORGAN_SLOT_HEART))
			return
	check_begin_torpor(TORPOR_SKIP_CHECK_ALL)

/datum/antagonist/bloodsucker/proc/HandleStarving() // I am thirsty for blood!
	// Nutrition - The amount of blood is how full we are.
	owner.current.set_nutrition(min(bloodsucker_blood_volume, NUTRITION_LEVEL_FED))

	// BLOOD_VOLUME_GOOD: [336] - Pale
//	handled in bloodsucker_integration.dm
	// BLOOD_VOLUME_EXIT: [250] - Exit Frenzy (If in one) This is high because we want enough to kill the poor soul they feed off of.
	var/datum/status_effect/frenzy/status_effect = owner.current.has_status_effect(/datum/status_effect/frenzy)
	if(bloodsucker_blood_volume >= frenzy_exit_threshold() && frenzied && status_effect?.duration == -1)
		status_effect.duration = world.time + 10 SECONDS
		owner.current.balloon_alert(owner.current, "Frenzy ends in 10 seconds!")
	// BLOOD_VOLUME_BAD: [224] - Jitter
	if(bloodsucker_blood_volume < BLOOD_VOLUME_BAD && prob(0.5) && !HAS_TRAIT_FROM_ONLY(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT) && !HAS_TRAIT(owner.current, TRAIT_MASQUERADE))
		owner.current.set_timed_status_effect(3 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	// BLOOD_VOLUME_SURVIVE: [122] - Blur Vision
	if(bloodsucker_blood_volume < BLOOD_VOLUME_SURVIVE)
		owner.current.set_eye_blur_if_lower((8 - 8 * (bloodsucker_blood_volume / BLOOD_VOLUME_BAD))*2 SECONDS)

	// The more blood, the better the Regeneration, get too low blood, and you enter Frenzy.
	if(bloodsucker_blood_volume < frenzy_enter_threshold() && !frenzied)
		owner.current.apply_status_effect(/datum/status_effect/frenzy)
	else if(bloodsucker_blood_volume < BLOOD_VOLUME_BAD)
		additional_regen = 0.1
	else if(bloodsucker_blood_volume < BLOOD_VOLUME_OKAY)
		additional_regen = 0.2
	else if(bloodsucker_blood_volume < BLOOD_VOLUME_NORMAL)
		additional_regen = 0.3
	else if(bloodsucker_blood_volume < BS_BLOOD_VOLUME_MAX_REGEN)
		additional_regen = 0.4
	else
		additional_regen = 0.5

/// Makes your blood_volume look like your bloodsucker blood, unless you're Masquerading.
/datum/antagonist/bloodsucker/proc/update_blood()
	if(HAS_TRAIT(owner.current, TRAIT_NOBLOOD))
		return
	//If we're on Masquerade, we appear to have full blood, unless we are REALLY low, in which case we don't look as bad.
	if(HAS_TRAIT(owner.current, TRAIT_MASQUERADE))
		switch(bloodsucker_blood_volume)
			if(BLOOD_VOLUME_OKAY to INFINITY) // 336 and up, we are perfectly fine.
				owner.current.blood_volume = initial(bloodsucker_blood_volume)
			if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY) // 224 to 336
				owner.current.blood_volume = BLOOD_VOLUME_SAFE
			else // 224 and below
				owner.current.blood_volume = BLOOD_VOLUME_OKAY
		return

	owner.current.blood_volume = bloodsucker_blood_volume

/// Turns the bloodsucker into a wacky talking head.
/datum/antagonist/bloodsucker/proc/talking_head()
	var/mob/living/poor_fucker = owner.current
	// Don't do anything if we're not actually inside a brain and a head
	if(!is_head(poor_fucker) || poor_fucker.stat != DEAD || !poor_fucker.can_be_revived())
		return
	// Ensure that the HUD updates (We might have lost the heart at some point)
	RegisterSignal(poor_fucker, COMSIG_LIVING_LIFE, PROC_REF(LifeTick), TRUE)
	poor_fucker.revive()
	poor_fucker.stat = CONSCIOUS
	to_chat(poor_fucker, span_warning("Your immortal [pick(list("blood", "curse"))] keeps your head alive! Though... what will you do now?"))
	// No lungs to speak, let's make it spooky
	poor_fucker.speech_span = SPAN_PAPYRUS

/// Gibs the Bloodsucker, roundremoving them.
/datum/antagonist/bloodsucker/proc/FinalDeath(check_organs = FALSE)
	SIGNAL_HANDLER
	// If we have no body, end here.
	if(!owner.current || isbrain(owner.current))
		return
	UnregisterSignal(src, list(
		COMSIG_BLOODSUCKER_ON_LIFETICK,
		COMSIG_LIVING_REVIVE,
		COMSIG_LIVING_LIFE,
		COMSIG_LIVING_DEATH,
	))
	UnregisterSignal(SSsunlight, list(
		COMSIG_SOL_RANKUP_BLOODSUCKERS,
		COMSIG_SOL_NEAR_START,
		COMSIG_SOL_END,
		COMSIG_SOL_RISE_TICK,
		COMSIG_SOL_WARNING_GIVEN,
	))
	free_all_vassals()
	DisableAllPowers(forced = TRUE)
	if(!iscarbon(owner.current))
		owner.current.gib(DROP_ITEMS)
		return
	// Drop anything in us and play a tune
	var/mob/living/carbon/user = owner.current
	owner.current.drop_all_held_items()
	owner.current.unequip_everything()
	user.remove_all_embedded_objects()
	playsound(owner.current, 'sound/effects/tendril_destroyed.ogg', 40, TRUE)

	var/unique_death = SEND_SIGNAL(src, BLOODSUCKER_FINAL_DEATH)
	if(unique_death & DONT_DUST)
		return

	// Elders get dusted, Fledglings get gibbed.
	if(bloodsucker_level >= 4)
		user.visible_message(
			span_warning("[user]'s skin crackles and dries, their skin and bones withering to dust. A hollow cry whips from what is now a sandy pile of remains."),
			span_userdanger("Your soul escapes your withering body as the abyss welcomes you to your Final Death."),
			span_hear("You hear a dry, crackling sound."))
		addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living, dust)), 5 SECONDS, TIMER_UNIQUE|TIMER_STOPPABLE)
		return
	user.visible_message(
		span_warning("[user]'s skin bursts forth in a spray of gore and detritus. A horrible cry echoes from what is now a wet pile of decaying meat."),
		span_userdanger("Your soul escapes your withering body as the abyss welcomes you to your Final Death."),
		span_hear("<span class='italics'>You hear a wet, bursting sound."))
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living, gib), DROP_ITEMS), 2 SECONDS, TIMER_UNIQUE|TIMER_STOPPABLE)
	user.investigate_log("Died as a bloodsucker from Final Death.", INVESTIGATE_DEATHS)

#undef BLOODSUCKER_PASSIVE_BLOOD_DRAIN
