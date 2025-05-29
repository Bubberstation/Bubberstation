/datum/reagent/consumable
	var/use_gs_icon = FALSE

/obj/item/reagent_containers/food/drinks/drinkingglass/on_reagent_change(changetype)
	icon = 'icons/obj/drinks.dmi'
	if(reagents.reagent_list.len)
		var/datum/reagent/R = reagents.get_master_reagent()
		if(istype(R, /datum/reagent/consumable))
			var/datum/reagent/consumable/C = R
			if(C.use_gs_icon == TRUE)
				icon = 'GainStation13/icons/obj/drinks.dmi'

	..()
