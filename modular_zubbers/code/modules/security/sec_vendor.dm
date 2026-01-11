
/obj/item/security_voucher
	name = "security voucher"
	desc = "A token to redeem a piece of equipment. Use it on a SecTech vendor."
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "security_voucher_primary"
	w_class = WEIGHT_CLASS_TINY

/obj/item/security_voucher/primary
	name = "security primary voucher"
	icon_state = "security_voucher_primary"

/obj/item/security_voucher/utility
	name = "security utility voucher"
	icon_state = "security_voucher_utility"

/obj/machinery/vending/security/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/security_voucher))
		redeem_voucher(weapon, user)
		return
	return ..()

/obj/machinery/vending/security/proc/redeem_voucher(obj/item/security_voucher/voucher, mob/redeemer)
	var/static/list/set_types

	var/voucher_set = /datum/voucher_set/security

	if(istype(voucher, /obj/item/security_voucher/primary))
		voucher_set = /datum/voucher_set/security/primary
	if(istype(voucher, /obj/item/security_voucher/utility))
		voucher_set = /datum/voucher_set/security/utility
	set_types = list()
	for(var/datum/voucher_set/static_set as anything in subtypesof(voucher_set))
		set_types[initial(static_set.name)] = new static_set

	var/list/items = list()
	for(var/set_name in set_types)
		var/datum/voucher_set/current_set = set_types[set_name]
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = current_set.icon, icon_state = current_set.icon_state)
		option.info = span_boldnotice(current_set.description)
		items[set_name] = option

	var/selection = show_radial_menu(redeemer, src, items, custom_check = FALSE, radius = 38, require_near = TRUE, tooltips = TRUE)
	if(!selection)
		return

	var/datum/voucher_set/chosen_set = set_types[selection]
	playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
	for(var/item in chosen_set.set_items)
		new item(drop_location())

	SSblackbox.record_feedback("tally", "security_voucher_redeemed", 1, selection)
	qdel(voucher)
