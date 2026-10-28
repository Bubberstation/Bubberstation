
#define DENY_SOUND_COOLDOWN (2 SECONDS)

/// locks a crate so only the person (or department) who bought it can open it
/datum/component/locked_to_account
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	/// the bank account that bought this crate. whoevers ID matches this account (or department) can open it
	var/datum/bank_account/buyer_account
	/// cooldown so the "denied" buzz so sound doesnt spam if someone keeps trying really hard
	COOLDOWN_DECLARE(deny_cooldown)

/datum/component/locked_to_account/Initialize(datum/bank_account/buyer_account)
	. = ..()
	if(!istype(parent, /obj/structure/closet))
		return COMPONENT_INCOMPATIBLE
	src.buyer_account = buyer_account

/// if AddComponent is called again on this crate, update buyer_account instead of making a duplicate
/datum/component/locked_to_account/InheritComponent(datum/component/locked_to_account/new_comp, i_am_original, datum/bank_account/buyer_account)
	src.buyer_account = buyer_account

/datum/component/locked_to_account/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_emag))
	RegisterSignal(parent, COMSIG_CLOSET_PRE_OPEN, PROC_REF(on_pre_open))

/datum/component/locked_to_account/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_ATOM_EXAMINE,
		COMSIG_ATOM_EMAG_ACT,
		COMSIG_CLOSET_PRE_OPEN,
	))

/// adds a note to the examine text saying its account-locked
/datum/component/locked_to_account/proc/on_examine(obj/structure/closet/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	// BUBBER EDIT ADDITION BEGIN - departmental locks open for a whole department, so say so
	if(istype(buyer_account, /datum/bank_account/department))
		examine_list += span_warning("An account lock prevents this from opening except by [buyer_account.account_holder] personnel.")
		return
	// BUBBER EDIT ADDITION END
	examine_list += span_warning("An account lock prevents this from opening except by the purchasing account holder.")

// BUBBER EDIT ADDITION BEGIN - the crate's own lock needs this check too, see modular_zubbers/code/modules/cargo/account_crates.dm
/**
 * Returns TRUE if [user] is holding an ID that satisfies this lock.
 * A departmental lock accepts anyone paid by that department, a personal one only the buyer.
 * * source: the crate, only used to play the denial sound. Optional.
 * * silent: if FALSE, tells the user why they were turned away.
 */
/datum/component/locked_to_account/proc/account_matches(mob/living/user, obj/structure/closet/source, silent = TRUE)
	if(isnull(user))
		return FALSE

	var/obj/item/card/id/id_card = user.get_idcard(TRUE)
	if(isnull(id_card))
		if(!silent)
			deny(source, user, "No ID detected!")
		return FALSE

	if(!id_card.registered_account)
		if(!silent)
			deny(source, user, "No linked bank account detected!")
		return FALSE

	if(istype(buyer_account, /datum/bank_account/department))
		var/datum/bank_account/department/department_account = buyer_account
		if(id_card.registered_account.account_job?.paycheck_department == department_account.department_id)
			return TRUE
	else if(id_card.registered_account == buyer_account)
		return TRUE

	if(!silent)
		deny(source, user, "Bank account does not match with buyer!")
	return FALSE
// BUBBER EDIT ADDITION END

/**
 * runs when someone tries to open the crate, checks their ID against buyer_account
 * * force: if TRUE, the open bypasses this lock entirely (e.g. admin or code-forced opens)
 */
/datum/component/locked_to_account/proc/on_pre_open(obj/structure/closet/source, mob/living/user, force)
	SIGNAL_HANDLER
	if(force)
		return NONE

	// BUBBER EDIT BEGIN - the ID and account checks below were pulled out into account_matches(), so on_pre_open() and can_unlock() can share one implementation
	/* BUBBER EDIT REMOVAL BEGIN - ORIGINAL:
	if(isnull(user))
		return BLOCK_OPEN

	var/obj/item/card/id/id_card = user.get_idcard(TRUE) // the ID card the user is holding/wearing, used to check their linked bank account
	if(isnull(id_card))
		deny(source, user, "No ID detected!")
		return BLOCK_OPEN

	if(!id_card.registered_account)
		deny(source, user, "No linked bank account detected!")
		return BLOCK_OPEN

	var/is_department = istype(buyer_account, /datum/bank_account/department) // department orders check the user's paycheck department instead of a personal account match.  TRUE if this user is allowed to open the crate
	var/datum/bank_account/department/dept_account = buyer_account
	var/account_matches = is_department \
		? (id_card.registered_account?.account_job?.paycheck_department == dept_account.department_id) \
		: (id_card.registered_account == buyer_account)

	if(!account_matches)
		deny(source, user, "Bank account does not match with buyer!")
		return BLOCK_OPEN
	*/ // BUBBER EDIT REMOVAL END
	if(!account_matches(user, source, silent = FALSE))
		return BLOCK_OPEN
	// BUBBER EDIT END

	if(iscarbon(user))
		source.add_fingerprint(user)
	remove_lock(source, user)
	return NONE

/datum/component/locked_to_account/proc/deny(obj/structure/closet/source, mob/living/user, message)
	to_chat(user, span_warning(message))
	if(COOLDOWN_FINISHED(src, deny_cooldown))
		playsound(source, 'sound/machines/buzz/buzz-two.ogg', 30, TRUE)
		COOLDOWN_START(src, deny_cooldown, DENY_SOUND_COOLDOWN)

/// emag skips this whole check and goes straight to remove_lock
/datum/component/locked_to_account/proc/on_emag(obj/structure/closet/source, mob/emagger)
	SIGNAL_HANDLER
	emagger.balloon_alert(emagger, "account lock bypassed")
	remove_lock(source, emagger)

/// unlocks the crate  and removes this component
/datum/component/locked_to_account/proc/remove_lock(obj/structure/closet/source, mob/user)
	source.visible_message(span_notice("[source]'s account lock disengages with a soft click."))
	to_chat(user, span_notice("You unlock [source]."))
	source.update_appearance()
	qdel(src)

#undef DENY_SOUND_COOLDOWN
