#define FEED_NOTICE_RANGE 2
#define FEED_DEFAULT_TIMER (10 SECONDS)
#define FEED_MIN_TIMER (1 SECONDS)

/datum/action/cooldown/bloodsucker/feed
	name = "Feed"
	desc = "Feed blood off of a living creature. Feeding while aggressively grabbing them will put them to sleep for a short moment."
	button_icon_state = "power_feed"
	power_explanation = list(
		"Activate Feed while next to someone and you will begin to feed blood off of them.",
		"The time needed before you start feeding speeds up the higher level you are.",
		"Feeding off of someone next to you will not be noticed by the victim, but it will by nearby onlookers",
		"Feeding off of someone while you have them aggressively grabbed will put them to sleep.",
		"While feeding, you can't speak, as your mouth is covered.",
		"Feeding while nearby (2 tiles away from) a mortal who is unaware of Bloodsuckers' existence, will cause a Masquerade Infraction",
		"If you get too many Masquerade Infractions, you will break the Masquerade.",
		"If you are in desperate need of blood, mice can be fed off of, at a cost.",
		"You must use the ability again to stop sucking blood.",
	)
	level_current = -1 // scales itself based on your actual level, since you always have it
	power_flags = BP_CONTINUOUS_EFFECT|BP_AM_STATIC_COOLDOWN
	bloodsucker_check_flags = BP_CANT_USE_IN_TORPOR|BP_CAN_USE_WHILE_STAKED|BP_CAN_USE_HEARTLESS
	purchase_flags = BLOODSUCKER_DEFAULT_POWER
	bloodcost = 0
	cooldown_time = 15 SECONDS

	COOLDOWN_DECLARE(feed_movement_notify_cooldown)
	///Amount of blood taken, reset after each Feed. Used for logging.
	var/blood_taken = 0
	///The amount of Blood a target has since our last feed, this loops and lets us not spam alerts of low blood.
	var/warning_target_bloodvol = BLOOD_VOLUME_MAX_LETHAL
	///Reference to the target we've fed off of
	var/datum/weakref/target_ref
	///Have we notified you already that you are at maximum blood?
	var/notified_overfeeding = FALSE
	///assoc list of weakrefs to targets and how much blood we've taken from them.
	var/list/targets_and_blood = list()
	/// What level of protection you need to prevent feeding
	var/penetration = NONE
	///Did we start feeding with aggressive grab or not, or grabbed by someone else?
	var/aggressive_feed = TRUE

/datum/action/cooldown/bloodsucker/feed/get_power_explanation_extended()
	. = list()
	. += "Activate Feed while next to someone and you will begin to feed blood off of them."
	. += "The time needed before you start feeding is [DisplayTimeText(get_feed_start_time())]."
	. += "Feeding off of someone while you have them aggressively grabbed will put them to sleep for [DisplayTimeText(get_sleep_time())]."
	. += "While feeding, you can't speak, as you are using your mouth to drink blood."
	. += "Feeding while nearby ([FEED_NOTICE_RANGE] tiles away from) a mortal who is unaware of Bloodsuckers' existence, will cause a Masquerade Infraction"
	. += "If you get too many Masquerade Infractions, you will break the Masquerade."
	. += "If you are in desperate need of blood, mice can be fed off of, at a cost to your humanity."
	. += "If you are handcuffed, you can use feed to feed off whoever is grabbing you, however this is slower, and very obvious."
	. += "You must use the ability again to stop sucking blood."

/datum/action/cooldown/bloodsucker/feed/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/target = target_ref?.resolve()
	if(target) //already sucking blood.
		var/aggro_feed = check_aggro_feed(target)
		if(!ContinueActive(user, target, aggro_feed))
			target_ref = null
		else
			owner.balloon_alert(owner, "already feeding!")
			return FALSE
	if(user.is_mouth_covered() && !isplasmaman(user))
		owner.balloon_alert(owner, "mouth covered!")
		return FALSE
	//Find target, it will alert what the problem is, if any.
	if(!find_target())
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/feed/ContinueActive(mob/living/user, mob/living/target, check_aggresive_grab)
	if(!target)
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	if(check_aggresive_grab && !check_aggro_feed(target))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/feed/DeactivatePower(deactivate_flags)
	// run before parent checks just to ensure that this always gets cleaned up
	UnregisterSignal(owner, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE)
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, FEED_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_MUTE, FEED_TRAIT)
	. = ..()
	if(!.)
		return
	var/mob/living/user = owner
	var/mob/living/feed_target = target_ref?.resolve()

	if(!blood_taken)
		return
	if(isnull(feed_target) && blood_taken)
		log_combat(user, user, "fed on blood (target not found)", addition="(and took [blood_taken] blood)")
	else
		log_combat(user, feed_target, "fed on blood", addition="(and took [blood_taken] blood)")
		to_chat(user, span_notice("You slowly release [feed_target]."))
		if(feed_target.client && feed_target.stat == DEAD)
			user.add_mood_event("drankkilled", /datum/mood_event/drankkilled)
			bloodsuckerdatum_power?.AddHumanityLost(5)

	target_ref = null
	warning_target_bloodvol = initial(warning_target_bloodvol)
	blood_taken = initial(blood_taken)
	notified_overfeeding = initial(notified_overfeeding)

/datum/action/cooldown/bloodsucker/feed/ActivatePower(atom/target)
	// if this happens this means that we didn't properly deactivate the power
	if(HAS_TRAIT_FROM(owner, TRAIT_IMMOBILIZED, FEED_TRAIT) || HAS_TRAIT_FROM(owner, TRAIT_MUTE, FEED_TRAIT))
		DeactivatePower()
	var/mob/living/feed_target = target_ref?.resolve()
	if(!feed_target)
		DeactivatePower()
		return FALSE
	if(istype(feed_target, /mob/living/basic/mouse))
		to_chat(owner, span_notice("You recoil at the taste of a lesser lifeform."))
		if(snobby_drinking_check())
			var/mob/living/user = owner
			user.add_mood_event("drankblood", /datum/mood_event/drankblood_bad)
			bloodsuckerdatum_power?.AddHumanityLost(1)
		bloodsuckerdatum_power?.AdjustBloodVolume(25)
		feed_target.death()
		StartCooldown()
		return FALSE

	owner.balloon_alert(owner, "feeding off [feed_target]...")
	owner.face_atom(feed_target)
	if(!do_after(owner, get_feed_start_time(), feed_target, hidden = TRUE))
		owner.balloon_alert(owner, "feed stopped")
		target_ref = null
		return FALSE
	if(check_aggro_feed(feed_target))
		aggressive_feed = TRUE
		if(!IS_BLOODSUCKER(feed_target) && !IS_GHOUL(feed_target) && !IS_MONSTERHUNTER(feed_target))
			feed_target.Unconscious(get_sleep_time())
		if(!feed_target.density)
			feed_target.Move(owner.loc)
		owner.visible_message(
			span_warning("[owner] closes [owner.p_their()] mouth around [feed_target]'s neck!"),
			span_warning("You sink your fangs into [feed_target]'s neck."))
	else
		aggressive_feed = FALSE
		// Only people who AREN'T the target will notice this action.
		var/dead_message = feed_target.stat != DEAD ? " <i>[feed_target.p_they(TRUE)] looks dazed, and will not notice this.</i>" : ""
		owner.visible_message(
			span_warning("[owner] puts [feed_target]'s wrist up to [owner.p_their()] mouth."),
			span_notice("You slip your fangs into [feed_target]'s wrist.[dead_message]"),
			vision_distance = FEED_NOTICE_RANGE, ignored_mobs = feed_target
		)

	check_if_seen(feed_target)

	ADD_TRAIT(owner, TRAIT_MUTE, FEED_TRAIT)
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, FEED_TRAIT)
	RegisterSignal(owner, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE, PROC_REF(notify_move_block))
	return TRUE

/datum/action/cooldown/bloodsucker/feed/proc/check_if_seen(mob/living/feed_target)
	for(var/mob/living/watchers in oviewers(FEED_NOTICE_RANGE) - feed_target)
		if(!watchers.client)
			continue
		if(watchers.has_unlimited_silicon_privilege)
			continue
		if(watchers.stat >= DEAD)
			continue
		if(watchers.is_blind() || watchers.is_nearsighted_currently())
			continue
		if(IS_BLOODSUCKER(watchers) || IS_GHOUL(watchers) || HAS_TRAIT(watchers.mind, TRAIT_BLOODSUCKER_HUNTER))
			continue
		owner.balloon_alert(owner, "feed noticed!")
		bloodsuckerdatum_power?.give_masquerade_infraction()
		break

/datum/action/cooldown/bloodsucker/feed/process(seconds_per_tick)
	if(!active) //If we aren't active (running on SSfastprocess)
		return ..() //Manage our cooldown timers
	var/mob/living/user = owner
	var/mob/living/feed_target = target_ref?.resolve()
	if(!feed_target)
		DeactivatePower()
		return
	if(!ContinueActive(user, feed_target, aggressive_feed))
		if(aggressive_feed)
			user.visible_message(
				span_warning("[user] is ripped from [feed_target]'s throat. [feed_target.p_Their(TRUE)] blood sprays everywhere!"),
				span_warning("Your teeth are ripped from [feed_target]'s throat. [feed_target.p_Their(TRUE)] blood sprays everywhere!")
			)
			// Deal Damage to Target (should have been more careful!)
			if(iscarbon(feed_target))
				var/mob/living/carbon/carbon_target = feed_target
				carbon_target.bleed(15)
			playsound(get_turf(feed_target), 'sound/effects/splat.ogg', 40, TRUE)
			if(ishuman(feed_target))
				var/mob/living/carbon/human/target_user = feed_target
				var/obj/item/bodypart/head_part = target_user.get_bodypart(BODY_ZONE_HEAD)
				if(head_part)
					head_part.generic_bleedstacks += 5
			feed_target.add_splatter_floor(get_turf(feed_target))
			user.add_mob_blood(feed_target) // Put target's blood on us. The donor goes in the ( )
			feed_target.add_mob_blood(feed_target)
			feed_target.apply_damage(10, BRUTE, BODY_ZONE_HEAD, wound_bonus = CANT_WOUND)
			INVOKE_ASYNC(feed_target, TYPE_PROC_REF(/mob, emote), "scream")
		DeactivatePower()
		return

	var/feed_strength_mult = 0.3
	if(aggressive_feed)
		feed_strength_mult = 1
	if(bloodsuckerdatum_power?.frenzied)
		feed_strength_mult *= 2

	var/already_drunk = targets_and_blood[target_ref] || 0
	var/blood_eaten = drink_blood(feed_target, feed_strength_mult, level_current, already_drunk)
	blood_taken += blood_eaten
	targets_and_blood[target_ref] += blood_eaten
	modify_blood_drunk(blood_eaten * 0.5)

	if(feed_target.mind)
		user.add_mood_event("drankblood", /datum/mood_event/drankblood)
	// Drank mindless as Ventrue? - BAD
	else if(snobby_drinking_check())
		user.add_mood_event("drankblood", /datum/mood_event/drankblood_bad)
	if(feed_target.stat >= DEAD)
		user.add_mood_event("drankblood", /datum/mood_event/drankblood_dead)

	if(!IS_BLOODSUCKER(feed_target))
		if(feed_target.blood_volume <= BLOOD_VOLUME_BAD && warning_target_bloodvol > BLOOD_VOLUME_BAD)
			owner.balloon_alert(owner, "your victim's blood is fatally low!")
		else if(feed_target.blood_volume <= BLOOD_VOLUME_OKAY && warning_target_bloodvol > BLOOD_VOLUME_OKAY)
			owner.balloon_alert(owner, "your victim's blood is dangerously low.")
		else if(feed_target.blood_volume <= BLOOD_VOLUME_SAFE && warning_target_bloodvol > BLOOD_VOLUME_SAFE)
			owner.balloon_alert(owner, "your victim's blood is at an unsafe level.")
		else if(feed_target.blood_volume <= BLOOD_VOLUME_SAFE && owner.pulling != feed_target)
			owner.balloon_alert(owner, "you cannot drink more without first getting a better grip!.")
			DeactivatePower()
			return
		warning_target_bloodvol = feed_target.blood_volume

	if(max_blood_reached(feed_target))
		var/message = "full on blood!"
		var/can_overfeed = can_overfeed()
		if(can_overfeed)
			message += " Anything more we drink now will be burnt on quicker healing"
		user.balloon_alert(owner, message)
		if(!can_overfeed)
			DeactivatePower()
			return
		notified_overfeeding = TRUE
	if(feed_target.blood_volume <= 0)
		user.balloon_alert(owner, "no blood left!")
		DeactivatePower()
		return
	owner.playsound_local(get_turf(owner), 'sound/effects/singlebeat.ogg', 40, TRUE)
	//play sound to target to show they're dying.
	if(aggressive_feed)
		feed_target.playsound_local(get_turf(src), 'sound/effects/singlebeat.ogg', 40, TRUE)

/datum/action/cooldown/bloodsucker/feed/proc/drink_blood(mob/living/feed_target, feed_strength_mult, level_current, already_drunk)
	// overridden in bloodsucker power.dm
	var/feed_amount = 15 + (level_current * 2)
	var/max_drink = feed_amount * feed_strength_mult
	var/blood_eatable = min(max_drink, feed_target.blood_volume)
	var/owner_blood_volume = 0

	blood_eatable = apply_drink_modifiers(feed_target, blood_eatable)

	var/sigval = SEND_SIGNAL(owner, COMSIG_MOB_FEED_DRINK, feed_target, blood_eatable, already_drunk)

	if(!(sigval & FEED_CANCEL_BLOOD_TRANSFER))
		if(IS_BLOODSUCKER(owner))
			bloodsuckerdatum_power.handle_feeding(feed_target, blood_eatable, already_drunk)
			owner_blood_volume = bloodsuckerdatum_power.GetBloodVolume()

		else if(isliving(owner) && !HAS_TRAIT(owner, TRAIT_NOBLOOD))
			var/mob/living/living_owner = owner
			living_owner.blood_volume += blood_eatable
			owner_blood_volume = living_owner.blood_volume

	if(feed_target.reagents && feed_target.reagents.total_volume)
		feed_target.reagents.trans_to(owner, INGEST, 1) // Run transfer of 1 unit of reagent from them to me.
	feed_target.blood_volume = max(0, feed_target.blood_volume - blood_eatable)

	if(owner_blood_volume > 0)
		owner.bodytemperature = ((owner_blood_volume * owner.bodytemperature) + (blood_eatable * feed_target.bodytemperature)) / (owner_blood_volume + blood_eatable)
	return blood_eatable

/datum/action/cooldown/bloodsucker/feed/proc/apply_drink_modifiers(mob/living/feed_target, blood_eatable)
	if(feed_target.stat == DEAD) // Penalty for Dead Blood
		blood_eatable /= 3
	if(!ishuman(feed_target)) // Penalty for Non-Human Blood
		blood_eatable /= 2
	else if(!feed_target?.mind) // Penalty for Mindless Blood
		blood_taken /= 2
	return blood_eatable

/datum/action/cooldown/bloodsucker/feed/proc/check_aggro_feed(mob/living/feed_target)
	var/mob/living/carbon/carbon = owner
	if(owner.pulling != feed_target && owner.pulledby != feed_target \
	|| (feed_target.pulledby != owner && iscarbon(carbon) && carbon.handcuffed))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/feed/proc/max_blood_reached(mob/living/feed_target)
	if(bloodsuckerdatum_power && bloodsuckerdatum_power.GetBloodVolume() >= bloodsuckerdatum_power.max_blood_volume && !notified_overfeeding)
		return TRUE
	if(HAS_TRAIT(owner, TRAIT_NOBLOOD))
		return FALSE
	var/sigval = SEND_SIGNAL(owner, COMSIG_MOB_REACHED_MAX_BLOOD, feed_target)
	if(sigval & REACHED_MAX_BLOOD)
		return TRUE
	if(astype(owner, /mob/living).blood_volume >= BLOOD_VOLUME_MAXIMUM)
		return TRUE
	return FALSE

/datum/action/cooldown/bloodsucker/proc/snobby_drinking_check()
	if(bloodsuckerdatum_power?.my_clan && bloodsuckerdatum_power.my_clan.blood_drink_type != BLOODSUCKER_DRINK_INHUMANELY)
		return TRUE
	return TRUE

/datum/action/cooldown/bloodsucker/feed/proc/find_target()
	// grabbing or grabbed, you're close enough to bite.
	if(safe_set_target(owner.pulling))
		return TRUE
	if(safe_set_target(owner.pulledby))
		return TRUE
	if(bloodsuckerdatum_power?.frenzied)
		owner.balloon_alert(owner, "beast active! must grab someone to feed!")
		return FALSE
	var/mob/living/carbon/carbon = owner
	if(iscarbon(carbon) && carbon.handcuffed)
		owner.balloon_alert(owner, "you cannot stealthily feed while handcuffed!")
		return FALSE
	var/list/close_living_mobs = list()
	var/list/close_dead_mobs = list()
	for(var/mob/living/near_targets in oview(1, owner))
		if(!owner.Adjacent(near_targets))
			continue
		if(near_targets.stat)
			close_living_mobs |= near_targets
		else
			close_dead_mobs |= near_targets
	//Check living first
	for(var/mob/living/suckers in close_living_mobs)
		if(can_feed_from(suckers))
			set_target(suckers)
			return TRUE
	//If not, check dead
	for(var/mob/living/suckers in close_dead_mobs)
		if(can_feed_from(suckers))
			set_target(suckers)
			return TRUE
	//No one to suck blood from.
	return FALSE

/datum/action/cooldown/bloodsucker/feed/proc/safe_set_target(mob/living/target, give_warnings = TRUE)
	if(!can_feed_from(target, give_warnings))
		return FALSE
	set_target(target)
	return TRUE

// this lets us compare and access things by weakrefs, if we use the actual same weakref instance in the assoc list
/datum/action/cooldown/bloodsucker/feed/proc/set_target(mob/living/target)
	if(!length(targets_and_blood))
		target_ref = WEAKREF(target)
		return

	for(var/datum/weakref/weakref as anything in targets_and_blood)
		var/mob/living/old_target = weakref.resolve()
		if(old_target == target)
			target_ref = weakref
			break
	if(!target_ref)
		target_ref = WEAKREF(target)

/datum/action/cooldown/bloodsucker/feed/proc/can_feed_from(mob/living/target, give_warnings = FALSE)
	if(istype(target, /mob/living/basic/mouse))
		if(snobby_drinking_check())
			if(give_warnings)
				owner.balloon_alert(owner, "too disgusting!")
			return FALSE
		return TRUE
	//Mice check done, only humans are otherwise allowed
	if(!ishuman(target))
		return FALSE

	var/mob/living/carbon/human/target_user = target
	if(!(target_user.dna?.species) || !(target_user.mob_biotypes & MOB_ORGANIC) || HAS_TRAIT(target_user, TRAIT_NOBLOOD))
		if(give_warnings)
			owner.balloon_alert(owner, "no blood!")
		return FALSE
	if(!target_user.can_inject(owner, BODY_ZONE_HEAD, penetration))
		if(give_warnings)
			owner.balloon_alert(owner, "headgear too thick!")
		return FALSE
	if(!can_overfeed() && max_blood_reached(target_user))
		if(give_warnings)
			owner.balloon_alert(owner, "too full to drink more!")
		return FALSE
	if(!target.mind && !can_drink_from_mindless(target_user))
		if(give_warnings)
			owner.balloon_alert(owner, "cant drink from mindless!")
		return FALSE
	if(target_user.has_reagent(/datum/reagent/consumable/garlic, 5))
		if(give_warnings)
			owner.balloon_alert(owner, "too much garlic!")
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/feed/proc/can_drink_from_mindless(mob/living/target)
	if(!bloodsuckerdatum_power?.my_clan)
		return TRUE
	if(snobby_drinking_check() && !bloodsuckerdatum_power.frenzied)
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/feed/proc/get_sleep_time()
	return (5 + bloodsuckerdatum_power?.GetRank() || 1) SECONDS

/datum/action/cooldown/bloodsucker/feed/proc/get_feed_start_time()
	var/bloodsucker_level_divider = 1.25 * (bloodsuckerdatum_power?.GetRank() || 1)
	var/feed_time = FEED_DEFAULT_TIMER / bloodsucker_level_divider
	if(bloodsuckerdatum_power?.frenzied)
		feed_time *= 0.5
	var/mob/living/carbon/carbon = owner
	if(iscarbon(carbon) && carbon.handcuffed)
		feed_time *= 2
	return clamp(round(feed_time), FEED_MIN_TIMER, FEED_DEFAULT_TIMER)

/datum/action/cooldown/bloodsucker/feed/proc/notify_move_block()
	SIGNAL_HANDLER
	if(!active)
		DeactivatePower()
		return
	if (!COOLDOWN_FINISHED(src, feed_movement_notify_cooldown))
		return
	COOLDOWN_START(src, feed_movement_notify_cooldown, 3 SECONDS)
	owner.balloon_alert(owner, "you cannot move while feeding! Click the power to stop.")

/datum/action/cooldown/bloodsucker/feed/proc/modify_blood_drunk(amount = 0)
	for(var/datum/weakref/weakref as anything in targets_and_blood)
		if(weakref == target_ref)
			continue
		targets_and_blood[weakref] = max(0, targets_and_blood[weakref] - amount)
		if(targets_and_blood[weakref] <= 0)
			targets_and_blood -= weakref

/datum/action/cooldown/bloodsucker/feed/proc/can_overfeed()
	return IS_BLOODSUCKER(owner)


#undef FEED_NOTICE_RANGE
#undef FEED_DEFAULT_TIMER
#undef FEED_MIN_TIMER



