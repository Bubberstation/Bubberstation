/obj/item/smokable/black_tar
	name = "black tar heroin"
	desc = "A rock of black tar heroin, an impure freebase form of heroin."
	icon = 'modular_zubbers/modules/morenarcotics/icons/crack.dmi'
	icon_state = "blacktar"

	smokable_reagent = /datum/reagent/drug/black_tar
	reagent_amount = 5

/datum/export/black_tar
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "black tar heroin"
	export_types = list(/obj/item/smokable/black_tar)
	include_subtypes = FALSE
