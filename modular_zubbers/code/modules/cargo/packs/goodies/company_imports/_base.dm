#define CARGO_CUT 0.05

/datum/supply_pack/company_import
	desc = "Contains one imported company item."
	group = "Company Imports"
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE
	crate_name = "import package"
	allow_non_private_purchase = TRUE
	var/obj/item/item_type

/datum/supply_pack/company_import/New()
	. = ..()
	if(!item_type)
		return
	contains = list(item_type)
	name = "[item_type::name] Single-Pack"
	if(desc == initial(desc))
		desc = "Contains one [item_type::name]."
	if(CONFIG_GET(flag/permit_pins) && item_type && istype(item_type, /obj/item/gun))
		desc += " The gun will come with a permit pin installed."

/datum/supply_pack/company_import/generate(atom/A, datum/bank_account/paying_account, crate_override)
	. = ..()
	var/datum/bank_account/cargo_dep = SSeconomy.get_dep_account(ACCOUNT_CAR)
	cargo_dep.account_balance += round(cost * CARGO_CUT)
	if(!(CONFIG_GET(flag/permit_pins)))
		return
	var/obj/structure/container = .
	for(var/obj/item/gun/gun_actually in container.contents)
		QDEL_NULL(gun_actually.pin)
		var/obj/item/firing_pin/permit_pin/new_pin = new(gun_actually)
		gun_actually.pin = new_pin

#undef CARGO_CUT
