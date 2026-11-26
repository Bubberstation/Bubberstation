/**
 * # Torpor
 *
 * Torpor is what deals with the Vampire falling asleep, their healing, the effects, ect.
 * They can trigger it manually if they wish to heal, as Burn is only healed through Torpor.
 * You cannot manually exit Torpor, it is instead entered/exited by:
 *
 * Torpor is triggered by:
 * - Entering a Coffin with more than 10 combined Brute/Burn damage, dealt with by /closet/crate/coffin/close() [coffins.dm]
 * - Death, dealt with by /HandleDeath()
 * Torpor is ended by:
 * - Having no more than TORPOR_DAMAGE_THRESHOLD Brute damage while OUTSIDE of your Coffin.
 * - Having no more than TORPOR_DAMAGE_THRESHOLD Brute & Burn Combined and no missing limbs while INSIDE of your Coffin.
 * Only damage we can heal counts, see get_healable_brute() and get_healable_burn().
**/
#define TORPOR_DAMAGE_THRESHOLD 10

/datum/antagonist/vampire/proc/check_begin_torpor()
	var/mob/living/carbon/carbon_owner = owner.current
	if(QDELETED(carbon_owner))
		return
	var/total_damage = get_healable_brute() + get_healable_burn()
	if(total_damage > TORPOR_DAMAGE_THRESHOLD || length(carbon_owner.all_wounds) || length(carbon_owner.get_missing_limbs()))
		carbon_owner.apply_status_effect(/datum/status_effect/vampire_torpor)

/datum/status_effect/vampire_torpor
	id = "torpor"
	alert_type = null
	remove_on_fullheal = TRUE
	heal_flag_necessary = HEAL_ADMIN // so admins can aheal in case stuff goes fucky wucky
	/// Antag datum of the vampire.
	var/datum/antagonist/vampire/vampire_datum
	/// Cooldown twhere, if it finishes, we'll just force heal the vampire, to avoid eternal torpor.
	COOLDOWN_DECLARE(force_heal_time)
	/// While true, torpor only ends due to frenzy
	var/held = FALSE
	/// List of traits applied while in torpor.
	var/static/list/torpor_traits = list(
		TRAIT_DEATHCOMA,
		TRAIT_FAKEDEATH,
		TRAIT_NODEATH,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_TORPOR,
	)

/datum/status_effect/vampire_torpor/on_apply()
	if(!iscarbon(owner) || QDELING(owner))
		return FALSE
	vampire_datum = IS_VAMPIRE(owner)
	if(!vampire_datum)
		. = FALSE
		CRASH("Attempted to apply [type] to a non-vampire!")
	if(vampire_datum.final_death)
		return FALSE
	REMOVE_TRAIT(owner, TRAIT_SLEEPIMMUNE, TRAIT_VAMPIRE)
	owner.add_traits(torpor_traits, TRAIT_STATUS_EFFECT(id))
	owner.remove_status_effect(/datum/status_effect/jitter)
	vampire_datum.disable_all_powers()
	to_chat(owner, span_notice("You enter the horrible slumber of deathless Torpor. You will heal until you are renewed."))
	COOLDOWN_START(src, force_heal_time, 5 MINUTES)
	return TRUE

/datum/status_effect/vampire_torpor/on_remove()
	if(held)
		release_hold()
	if(!iscarbon(owner) || vampire_datum.final_death)
		return

	owner.grab_ghost()
	owner.remove_traits(torpor_traits, TRAIT_STATUS_EFFECT(id))
	if(!HAS_TRAIT(owner, TRAIT_BLUSH_OF_LIFE))
		ADD_TRAIT(owner, TRAIT_SLEEPIMMUNE, TRAIT_VAMPIRE)

	vampire_datum.heal_vampire_organs()
	vampire_datum.my_clan?.on_exit_torpor()
	vampire_datum = null

	to_chat(owner, span_notice("You have recovered from Torpor."))

/datum/status_effect/vampire_torpor/proc/hold_until_login()
	if(held || owner.client)
		return
	held = TRUE
	RegisterSignal(owner, COMSIG_MOB_LOGIN, PROC_REF(release_hold))
	RegisterSignal(owner, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(on_held_damage))

/datum/status_effect/vampire_torpor/proc/release_hold(datum/source)
	SIGNAL_HANDLER
	held = FALSE
	UnregisterSignal(owner, list(COMSIG_MOB_LOGIN, COMSIG_MOB_AFTER_APPLY_DAMAGE))
	COOLDOWN_START(src, force_heal_time, 5 MINUTES)

/datum/status_effect/vampire_torpor/proc/on_held_damage(mob/living/source, damage_dealt)
	SIGNAL_HANDLER
	if(!held || damage_dealt <= 0)
		return
	release_hold()
	to_chat(source.get_ghost(TRUE, TRUE) || source, span_userdanger("Your body is under attack! You are pulled back into it."))
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(qdel), src)

/datum/status_effect/vampire_torpor/tick(seconds_between_ticks)
	if(held && !HAS_TRAIT(owner, TRAIT_FRENZY))
		return
	if(should_end())
		qdel(src)
		return

	if(COOLDOWN_FINISHED(src, force_heal_time) && !QDELETED(owner))
		log_game("[key_name(owner)] was in Torpor for 5 minutes, immediately reviving them to prevent a potential softlock.")
		owner.revive(HEAL_ALL)
		qdel(src)

/datum/status_effect/vampire_torpor/proc/should_end()
	if(HAS_TRAIT(owner, TRAIT_FRENZY))
		return TRUE
	var/total_brute = vampire_datum.get_healable_brute()
	var/total_burn = vampire_datum.get_healable_burn()

	if(total_burn >= 199)
		return FALSE

	// You are in a coffin, so instead we'll check TOTAL damage.
	if(istype(owner.loc, /obj/structure/closet/crate/coffin))
		var/mob/living/carbon/carbon_owner = owner
		if((total_brute + total_burn) <= TORPOR_DAMAGE_THRESHOLD && !length(carbon_owner.get_missing_limbs()))
			owner.heal_overall_damage(brute = 10, burn = 10) // heal minor leftover damage
			return TRUE
	else if(total_brute <= TORPOR_DAMAGE_THRESHOLD)
		owner.heal_overall_damage(brute = 10) // heal minor leftover damage
		return TRUE

	return FALSE

#undef TORPOR_DAMAGE_THRESHOLD
