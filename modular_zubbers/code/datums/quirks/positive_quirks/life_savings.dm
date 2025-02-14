/datum/quirk/life_savings
	name = "Life Savings"
	desc = "Rich are getting richer. Either because of your smart investments or your broad connections you receive additional currency with each paycheck. Use them wisely or blow it all on drugs. They are yours after all."
	icon = FA_ICON_PIGGY_BANK
	value = 4
	hardcore_value = -4
	medical_record_text = "Patient may have a significant sum in their pocket. Maybe you should ask for some. It would be fair."
	mail_goodies = list(
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c200,
		/obj/item/stack/spacecash/c500,
	)

	/// The account of our current holder, for unregistering signals
	var/datum/bank_account/owner_account = null

/datum/quirk/life_savings/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!human_holder.account_id)
		return
	var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[human_holder.account_id]"]
	owner_account = account
	RegisterSignal(account, COMSIG_ON_BANK_ACCOUNT_PAYOUT, PROC_REF(post_payout))

/datum/quirk/life_savings/proc/post_payout(datum/bank_account/account)
	SIGNAL_HANDLER
	if(!istype(account))
		CRASH("post_payout() called on non-account datum, WTF?!")
	var/funds = round(PAYCHECK_CREW * 0.25)
	account.adjust_money(funds, "Personal fund")
	SSblackbox.record_feedback("amount", "personal_income", funds)
	SSeconomy.station_target += funds // Somehow this does not contribute to inflation
	log_econ("[funds] credits were given to [account.account_holder]'s account from life savings.")

/datum/quirk/life_savings/remove()
	. = ..()
	UnregisterSignal(owner_account, COMSIG_ON_BANK_ACCOUNT_PAYOUT)
