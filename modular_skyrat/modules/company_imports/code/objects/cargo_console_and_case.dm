/obj/machinery/computer/cargo/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armament/company_imports, subtypesof(/datum/armament_entry/company_import), 0)

/obj/item/storage/lockbox/order
	/// Bool if this was departmentally ordered or not
	var/department_purchase
	/// Department of the person buying the crate if buying via the NIRN app.
	var/datum/bank_account/department/department_account

/obj/structure/closet/crate/large/import
	name = "heavy-duty wooden crate"
	icon = 'modular_skyrat/modules/company_imports/icons/import_crate.dmi'
