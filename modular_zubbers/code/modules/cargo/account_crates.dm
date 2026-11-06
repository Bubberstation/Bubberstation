/**
 * Crates for supply orders that were paid for by a specific bank account.
 *
 * An order bought from a departmental budget arrives in that department's own crate and opens
 * for anyone drawing a paycheck from that department. Anything else paid for by an account
 * arrives in a plain commercial crate that only the buyer can open. In both cases the lock is
 * the account lock, not the supply pack's own access requirement.
 */

/// A secure crate in the medical department's colours. The lock light is added by closet_update_overlays().
/obj/structure/closet/crate/secure/medical
	name = "secure medical crate"
	desc = "A crate with a lock on it, painted in the scheme of the station's medical staff."
	icon_state = "medicalcrate"
	base_icon_state = "medicalcrate"

/// The crate a privately purchased order arrives in.
/obj/structure/closet/crate/secure/commercial
	name = "commercial crate"
	desc = "A crate cover designed to only open for whoever purchased its contents."
	icon_state = "privatecrate"
	base_icon_state = "privatecrate"

/**
 * Returns the crate typepath that an order paid for by [paying_account] should arrive in.
 * Departmental budgets get their department's crate, everything else gets the commercial crate.
 */
/proc/get_account_crate_type(datum/bank_account/paying_account)
	if(!istype(paying_account, /datum/bank_account/department))
		return /obj/structure/closet/crate/secure/commercial

	var/static/list/crates_by_department = list(
		ACCOUNT_CAR = /obj/structure/closet/crate/secure/cargo,
		ACCOUNT_CIV = /obj/structure/closet/crate/secure/centcom,
		ACCOUNT_CMD = /obj/structure/closet/crate/secure/centcom,
		ACCOUNT_ENG = /obj/structure/closet/crate/secure/engineering,
		ACCOUNT_INT = /obj/structure/closet/crate/secure/syndicate/interdyne,
		ACCOUNT_MED = /obj/structure/closet/crate/secure/medical,
		ACCOUNT_SCI = /obj/structure/closet/crate/secure/science,
		ACCOUNT_SEC = /obj/structure/closet/crate/secure/weapon,
		ACCOUNT_SRV = /obj/structure/closet/crate/secure/hydroponics,
	)

	var/datum/bank_account/department/department_account = paying_account
	return crates_by_department[department_account.department_id] || /obj/structure/closet/crate/secure/commercial

/**
 * A crate carrying an account lock answers to that lock rather than to its access requirement.
 * can_open() refuses outright while the crate is locked, so the component's own open hook never
 * gets a look in until the latch has been released here first.
 */
/obj/structure/closet/crate/secure/can_unlock(mob/living/user, obj/item/card/id/player_id, obj/item/card/id/registered_id)
	var/datum/component/locked_to_account/account_lock = GetComponent(/datum/component/locked_to_account)
	if(isnull(account_lock))
		return ..()
	return account_lock.account_matches(user)
