/obj/item/smokable/meth
	name = "crystal meth"
	desc = "A smokable crystaline form of methamphetamine."
	icon = 'modular_zubbers/modules/morenarcotics/icons/crack.dmi'
	icon_state = "meth"
	color = "#78C8FA"

	smokable_reagent = /datum/reagent/drug/methamphetamine/crystal
	reagent_amount = 10

/obj/item/smokable/meth/proc/update_icon_purity(purity)
	var/effective_impurity = min(1, (1 - purity) / 0.5)
	color = BlendRGB(initial(color), "#FAFAFA", effective_impurity)
	update_icon()

/datum/export/meth
	cost = CARGO_CRATE_VALUE * 0.75
	unit_name = "crack"
	export_types = list(/obj/item/smokable/meth)
	include_subtypes = FALSE

