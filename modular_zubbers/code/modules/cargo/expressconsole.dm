/obj/item/circuitboard/computer/cargo/express/interdyne
	name = "Interdyne Express Supply Console"
	build_path = /obj/machinery/computer/cargo/express/interdyne
	contraband = TRUE

/obj/machinery/computer/cargo/express/interdyne
	name = "interdyne express supply console"
	desc = "A standard NT express console, hacked by Gorlex industries to use \
	their own experimental \"1100mm Rail Cannon\", made to be extra robust to prevent \
	being emagged by the Syndicate cadets of the SSV Dauntless."
	circuit = /obj/item/circuitboard/computer/cargo/express/interdyne
	req_access = list(ACCESS_SYNDICATE)

	podType = /obj/structure/closet/supplypod/bluespacepod

	cargo_account = ACCOUNT_INT

/obj/machinery/computer/cargo/express/interdyne/attackby(obj/item/W, mob/living/user, params)
	if(iscash(W))
		var/obj/item/money = W
		var/physical_currency = FALSE
		if(istype(money, /obj/item/stack/spacecash) || istype(money, /obj/item/coin))
			physical_currency = TRUE
		var/cash_money = money.get_item_credit_value()
		if(!cash_money)
			to_chat(user, span_warning("[money] doesn't seem to be worth anything!"))
			return
		var/datum/bank_account/synced_bank_account = SSeconomy.get_dep_account(cargo_account)
		synced_bank_account.adjust_money(cash_money)
		log_econ("[cash_money] credits were inserted into [src]")
		if(physical_currency)
			to_chat(user, span_notice("You stuff [money] into [src]. It disappears in a small puff of bluespace smoke, adding [cash_money] credits to the linked account."))
		else
			to_chat(user, span_notice("You insert [money] into [src], adding [cash_money] credits to the linked account."))
		qdel(money)
	. = ..()

/obj/machinery/computer/cargo/express/interdyne/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(user)
		to_chat(user, span_notice("You try to change the routing protocols, however the machine displays a runtime error and reboots."))
	return FALSE//never let this console be emagged

/obj/machinery/computer/cargo/express/interdyne/ui_act(action, params, datum/tgui/ui)
	if(action == "add")//if we're generating a supply order
		if (!beacon || !usingBeacon)//if not using beacon
			say("Error! Destination is not whitelisted, aborting.")
			return
	. = ..()
