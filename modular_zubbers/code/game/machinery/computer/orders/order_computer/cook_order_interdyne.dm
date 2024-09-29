/**
 * # Syndicate Produce Orders Console
 *
 * A produce orders console modified to use a specified department account, and only allow express orders
 *
 * This file is based off of order_computer.dm
 * Any changes made to that file should be copied over with discretion
 */

/obj/item/circuitboard/computer/order_console/interdyne
	name = "Interdyne Produce Orders Console"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/computer/order_console/cook/interdyne

/obj/machinery/computer/order_console/cook/interdyne
	name = "interdyne produce orders console"
	desc = "An interface for ordering fresh produce and other. The cornerstone of any nutritious meal for the Syndicate crew."
	circuit = /obj/item/circuitboard/computer/order_console/interdyne
	blackbox_key = null
	forced_express = TRUE

	/// The account to add balance
	var/credits_account = ACCOUNT_INT
	/// The resolved bank account
	var/datum/bank_account/synced_bank_account = null

/obj/machinery/computer/order_console/cook/interdyne/post_machine_initialize()
	. = ..()
	synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)

/obj/machinery/computer/order_console/cook/interdyne/ui_data(mob/user)
	var/list/data = ..()
	data["points"] = !synced_bank_account ? 0 : synced_bank_account.account_balance
	return data

/obj/machinery/computer/order_console/cook/interdyne/purchase_items(obj/item/card/id/card, express = FALSE)
	if(!synced_bank_account)
		say("Error, no department account found. Please report to Gorlex Industries.")
		return FALSE
	var/final_cost = round(get_total_cost() * (express ? express_cost_multiplier : cargo_cost_multiplier))
	if(synced_bank_account.adjust_money(-final_cost, "[name]: Purchase"))
		return TRUE
	say("Sorry, but you do not have enough [credit_type].")
	return FALSE
