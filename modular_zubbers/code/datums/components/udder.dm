/obj/item/udder/gutlunch/generate()
	if(!isnull(require_consume_type) && !(locate(require_consume_type) in src))
		return FALSE
	if(!prob(production_probability))
		return FALSE

	var/list/reagents_to_add = list()

	for(var/obj/item/stack/ore/ore in src)
		if(istype(ore, /obj/item/stack/ore/glass))
			reagents_to_add += /datum/reagent/consumable/milk
		else if(istype(ore, /obj/item/stack/ore/gold))
			reagents_to_add += /datum/reagent/consumable/cream
		else if(istype(ore, /obj/item/stack/ore/bluespace_crystal))
			reagents_to_add += /datum/reagent/medicine/salglu_solution
		else
			reagents_to_add += reagent_produced_typepath

	var/amount_total = rand(5,10)

	for(var/reagent_type in reagents_to_add)
		reagents.add_reagent(reagent_type, amount_total/reagents_to_add.len, added_purity = 1)

	if(on_generate_callback)
		on_generate_callback.Invoke(reagents.total_volume, reagents.maximum_volume)
