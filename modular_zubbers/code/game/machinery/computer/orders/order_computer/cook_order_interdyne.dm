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
	order_categories = list(
		CATEGORY_FRUITS_VEGGIES,
		CATEGORY_MILK_EGGS,
		CATEGORY_SAUCES_REAGENTS,
	)
	blackbox_key = null
	forced_express = TRUE

	/// The account to add balance
	var/credits_account = ACCOUNT_INT
	/// The resolved bank account
	var/datum/bank_account/synced_bank_account = null

/obj/machinery/computer/order_console/cook/interdyne/LateInitialize()
	. = ..()
	synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)

/obj/machinery/computer/order_console/cook/interdyne/ui_data(mob/user)
	var/list/data = ..()
	data["points"] = !synced_bank_account ? 0 : synced_bank_account.account_balance
	return data

/**
 * This partically rewrites base behavior for express orders, and to subtract from department account
 */
/obj/machinery/computer/order_console/cook/interdyne/ui_act(action, params)
	if(action != "express")//fallback to base behavior
		return ..()
	if(!isliving(usr))
		return
	var/mob/living/living_user = usr
	if(!grocery_list.len || !COOLDOWN_FINISHED(src, order_cooldown))
		return
	if(!synced_bank_account)
		synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)
	if(!purchase_items())
		return
	var/say_message = "Thank you for your purchase!"
	if(express_cost_multiplier > 1)
		say_message += " Please note: The charge of this purchase and machine cooldown has been multiplied by [express_cost_multiplier]!"
	COOLDOWN_START(src, order_cooldown, cooldown_time * express_cost_multiplier)
	say(say_message)
	var/list/ordered_paths = list()
	for(var/datum/orderable_item/item as anything in grocery_list)//every order
		if(!(item.category_index in order_categories))
			stack_trace("[src] somehow delivered [item] which is not purchasable at this order console.")
			grocery_list.Remove(item)
			continue
		for(var/amt in 1 to grocery_list[item])//every order amount
			ordered_paths += item.item_path
	podspawn(list(
		"target" = get_turf(living_user),
		"style" = STYLE_BLUESPACE,
		"spawn" = ordered_paths,
	))
	grocery_list.Cut()
	return TRUE

/obj/machinery/computer/order_console/cook/interdyne/purchase_items()
	if(!synced_bank_account)
		say("Error, no department account found. Please report to Gorlex Industries.")
		return FALSE
	var/final_cost = round(get_total_cost() * express_cost_multiplier)
	if(synced_bank_account.adjust_money(-final_cost, "[name]: Purchase"))
		return TRUE
	say("Sorry, but you do not have enough [credit_type].")
	return FALSE
