
#define BRAWN_BREAKOUT_LEVEL 3
#define BRAWN_AIRLOCK_LEVEL 4
/datum/action/cooldown/bloodsucker/targeted/brawn
	name = "Brawn"
	desc = "Snap restraints, break lockers and doors at higher levels, or deal terrible damage with your bare hands."
	button_icon_state = "power_strength"
	purchase_flags = BLOODSUCKER_CAN_BUY|GHOUL_CAN_BUY
	bloodcost = 10
	cooldown_time = 12 SECONDS
	target_range = 1
	prefire_message = "Select a target."

/datum/action/cooldown/bloodsucker/targeted/brawn/get_power_explanation_extended()
	. = list()
	. += "Click any person to bash into them, break restraints you have or knocking a grabber down. Only one of these can be done per use."
	. += "Brawn will do [GetDamage()] brute damage to the target and knockdown them for [DisplayTimeText(GetKnockdown())]."
	. += "Punching a Cyborg will heavily EMP them in addition to deal damage."
	. += "At level [BRAWN_BREAKOUT_LEVEL], you get the ability to break closets open, additionally can both break restraints AND knock a grabber down in the same use."
	. += "At level [BRAWN_AIRLOCK_LEVEL], you get the ability to bash airlocks open, as long as they aren't bolted."
	. += "Higher levels will increase the damage and knockdown when punching someone."

/datum/action/cooldown/bloodsucker/targeted/brawn/ActivatePower(atom/target)
	// Did we break out of our handcuffs?
	if(break_restraints())
		playsound(get_turf(owner), 'sound/effects/grillehit.ogg', 80, 1, -1)
		PowerActivatedSuccesfully()
		return FALSE
	// Did we knock a grabber down? We can only do this while not also breaking restraints if strong enough.
	if(owner.pulledby)
		if(level_current >= BRAWN_BREAKOUT_LEVEL && escape_puller())
			PowerActivatedSuccesfully()
			return FALSE
		owner.balloon_alert(owner, "ability level too low to break free!")
	// Did neither, now we can PUNCH.
	if(HAS_TRAIT(owner, TRAIT_HANDS_BLOCKED))
		owner.balloon_alert(owner, "your hands are blocked!")
		return FALSE
	// check if we have atleast one arm
	if(!owner.get_active_hand())
		owner.balloon_alert(owner, "you need a usable arm!")
		return FALSE
	return TRUE

// Look at 'biodegrade.dm' for reference
/datum/action/cooldown/bloodsucker/targeted/brawn/proc/break_restraints()
	var/mob/living/carbon/human/user = owner
	///Only one form of shackles removed per use
	var/obj/handcuffed = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	if(user.buckled && handcuffed && user.buckled.unbuckle_mob(user))
		user.visible_message(
			span_warning("[user] breaks free of [user.buckled]!"),
			span_warning("We break free of [user.buckled]!"),
		)
		user.buckled = null
		return TRUE

	// Breaks out of lockers
	if(istype(user.loc, /obj/structure/closet))
		var/obj/structure/closet/closet = user.loc
		if(!istype(closet))
			return FALSE
		closet.visible_message(
			span_warning("[closet] tears apart as [user] bashes it open from within!"),
			span_warning("[closet] tears apart as you bash it open from within!"),
		)
		to_chat(user, span_warning("We bash [closet] wide open!"))
		addtimer(CALLBACK(src, PROC_REF(break_closet), user, closet), 1)
		return TRUE

	// Remove both Handcuffs & Legcuffs in one step
	var/legcuffed = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	if(handcuffed || legcuffed)
		var/hand_cuffs = user.clear_cuffs(handcuffed, TRUE)
		var/leg_cuffs = user.clear_cuffs(legcuffed, TRUE)
		if(hand_cuffs || leg_cuffs)
			user.visible_message(
				span_warning("[user] discards their restraints like it's nothing!"),
				span_warning("We break through our restraints!"),
			)
			return TRUE

	// Remove Straightjackets
	if(user.wear_suit?.breakouttime)
		var/obj/item/clothing/suit/straightjacket = user.get_item_by_slot(ITEM_SLOT_OCLOTHING)
		user.visible_message(
			span_warning("[user] rips straight through the [user.p_their()] [straightjacket]!"),
			span_warning("We tear through our [straightjacket]!"),
		)
		if(straightjacket && user.wear_suit == straightjacket)
			qdel(straightjacket)
			return TRUE
	return FALSE

// This is its own proc because its done twice, to repeat code copypaste.
/datum/action/cooldown/bloodsucker/targeted/brawn/proc/break_closet(mob/living/carbon/human/user, obj/structure/closet/closet)
	if(closet)
		closet.welded = FALSE
		closet.locked = FALSE
		closet.broken = TRUE
		closet.open()

/datum/action/cooldown/bloodsucker/targeted/brawn/proc/escape_puller()
	var/mob/pulled_mob = owner.pulledby
	var/pull_power = pulled_mob.grab_state
	playsound(get_turf(pulled_mob), 'sound/effects/woodhit.ogg', 75, 1, -1)
	// Knock Down (if Living)
	if(isliving(pulled_mob))
		var/mob/living/hit_target = pulled_mob
		hit_target.Knockdown(pull_power * 10 + 20)
	// Knock Back (before Knockdown, which probably cancels pull)
	var/send_dir = get_dir(owner, pulled_mob)
	var/turf/turf_thrown_at = get_ranged_target_turf(pulled_mob, send_dir, pull_power)
	owner.newtonian_move(send_dir) // Bounce back in 0 G
	pulled_mob.throw_at(turf_thrown_at, pull_power, TRUE, owner, FALSE) // Throw distance based on grab state! Harder grabs punished more aggressively.
	// /proc/log_combat(atom/user, atom/target, what_done, atom/object=null, addition=null)
	log_combat(owner, pulled_mob, "used Brawn power")
	owner.visible_message(
		span_warning("[owner] tears free of [pulled_mob]'s grasp!"),
		span_warning("You shrug off [pulled_mob]'s grasp!"),
	)
	owner.pulledby = null // It's already done, but JUST IN CASE.
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/brawn/FireTargetedPower(atom/target, params)
	. = ..()
	var/mob/living/user = owner
	// Target Type: Mob
	if(isliving(target))
		var/mob/living/target_atom = target
		//You know what I'm just going to take the average of the user's limbs max damage instead of dealing with 2 hands
		var/hitStrength = GetDamage()
		// Knockdown!
		var/powerlevel = GetPowerLevel()
		if(rand(5 + powerlevel) >= 5)
			target_atom.visible_message(
				span_danger("[user] lands a vicious punch, sending [target_atom] away!"), \
				span_userdanger("[user] has landed a horrifying punch on you, sending you flying!"),
			)
			target_atom.Knockdown(GetKnockdown())
		// Attack!
		owner.balloon_alert(owner, "you punch [target_atom]!")
		playsound(get_turf(target_atom), 'sound/items/weapons/punch4.ogg', 60, 1, -1)
		user.do_attack_animation(target_atom, ATTACK_EFFECT_SMASH)
		var/obj/item/bodypart/affecting = target_atom.get_bodypart(ran_zone(target_atom.zone_selected))
		target_atom.apply_damage(hitStrength, BRUTE, affecting)
		// Knockback
		var/send_dir = get_dir(owner, target_atom)
		var/turf/turf_thrown_at = get_ranged_target_turf(target_atom, send_dir, powerlevel)
		owner.newtonian_move(send_dir) // Bounce back in 0 G
		target_atom.throw_at(turf_thrown_at, powerlevel, TRUE, owner) //new /datum/forced_movement(target_atom, get_ranged_target_turf(target_atom, send_dir, (hitStrength / 4)), 1, FALSE)
		// Target Type: Cyborg (Also gets the effects above)
		if(issilicon(target_atom))
			target_atom.emp_act(EMP_HEAVY)
	// Target Type: Locker
	else if(istype(target, /obj/structure/closet))
		if(level_current <= BRAWN_BREAKOUT_LEVEL)
			target.balloon_alert(user, "ability level too low to break open!")
			return FALSE
		var/obj/structure/closet/target_closet = target
		user.balloon_alert(user, "you prepare to bash [target_closet] open...")
		if(!do_after(user, 2.5 SECONDS, target_closet))
			user.balloon_alert(user, "interrupted!")
			return FALSE
		target_closet.visible_message(span_danger("[target_closet] breaks open as [user] bashes it!"))
		addtimer(CALLBACK(src, PROC_REF(break_closet), user, target_closet), 1)
		playsound(get_turf(user), 'sound/effects/grillehit.ogg', 80, TRUE, -1)
	// Target Type: Door
	else if(istype(target, /obj/machinery/door))
		if(level_current <= BRAWN_AIRLOCK_LEVEL)
			target.balloon_alert(user, "ability level too low to break open!")
			return FALSE
		var/obj/machinery/door/target_airlock = target
		playsound(get_turf(user), 'sound/machines/airlock/airlock_alien_prying.ogg', 40, TRUE, -1)
		owner.balloon_alert(owner, "you prepare to tear open [target_airlock]...")
		if(!do_after(user, 2.5 SECONDS, target_airlock))
			user.balloon_alert(user, "interrupted!")
			return FALSE
		if(target_airlock.Adjacent(user))
			target_airlock.visible_message(span_danger("[target_airlock] breaks open as [user] bashes it!"))
			user.Stun(10)
			user.do_attack_animation(target_airlock, ATTACK_EFFECT_SMASH)
			playsound(get_turf(target_airlock), 'sound/effects/bang.ogg', 30, 1, -1)
			target_airlock.open(2) // open(2) is like a crowbar or jaws of life.

/datum/action/cooldown/bloodsucker/targeted/brawn/proc/GetPowerLevel()
	return min(5, 1 + level_current)

/datum/action/cooldown/bloodsucker/targeted/brawn/proc/GetKnockdown()
	return min(5, rand(10, 10 * GetPowerLevel()))

/datum/action/cooldown/bloodsucker/targeted/brawn/proc/GetDamage()
	var/mob/living/carbon/human/user = owner
	var/obj/item/bodypart/user_active_arm
	user_active_arm = user.get_active_hand()
	if(!user || !user_active_arm)
		return GetPunchDamage(initial(user_active_arm.unarmed_damage_high))
	return GetPunchDamage(user_active_arm.unarmed_damage_high)

/datum/action/cooldown/bloodsucker/targeted/brawn/proc/GetPunchDamage(punch_damage)
	return punch_damage * 1.25 + 2

/datum/action/cooldown/bloodsucker/targeted/brawn/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	return isliving(target_atom) || istype(target_atom, /obj/machinery/door) || istype(target_atom, /obj/structure/closet)

/datum/action/cooldown/bloodsucker/targeted/brawn/CheckCanTarget(atom/target_atom)
	// DEFAULT CHECKS (Distance)
	. = ..()
	if(!.) // Disable range notice for Brawn.
		return FALSE
	// Must outside Closet to target anyone!
	if(!isturf(owner.loc))
		return FALSE
	// Target Type: Living
	if(isliving(target_atom))
		return TRUE
	// Target Type: Door
	else if(istype(target_atom, /obj/machinery/door))
		return TRUE
	// Target Type: Locker
	else if(istype(target_atom, /obj/structure/closet))
		return TRUE
	return FALSE

#undef BRAWN_BREAKOUT_LEVEL
#undef BRAWN_AIRLOCK_LEVEL
