// what a broken order ships in. players should never see one
/obj/structure/closet/crate/secure/error
	name = "ERROR crate"
	desc = "This crate should never exist under any circumstances, for any reason. If you can see this, something has gone terribly wrong. Please report it to your nearest bluespace technician or coder immediately pursuant to Nanotrasen Regulation §404."
	icon = 'modular_zubbers/icons/obj/closets/error_crate.dmi'
	icon_state = "errorcrate"
	base_icon_state = "errorcrate"
	abstract_type = /obj/structure/closet/crate/secure/error
	// set when salvage() ran, meaning the order arrived incomplete and the buyer gets refunded
	var/salvaged = FALSE

/obj/structure/closet/crate/secure/error/PopulateContents()
	. = ..()
	new /obj/item/paper/paperslip/corporate/error_crate(src)

/obj/structure/closet/crate/secure/error/closet_update_overlays(list/new_overlays)
	. = ..()
	. += emissive_appearance(icon, "[icon_state]_emissive", src, alpha = alpha)

// spawns whatever it can from a contents list and skips anything that isn't a real path. takes path = amount or flat path lists
/obj/structure/closet/crate/secure/error/proc/salvage(list/contents_to_try)
	salvaged = TRUE
	for(var/entry in contents_to_try)
		if(!ispath(entry, /atom/movable))
			continue
		var/amount = isnum(contents_to_try[entry]) ? contents_to_try[entry] : 1
		if(ispath(entry, /obj/item/stack))
			new entry(src, min(amount, MAX_STACK_SIZE))
			continue
		for(var/i in 1 to min(amount, 50))
			new entry(src)

// locks it the same way generate() locks a normal order crate
/obj/structure/closet/crate/secure/error/proc/lock_for(datum/supply_pack/pack, datum/bank_account/paying_account)
	if(paying_account)
		AddComponent(/datum/component/locked_to_account, paying_account)
		return
	if(pack?.access)
		req_access = list(pack.access)
	if(pack?.access_any)
		req_one_access = pack.access_any

/obj/item/paper/paperslip/corporate/error_crate
	name = "bug report card"
	desc = "A small card that came with an ERROR crate. It looks urgent."
	color = COLOR_MAGENTA
	default_raw_text = "<b>NO SERIOUSLY THIS IS A BUG PLEASE REPORT IT</b>"

// FALSE if anything in the list isn't a real path that can be spawned
/proc/supply_contents_valid(list/contents_to_check)
	for(var/entry in contents_to_check)
		if(!ispath(entry, /atom/movable))
			return FALSE
	return TRUE

// set by consoles that charge up front, so a broken order can refund the buyer
/datum/supply_order/var/datum/bank_account/refund_account
/datum/supply_order/var/refund_amount = 0

// used when generate() came back with nothing at all
/datum/supply_order/proc/ship_in_error_crate(atom/target)
	var/obj/structure/closet/crate/secure/error/salvage_crate = new(target)
	salvage_crate.salvage(pack.contains)
	salvage_crate.lock_for(pack, paying_account)
	stack_trace("Order #[id] ([pack.type]) failed to generate and shipped in an error crate.")
	message_admins("Cargo order #[id] ([pack.name]) failed to generate and shipped in an ERROR crate. Report this to a coder.")
	return salvage_crate

/datum/supply_order/proc/refund_failed(datum/bank_account/refund_to, amount)
	if(!refund_to || !amount)
		return
	refund_to.adjust_money(amount, "Cargo: refund for [pack.name]")
	refund_to.bank_card_talk("Cargo order #[id] ([pack.name]) hit an error. Whatever could be shipped is in an ERROR crate, and [amount] [MONEY_NAME] have been refunded.")
	log_econ("Cargo order #[id] ([pack.name]) shipped broken and [amount] was refunded to [refund_to.account_holder].")
