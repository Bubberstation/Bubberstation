/datum/chemical_reaction/crystal_meth
	required_reagents = list(/datum/reagent/drug/methamphetamine = 10, /datum/reagent/hydrogen = 5, /datum/reagent/chlorine = 5)
	is_cold_recipe = TRUE
	required_temp = 250 //freeze it
	reaction_flags = REACTION_INSTANT
	reaction_flags_bubber = REACTION_KEEP_INSTANT_REQUIREMENTS
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING

/datum/chemical_reaction/crystal_meth/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)

	// get the purity from the holder (can only do this because we arent deleting the ingredients yet)
	var/datum/reagent/used_reagent = holder.has_reagent(/datum/reagent/drug/methamphetamine)
	var/saved_purity = used_reagent.creation_purity

	// create the result
	for(var/i in 1 to created_volume)
		var/obj/item/smokable/meth/created_meth = new(location)
		var/datum/reagent/drug/methamphetamine/crystal/created_reagent = created_meth.reagents.has_reagent(/datum/reagent/drug/methamphetamine/crystal)
		created_reagent.creation_purity = saved_purity
		created_reagent.purity = saved_purity
		created_meth.update_icon_purity(saved_purity)
		created_meth.pixel_x = rand(-6, 6)
		created_meth.pixel_y = rand(-6, 6)

	// and finally delete the initial ingredients
	for(var/used_reagent_type in required_reagents)//this is not an object
		holder.remove_reagent(used_reagent_type, (created_volume * required_reagents[used_reagent_type]), safety = 1)

/datum/reagent/drug/methamphetamine/crystal
	name = "Crystal methamphetamine"
	addiction_types = list(/datum/addiction/stimulants = 55)
	metabolization_rate = 0.05
